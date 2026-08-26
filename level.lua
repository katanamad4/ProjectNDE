local colision = require("colision")
local deep = require "deep"
local profiler = require "profiler"


local level = {}

level.__index = level

level.load = function(name)
    local level_module = require("levels/" .. name)

    local self = setmetatable({}, level)

    self.entities = {
        player = {},
        shots = {},
        bullets = {},
        enemies = {},
        hud = {},
        debug = {}
    }

    self.layers = {}
    for k, _ in pairs(self.entities) do
        self.layers[k] = deep:new()
    end
    self.pools = {}
    for groupName, group in pairs(self.entities) do
        self.pools[groupName] = {} 
        if groupName == "bullets" then
            for i = 1, 10000, 1 do
                table.insert(self.pools[groupName], {})
            end
        elseif groupName == "shots" then
            for i = 1, 1000, 1 do
                table.insert(self.pools[groupName], {})
            end
        elseif groupName == "enemies" then
            for i = 1, 100, 1 do
                table.insert(self.pools[groupName], {})
            end
        else
            for i = 1, 10, 1 do
                table.insert(self.pools[groupName], {})
            end
        end
    end
    print "pools:"
    for k, v in pairs(self.pools) do
        print(k, v , #v)
    end

    level_module.load(self)

    return self
end


function level:update(dt)
    -- print("time: " .. state.time .. " segmentTime: " .. self.segmentTime .. " segment: " .. self.currentSegment .. " Groups:") --temp
    profiler.start("updEnt")
    self:updateEntities(dt)
    profiler.stop("updEnt")


    profiler.start("Events")
    self:runEvents()
    profiler.stop("Events")

    self.segmentTime = self.segmentTime + 1
    state.time = state.time + state.time_scale
    state.player = state.current_level.entities.player[1]
    profiler:print()
end

function level:draw()
    profiler.start("draw")
    for groupName, group in pairs(self.entities) do
        for key, ent in ipairs(group) do
            self.layers[groupName]:queue(key, function()
                ent:draw()
            end)
        end
    end  
    self.layers.shots:draw()
    self.layers.player:draw()
    self.layers.enemies:draw()
    self.layers.bullets:draw()
    self.layers.hud:draw()
    self.layers.debug:draw()
    profiler.stop("draw")
   

end


function level.updateEntities(self, dt)
    for groupName, group in pairs(self.entities) do
        -- profiler.start(groupName .. "UpDate")
        local key = 1
        while key <= #group do
            local ent = group[key]
            -- print(key) --temp
            if ent.update then
                ent:update(dt)
                self:checkEntColisions(ent)
                if not vec.posInPf(ent.posX, ent.posY , state.pf_entities_border_offset) then
                    ent.despawn = true
                end 
            end
            if ent.despawn or ent.dead then
                if ent.dead and ent.death then    
                    ent:death()
                end
                local removed = ent
                group[key] = group[#group]
                group[#group] = nil
                self.pools[groupName][#self.pools[groupName] + 1] = removed
                -- print("removed " .. groupName .. " "  .. key)
            else
                key = key + 1
            end
        end
        -- profiler.stop(groupName .. "UpDate")
    end
end



function level:checkEntColisions(ent1)
    for key, ent2 in ipairs(self.entities[ent1.collides_with_group]) do
        local colisionFunc = colision.findFunc(ent1, ent2)
        if colisionFunc and colisionFunc(ent1, ent2) then
            ent1:colision(ent2)
        end
    end
    if ent1.collides_with_group2 then
        for key, ent2 in ipairs(self.entities[ent1.collides_with_group2]) do
            local colisionFunc = colision.findFunc(ent1, ent2)

            if colisionFunc and colisionFunc(ent1, ent2) then
                ent1:colision(ent2)
            end
        end
    end
end



function level.runEvents(self)
    if self.segments then 
        for eventKey, event in ipairs(self.segments[self.currentSegment]) do
            if self.segmentTime >= event.sched then
                event.event()
                if not event.incomplete then
                    table.remove(self.segments[self.currentSegment], eventKey)
                end
            end
        end
    end
end
return level