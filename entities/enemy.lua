local vector = require("vector")
local state = require("state")
local bullet = require("entities/bullet")



return function(pos, enemy_type, sprite_key)
    local entity = {}
    entity.__index = entity
    entity.type = "enemy"
    entity.pos = pos
    entity.enemy_type = enemy_type
    entity.scale = 0.8
    
    entity.draw = function(self)
        local sprite = state.sprites[self.sprite_key]


        if not sprite or not sprite.image then return end

        if sprite and sprite.image then
            love.graphics.setColor(self.color)
            love.graphics.draw(sprite.image, self.pos.x, self.pos.y, self.scale, self.scale, sprite.offset.x , sprite.offset.y)
        end
    end

    entity.update = function()
         if enemy_type == "test" then
            if state.time % 2 == 0 then
                for i = 1, 5, 1 do
                    table.insert(state.current_level.entities, bullet(vector.new(682, 200), vector.from_angle(math.rad(i * 2 * state.time + i / 320), 3), vector.new(0,0), 3, "energyball", "orange"))
                end
            end
        end 
    end

    return entity
end