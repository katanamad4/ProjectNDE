local vector = require("vector")
local state = require("state")



return function(pos, sprite)
    entity = {}
    entity.__index = entity
    entity.pos = pos
    entity.velocity = vector.new()
    entity.radius = 3.0
    entity.maxspeed = 4.0
    entity.sprite = love.graphics.newImage(state.sprites[sprite])
    entity.scale = 0.8

    entity.draw = function(self)
        local ox = self.sprite:getWidth() / 2
        local oy = self.sprite:getHeight() / 2
        love.graphics.setColor(state.palette.white)
        love.graphics.draw(self.sprite, self.pos.x, self.pos.y, 0, self.scale, self.scale, ox, oy)
        if state.keys_down.focus then 
            love.graphics.setColor(state.palette.red)
            love.graphics.circle("fill", self.pos.x, self.pos.y, self.radius)
        end
    end

    entity.update = function(self)
        self.velocity = vector.limit(state.movement_vector * self.maxspeed, self.maxspeed)
        self.pos = self.pos + self.velocity
    end
    return entity
end