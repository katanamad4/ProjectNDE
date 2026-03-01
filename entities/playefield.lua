local vector = require("vector")
local state = require("state")

return function(pos, dimensions)
    entity = {}
    entity.pos = pos
    entity.dimensions = dimensions
    entity.border = 5

    entity.draw = function(self)
        love.graphics.setColor(state.palette.white)
        love.graphics.rectangle(
        "fill",
        self.pos.x - self.border,
        self.pos.y + self.border,
        self.dimensions.x + self.border * 2,
        self.border
        )
        love.graphics.rectangle(
        "fill",
        self.dimensions.x + self.pos.x, 
        self.pos.y + self.border,
        self.border,
        self.dimensions.y 
        )
        love.graphics.rectangle(
        "fill",
        self.pos.x - self.border,
        self.pos.y + self.dimensions.y,
        self.dimensions.x + self.border * 2,
        self.border
        )
        love.graphics.rectangle(
        "fill",
        self.pos.x - self.border, 
        self.pos.y + self.border,
        self.border,
        self.dimensions.y 
        )
    end
    

    return entity
end