local state = require("state")

score_display = function(data, level)
    local entity = table.remove(level.pools.hud)

    if not entity then
        return
    end

    entity.posX = data.posX or 1070
    entity.posY = data.posY or 70

    function entity:draw()
        love.graphics.setColor(state.palette.white)

        love.graphics.print("Score " .. state.score, entity.posX, entity.posY)
    end

    table.insert(level.entities.hud, entity)
end

return score_display