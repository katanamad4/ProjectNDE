local colision = require("colision")
local deep = require "deep"

local level = {}

level.__index = level

level.load = function(name)
    local level_module = require("levels/" .. name)

    local self = setmetatable({}, level)
    self.entities, self.layers = level_module.load()

    return self
end



function level:update(dt)
    for groupName, group in pairs(self.entities) do
        for key, ent in ipairs(group) do
            if ent.update then
                if ent.dead then
                    table.remove(group, key)    
                end
                ent:update(dt)
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
            end
        end
    end

    state.time = state.time + 1
    state.player = state.current_level.entities.player[1]
end

function level:draw()
    for groupName, group in pairs(self.entities) do
        for key, ent in ipairs(group) do
           self.layers[groupName]:queue(key, ent:draw())
        end
    end 
   self.layers.player:draw()
   self.layers.shots:draw()
   self.layers.bullets:draw()
   self.layers.enemies:draw()
   self.layers.hud:draw()
   self.layers.debug:draw()
   

end

return level