local state = require("state")

score_display = function(data, level)
    local entity = table.remove(level.pools.hud)

    if not entity then
        return
    end

    entity.posX = data.posX or 1070
    entity.posY = data.posY or 70
    entity.font = love.graphics.newFont(16)

    function entity:draw()
        love.graphics.setColor(state.palette.white)
        love.graphics.setFont(self.font)
        love.graphics.print("Score " .. state.score, entity.posX, entity.posY)
        love.graphics.print("Graze " .. state.graze, entity.posX, entity.posY + 15)    
        love.graphics.print("Multipler " .. state.score_mul * 100 .. "%", entity.posX, entity.posY + 30)    

    end

    table.insert(level.entities.hud, entity)
end

return score_display