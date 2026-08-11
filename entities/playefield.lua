local state = require("state")

return function(data)
    local entity = {}

    entity.posX = data.posX
    entity.posY = data.posY
    entity.dimensionsX = data.dimensionsX
    entity.dimensionsY = data.dimensionsY
    entity.border = data.border or 10

    function entity:draw()
        love.graphics.setColor(state.palette.white)

        love.graphics.rectangle(
            "fill",
            self.posX - self.border,
            self.posY - self.border,
            self.dimensionsX + self.border * 2,
            self.border
        )

        love.graphics.rectangle(
            "fill",
            self.posX + self.dimensionsX,
            self.posY,
            self.border,
            self.dimensionsY
        )

        love.graphics.rectangle(
            "fill",
            self.posX - self.border,
            self.posY + self.dimensionsY,
            self.dimensionsX + self.border * 2,
            self.border
        )

        love.graphics.rectangle(
            "fill",
            self.posX - self.border,
            self.posY,
            self.border,
            self.dimensionsY
        )
    end

    return entity
end