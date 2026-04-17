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
    entity.scale = 0.06
    entity.dead = false
    

     entity.draw = function(self)
        local sprite = state.sprites[self.sprite_key]
        if not sprite or not sprite.image then return end
        if sprite and sprite.image and not state.debug then
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