
local state = require("state")
local input = require("input")
local entities = require("entities")
local colision = require("colision")
local debug_hud = require("debug_hud")


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
    if state.debug then
        debug_hud.draw()
    end


end


love.update = function(dt)
    input.recompute_movement()
    for _, entity in ipairs(entities) do
        if entity.update then entity:update() end
    end

-- collision pass
    for _, ent in ipairs(entities) do
        if ent.type == "player" then
            for _, other in ipairs(entities) do
                if other.type == "bullet"
                and colision.circle_circle(ent, other)
                and ent.invincible <= 0
                then
                    ent:hit()
                end
            end
        end
    end
end