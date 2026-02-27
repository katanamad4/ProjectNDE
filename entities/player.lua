local vector = require("vector")
local state = require("state")



return function(pos_x, pos_y)
    entity = {}
    entity.__index = entity
    entity.pos = vector.new(pos_x, pos_y)
    entity.velocity = vector.new(0, 0)
    entity.radius = 5
    entity.maxspeed = 200
    entity.basespeed = 2.0

    entity.draw = function(self)
        love.graphics.setColor(state.palette[1])
        love.graphics.circle("fill", self.pos.x, self.pos.y, self.radius)
    end

    entity.update = function(self)
        self.velocity = vector.limit(state.movement_vector, self.maxspeed) * self.basespeed
        self.pos = self.velocity + self.pos
    end
    return entity
end