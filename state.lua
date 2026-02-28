vector = require("vector")

local state = {}

state.palette = {
	{1.0, 0.0, 0.0, 1.0},  -- 1 red
    {0.0, 1.0, 0.0, 1.0},  -- 2 green
    {0.4, 0.4, 1.0, 1.0},  -- 3 blue
    {0.9, 1.0, 0.2, 1.0},  -- 4 yellow
    {1.0, 1.0, 1.0, 1.0},  -- 5 white
    {0.0, 0.0, 0.0, 1.0},   -- 6 black 
}

state.movement_vector = vector.new()
state.movement_direction = vector.new()
state.movement_multiplier = 1.0
state.paused = false
state.key_map = {
    left   = "move_left",
    right  = "move_right",
    up     = "move_up",
    down   = "move_down",
    lshift = "focus",
    escape = "quit",
}

state.keys_down = {}


return state