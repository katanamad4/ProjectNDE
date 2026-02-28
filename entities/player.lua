local vector = require("vector")
local state = require("state")



return function(pos)
    entity = {}
    entity.__index = entity
    entity.pos = pos
    entity.velocity = vector.new()
    entity.radius = 5.0
    entity.maxspeed = 4.0

    entity.draw = function(self)
        love.graphics.setColor(state.palette[1])
        love.graphics.circle("fill", self.pos.x, self.pos.y, self.radius)
    end

    entity.update = function(self)
        self.velocity = vector.limit(state.movement_vector * self.maxspeed, self.maxspeed)
        self.pos = self.pos + self.velocity
    end
    return entity
end