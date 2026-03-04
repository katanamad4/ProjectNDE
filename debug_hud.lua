local state = require("state")


local debug = {}

debug.line_spacing = 15

debug.entries = {
    fps = function(self, y)
            love.graphics.print("FPS: " .. love.timer.getFPS(), 10, y)
    end,
    entities = function(self, y)
        love.graphics.print("Entities: " .. #state.current_level.entities, 10, y)
    end,
    movement_v = function(self, y)
        if state.movement_vector then
            love.graphics.print(
                "Movement: " ..
                math.floor(state.movement_vector.x) .. ", " ..
                math.floor(state.movement_vector.y),
                10, y
            )
        end
    end,
    lives = function(self, y)
        love.graphics.print("Lives:" .. state.lives .. " invincible:" .. state.player.invincible, 10, y)
    end,
    pos = function(self, y)
                love.graphics.print("player.pos x: " .. state.player.pos.x .. " y: " .. state.player.pos.y , 10, y)
    end,
}



function debug.draw()
    
    love.graphics.setColor(state.palette.green)
    local n = 0
    for _, entry in pairs(debug.entries) do
        n = n + 1
        entry(debug, n * debug.line_spacing + 5)
    end

    

end

return debug