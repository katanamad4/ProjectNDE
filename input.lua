local state = require("state")


local press_functions = {
    left = function()
        state.movement_vector.x = state.movement_vector.x - 1.0
    end,
    right = function()
        state.movement_vector.x = state.movement_vector.x + 1.0
    end,
    up = function()
        state.movement_vector.y = state.movement_vector.y - 1.0
    end,
    down = function()
        state.movement_vector.y = state.movement_vector.y + 1.0
    end,
    lshift = function()
        state.focus = true
    end,
    escape = function()
        -- state.paused = not state.paused
        love.event.quit()
    end,
}

local release_functions = {
    left = function()
        state.movement_vector.x = state.movement_vector.x + 1.0
    end,
    right = function()
        state.movement_vector.x = state.movement_vector.x - 1.0
    end,
    up = function()
        state.movement_vector.y = state.movement_vector.y + 1.0
    end,
    down = function()
        state.movement_vector.y = state.movement_vector.y - 1.0
    end,
    lshift = function()
        state.focus = false
    end
}


return {
  -- Look up in the map for actions that correspond to specific key presses
  press = function(pressed_key)
    if press_functions[pressed_key] then
      press_functions[pressed_key]()
    end
  end,
  -- Look up in the map for actions that correspond to specific key releases
  release = function(released_key)
    if release_functions[released_key] then
      release_functions[released_key]()
    end
  end,
  -- Handle window focusing/unfocusing
  toggle_focus = function(focused)
    if not focused then
      state.paused = true
    end
  end
}