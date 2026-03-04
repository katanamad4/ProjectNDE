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
    for _, entity in ipairs(self.entities) do
        if entity.update then
            entity:update()
        end
    end
    
    -- collision pass
    for _, ent in ipairs(self.entities) do
        if ent.type == "player" then
            for _, other in ipairs(self.entities) do
                if other.type == "bullet"
                and colision.circle_circle(ent, other)
                and ent.invincible <= 0
                then
                    ent:hit()
                end
            end
        end
    end
    state.time = state.time + 1
    state.player = state.current_level.entities.player
end

function level:draw()
    for _, entity in ipairs(self.entities) do
        if entity.draw then
            entity:draw()
        end
    end
end

return level