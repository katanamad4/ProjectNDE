local state = require("state")
local keybinds = require("keybinds")



return {
    press = function(key)
        if not state.key_map[key] then return end

        local bind = keybinds[state.key_map[key]]
        if bind and bind.press then
            bind.press()
        end
    end,

    release = function(key)
        if not state.key_map[key] then return end

        local bind = keybinds[state.key_map[key]]
        if bind and bind.release then
            bind.release()
        end
    end,

    -- Handle window focusing/unfocusing
    toggle_focus = function(focused)
        if not focused then
            state.paused = true
            state.movement_vecX = 0
            state.movement_vecY = 0
        end
    end,

    recompute_movement = function()
        state.movement_vecX = 0
        state.movement_vecY = 0
        if state.mouse_controls then
            state.movement_vecX = state.mouse_deltaX * 0.5
            state.movement_vecY = state.mouse_deltaY * 0.5
            state.movement_vecX, state.movement_vecY = vec.normalize(state.movement_vecX, state.movement_vecY)
            state.mouse_deltaX, state.mouse_deltaY = 0, 0
        else
            if state.keys_down.move_left  then state.movement_vecX = state.movement_vecX - 1 end
            if state.keys_down.move_right then state.movement_vecX = state.movement_vecX + 1 end
            if state.keys_down.move_up    then state.movement_vecY = state.movement_vecY - 1 end
            if state.keys_down.move_down  then state.movement_vecY = state.movement_vecY + 1 end
            state.movement_vec = vec.mul(state.movement_multiplier, vec.normalize(state.movement_vecX, state.movement_vecY)) 
        end
        if state.keys_down.focus then 
            state.movement_vecX, state.movement_vecY = vec.mul(state.focus_movement_multiplier, state.movement_vecX, state.movement_vecY) 
        end
        if state.keys_down.quit then love.event.quit() end
    end,
}
