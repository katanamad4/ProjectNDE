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
    entity.sprite_key = sprite_key

    entity.draw = function(self)
        local sprite = state.sprites[self.sprite_key]


        if not sprite or not sprite.image then return end

        if sprite and sprite.image then
            love.graphics.setColor(state.palette.white)
            love.graphics.draw(
            sprite.image,
            self.pos.x,
            self.pos.y,
            0,                 
            self.scale,
            self.scale,
            sprite.offset.x,
            sprite.offset.y
            )
        end
    end

    entity.update = function()
         if enemy_type == "test" then
            if state.time % 3  == 0 then
                for i = 1, 10, 1 do
                    table.insert(state.current_level.entities, bullet(vector.new(682, 200), vector.from_angle(math.rad(i * 2 * state.time + i / 360), 3), vector.new(0,0), 3, "energyball", "orange"))
                end
            end
        end 
    end

    return entity
end