vector = require("vector")

return{
    palette = {
	{1.0, 0.0, 0.0, 1.0},  -- 1 red
    {0.0, 1.0, 0.0, 1.0},  -- 2 green
    {0.4, 0.4, 1.0, 1.0},  -- 3 blue
    {0.9, 1.0, 0.2, 1.0},  -- 4 yellow
    {1.0, 1.0, 1.0, 1.0},  -- 5 white
    {0.0, 0.0, 0.0, 1.0}   -- 6 black 
	},
    movement_vector = vector.new(),
    movement_multiplier = 1.0,
    paused = false,
}