local vector = require("vector")
local state = require("state")

return function(pos, velocity, acceleration, radius, sprite_key, color)
    local entity = {}
    entity.__index = entity
    entity.type = "shot"
    entity.pos = pos
    entity.velocity = velocity
    entity.acceleration = acceleration
    entity.radius = radius
    entity.sprite_key = sprite_key
    entity.color = state.palette[color] or state.palette.white
    entity.dead = false
    entity.sprite = state.sprites[entity.sprite_key]
    entity.damage = 1

     entity.draw = function(self)
        love.graphics.setColor(state.palette.red)
        if not self.sprite or not self.sprite.image then love.graphics.print("NO SPRITE", 10, 200) end

        if self.sprite and self.sprite.image and not state.debug then
            love.graphics.setColor(self.color)
            love.graphics.draw(
                self.sprite.image,
                self.pos.x, self.pos.y,
                vector.angle(self.velocity),
                self.radius * self.sprite.scale,
                self.radius * self.sprite.scale,
                self.sprite.offset.x , self.sprite.offset.y
            )
        end

        if state.debug then
            love.graphics.setColor(state.palette.blue)
            love.graphics.circle("line", self.pos.x, self.pos.y, self.radius)
        end
    end

    entity.update = function(self)
        if not vector.pos_in_pf(self.pos) then
            self.dead = true
        end 
        self.pos = self.pos + self.velocity
        self.velocity = self.velocity + self.acceleration
    end

    return entity
end