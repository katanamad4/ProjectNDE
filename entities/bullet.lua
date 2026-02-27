state = require("state")
vector = require("vector")

return function(pos, velocity, acceleration, size, bullet_type)
    entity = {}
    entity.__index = entity
    entity.pos = pos
    entity.velocity = velocity
    entity.acceleration = acceleration
    entity.size = size
    entity.bullet_type = bullet_type

    entity.draw = function(self)
        love.graphics.setColor(state.palette[3])
        love.graphics.circle("fill", self.pos.x, self.pos.y, self.size)
    end

    entity.update = function(self)
        self.pos = self.pos + self.velocity
        self.velocity = self.velocity + self.acceleration
    end

    return entity
end
