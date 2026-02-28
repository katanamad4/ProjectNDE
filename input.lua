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
            state.movement_vector.x = 0
            state.movement_vector.y = 0
        end
    end,

    recompute_movement = function()
        state.movement_direction.x = 0
        state.movement_direction.y = 0
        if state.keys_down.move_left  then state.movement_direction.x = state.movement_direction.x - 1 end
        if state.keys_down.move_right then state.movement_direction.x = state.movement_direction.x + 1 end
        if state.keys_down.move_up    then state.movement_direction.y = state.movement_direction.y - 1 end
        if state.keys_down.move_down  then state.movement_direction.y = state.movement_direction.y + 1 end
        state.movement_multiplier = state.keys_down.focus and 0.5 or 1.0
        state.movement_vector = vector.normalize(state.movement_direction) * state.movement_multiplier
        if state.keys_down.quit       then love.event.quit() end

    end,
        
}