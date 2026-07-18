local state = require("state")


local debug = {}

debug.line_spacing = 15

debug.entries = {
    fps = function(self, y)
            love.graphics.print("FPS: " .. love.timer.getFPS(), 10, y)
    end,
    entities = function(self, y)
        local entityAmount = 0
        for groupName, group in pairs(state.current_level.entities) do
            entityAmount = entityAmount + #group
            -- use the group.layer var that i didnt add at the moment to manage the y position
        end
        love.graphics.print("all Entities: " .. entityAmount, 10, y + #state.current_level.entities)

    end,
    movement_v = function(self, y)
        if state.movement_vector then
            love.graphics.print(
                "Movement: " .. state.movement_vector.x .. ", " .. state.movement_vector.y, 10, y)
        end
    end,
    lives = function(self, y)
        love.graphics.print("Lives:" .. state.lives .. " invincible:" .. state.player.invincible, 10, y)
    end,
    pos = function(self, y)
        love.graphics.print("player.pos x: " .. state.player.pos.x .. " y: " .. state.player.pos.y , 10, y)
    end,
    shooting = function(self, y)
        if state.keys_down.shooting then
            love.graphics.print("Shooting", 10, y)
        end
    end,
    time = function(self, y)
        love.graphics.print("time:" .. state.time, 10, y)
    end,
    time_scale = function(self, y)
        love.graphics.print("time_scale:" .. state.time_scale, 10, y)
    end
}



function debug.draw()
    
    love.graphics.setColor(state.palette.green)
    local n = 0
    for _, entry in pairs(debug.entries) do
        n = n + 1
        entry(debug, n * debug.line_spacing + 5)
    end
    --debug should use deep too
    
end

return debug