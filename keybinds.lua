local state = require("state")

local keybinds = {}

keybinds.move_left = {
    press = function()
        state.keys_down.move_left = true
    end,
    release = function()
        state.keys_down.move_left = false
    end
}

keybinds.move_right = {
    press = function()
        state.keys_down.move_right = true
    end,
    release = function()
        state.keys_down.move_right = false
    end
}

keybinds.move_up = {
    press = function()
        state.keys_down.move_up = true
    end,
    release = function()
        state.keys_down.move_up = false
    end
}

keybinds.move_down = {
    press = function()
        state.keys_down.move_down = true
    end,
    release = function()
        state.keys_down.move_down = false
    end
}

keybinds.focus = {
    press = function()
        state.keys_down.focus = true
    end,
    release = function()
        state.keys_down.focus = false
    end
}

keybinds.quit = {
    press = function()
        love.event.quit()
    end
}

keybinds.debug = {
    press = function()
        state.debug = not state.debug
    end
}

keybinds.mouse = {
    press = function()
        state.mouse_controls = not state.mouse_controls
    end
}

keybinds.shoot = {
    press = function()
        state.keys_down.shooting = true
    end,
    release = function()
        state.keys_down.shooting = false
    end
}

keybinds.time_plus = {
    press = function()
        state.time_scale = state.time_scale + 0.1
    end
}

keybinds.time_minus = {
    press = function()
        state.time_scale = state.time_scale - 0.1
    end
}

return keybinds