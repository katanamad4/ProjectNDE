
local state = require("state")
local input = require("input")
local entities = require("entities")

love.graphics.setDefaultFilter('nearest', 'nearest')

function love.load()
    -- init something here ...
    love.window.setTitle('Project Near Death Experience')
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


love.draw = function()
    for _, entity in ipairs(entities) do
        if entity.draw then entity:draw() end
    end
end


love.update = function(dt)
    input.recompute_movement()
    if state.paused then
        return
    end
    for _, entity in ipairs(entities) do
        if entity.update then entity:update() end
    end
end