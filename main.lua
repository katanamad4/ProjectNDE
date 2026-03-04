
local state = require("state")
local input = require("input")
local debug_hud = require("debug_hud")
local level = require("level")

love.graphics.setDefaultFilter('nearest', 'nearest')

function love.load(args)
    -- init something here ...
    love.window.setTitle('Project Near Death Experience') 
    for _, v in ipairs(args) do
        if v == "--debug" then
            state.debug = true
        end
    end
    for key, data in pairs(state.sprites) do
        data.image =  love.graphics.newImage(data.path)
    end
    state.current_level = level.load("level1")
    love.mouse.setRelativeMode(true)

end


function love.resize(w, h)
    -- ...
end

love.keypressed = function(pressed_key)
  input.press(pressed_key)
end

love.keyreleased = function(released_key)
  input.release(released_key)
end

love.mousemoved = function(x, y, dx, dy)
    state.mouse.dx = dx
    state.mouse.dy = dy
end

love.draw = function()
    state.current_level:draw()

    if state.debug then
        debug_hud.draw()
    end


end


love.update = function(dt)
    input.recompute_movement()
    state.current_level:update(dt)

end