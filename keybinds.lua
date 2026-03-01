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

return keybinds