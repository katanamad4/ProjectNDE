local colision = require("colision")

local level = {}

level.__index = level

level.load = function(name)
    local level_module = require("levels/" .. name)

    local self = setmetatable({}, level)
    self.entities = level_module.load()

    return self
end



function level:update(dt)
    for groupName, group in pairs(self.entities) do
        print(groupName, "table update")
        for key, ent in ipairs(group) do
            if ent.update then
                if ent.dead then
                    table.remove(group, key)    
                end
                ent:update()
            end
        end
    end 

    for key, bullet in ipairs(self.entities.bullets) do
        if colision.circle_circle(state.player, bullet) and state.player.invincible <= 0 then
            state.player:hit()
            bullet.dead = true
        end
        --add colision for shots
    end

    -- for key, ent in ipairs(self.entities) do
    --     if ent.type == "player" then
    --         for _, other in ipairs(self.entities) do
    --             if other.type == "bullet"
    --             and colision.circle_circle(ent, other)
    --             and ent.invincible <= 0
    --             then
    --                 ent:hit()
    --             end
    --         end
    --     end
    --     if ent.type == "enemy" then
    --         for _, other in ipairs(self.entities) do
    --             if other.type == "shot"
    --             and colision.circle_circle(ent, other)
    --             and ent.invincible <= 0
    --             then
    --                 ent:hit(other.damage)
    --                 other.dead =  true
    --             end
    --         end
    --     end
    -- end


    state.time = state.time + 1
    state.player = state.current_level.entities.player[1]
end

function level:draw()
    for _, entity in ipairs(self.entities) do
        if entity.draw then
            entity:draw()
        end
    end
end

return level