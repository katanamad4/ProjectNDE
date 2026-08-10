local colision = require("colision")
local deep = require "deep"

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

    self.entities, self.layers = level_module.load(self.entities, self.layers)

    return self
end



function level:update(dt)
    for groupName, group in pairs(self.entities) do
        -- for key, ent in ipairs(group) do
        local key = 1
        while key <= #group do
            local ent = group[key]

            if ent.update then
                ent:update(dt)
            end
            if ent.despawn or ent.dead then
                if ent.dead and ent.death then    
                    ent:death()
                end
                local removed = ent
                group[key] = group[#group]
                group[#group] = nil
                self.pools[groupName][#self.pools[groupName] + 1] = removed
                print("removed " .. groupName .. " "  .. key)
            else
                key = key + 1
            end
        end
    end 

    for key, bullet in ipairs(self.entities.bullets) do
        if colision.circle_circle(state.player, bullet) and state.player.invincible <= 0 then
            state.player:hit()
            bullet.dead = true
        end
    end
    for e_key, enemy in ipairs(self.entities.enemies) do 
        for s_key, shot in ipairs(self.entities.shots) do
            if colision.circle_circle(enemy, shot) and enemy.invincible <= 0 then
                enemy:hit(shot.damage)
                shot.dead = true
            end
        end
    end

    state.time = state.time + state.time_scale
    state.player = state.current_level.entities.player[1]
end

function level:draw()
    for groupName, group in pairs(self.entities) do
        for key, ent in ipairs(group) do
           self.layers[groupName]:queue(key, ent:draw())
        end
    end  
    self.layers.shots:draw()
    self.layers.player:draw()
    self.layers.bullets:draw()
    self.layers.enemies:draw()
    self.layers.hud:draw()
    self.layers.debug:draw()
   

end

return level