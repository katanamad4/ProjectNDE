state = require("state")
vector = require("vector")

return function(pos, velocity, acceleration, radius, bullet_type)
    entity = {}
    entity.__index = entity
    entity.type = "bullet"
    entity.pos = pos
    entity.velocity = velocity
    entity.acceleration = acceleration
    entity.radius = radius
    entity.bullet_type = bullet_type

    entity.draw = function(self)
        love.graphics.setColor(state.palette.blue)
        love.graphics.circle("fill", self.pos.x, self.pos.y, self.radius)
    end

    entity.update = function(self)
        self.pos = self.pos + self.velocity
        self.velocity = self.velocity + self.acceleration
    end

    return entity
end
