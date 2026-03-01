local state = require("state")
local entities = require("entities")

local debug = {}


function debug.draw()
    love.graphics.setColor(state.palette.green)

    love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)
    love.graphics.print("Entities: " .. #entities, 10, 25)

    if state.movement_vector then
        love.graphics.print(
            "Movement: " ..
            math.floor(state.movement_vector.x) .. ", " ..
            math.floor(state.movement_vector.y),
            10, 40
        )
    end
    love.graphics.print("Lives:" .. state.lives .. "invincible:" .. entities.player.invincible)

    -- for _, entity in ipairs(entities) do
    --     love.graphics.print()
    -- end 

end

return debug