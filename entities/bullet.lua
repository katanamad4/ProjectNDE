state = require("state")
vector = require("vector")

return function(pos, velocity, acceleration, radius, sprite_key, color)
    local entity = {}
    entity.__index = entity
    entity.type = "bullet"
    entity.pos = pos
    entity.velocity = velocity
    entity.acceleration = acceleration
    entity.radius = radius
    entity.sprite_key = sprite_key
    entity.color = state.palette[color] or state.palette.white
    entity.scale = 0.06

    entity.draw = function(self)
        local sprite = state.sprites[self.sprite_key]
        if not sprite or not sprite.image then return end

        if sprite and sprite.image then
            love.graphics.setColor(self.color)
            love.graphics.draw(sprite.image,
            self.pos.x, self.pos.y,
            vector.angle(self.velocity),
            self.radius * self.scale,
            self.radius * self.scale,
            sprite.offset.x , sprite.offset.y)
        end
        if state.debug then
            love.graphics.setColor(state.palette.blue)
            love.graphics.circle("fill", self.pos.x, self.pos.y, self.radius)
        end
    end

    entity.update = function(self)
        self.pos = self.pos + self.velocity
        self.velocity = self.velocity + self.acceleration
    end

    return entity
end
