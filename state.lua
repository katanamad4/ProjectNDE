vector = require("vector")

local state = {}

state.lives = 5
state.movement_vector = vector.new()
state.movement_direction = vector.new()
state.movement_multiplier = 1.0
state.focus_movement_multiplier = 0.6
state.paused = false
state.player = { pos = {}}
state.debug = false
state.current_level = nil
state.time = 0
state.time_scale = 1
state.window_dimensions = vector.new(1366, 768)
state.pf_dimensions = vector.new(math.floor(1366 * 0.35), 768 - 20)
state.pf_pos = vector.new(math.floor(1366 / 3), 10)
state.pf_player_border_offset = -10
state.mouse_controls = false
state.mouse_delta = vector.new()
state.key_map = {
    left   = "move_left",
    right  = "move_right",
    up     = "move_up",
    down   = "move_down",
    lshift = "focus",
    escape = "quit",
    f3     = "debug",
    m      = "mouse",
    z      = "shoot",
    kp2    = "time_plus",
    kp1    = "time_minus",
    
}
state.keys_down = {
    move_left = false,
    move_right = false,
    move_up = false,
    move_down = false,
    focus = false,
    shooting = false,
}
state.sprites = {
    goob = {
        path = "assets/goob.png",
        offset = vector.new(40, 40),
        scale = 0.7
    },
    grayball = {
        path = "assets/grayball.png",
        offset = vector.new(32, 32),
        scale = 0.06
    },
    energyball = {
        path = "assets/energyball.png",
        offset = vector.new(96, 32),
        scale = 0.06
    },
    jerky = {
        path = "assets/jerky.png",
        offset = vector.new(64, 64),
        scale = 0.8,
    },
    knife = {
        path = "assets/knife.png",
        offset = vector.new(32, 32),
        scale = 0.28
    },
}
state.palette = {
    -- Neutrals
    white   = {1.0, 1.0, 1.0, 1.0},
    black   = {0.0, 0.0, 0.0, 1.0},
    gray    = {0.5, 0.5, 0.5, 1.0},
    light_gray = {0.75, 0.75, 0.75, 1.0},
    dark_gray  = {0.25, 0.25, 0.25, 1.0},

    -- Primary
    red     = {1.0, 0.0, 0.0, 1.0},
    green   = {0.0, 1.0, 0.0, 1.0},
    blue    = {0.4, 0.4, 1.0, 1.0},

    -- Secondary
    yellow  = {0.9, 1.0, 0.2, 1.0},
    cyan    = {0.0, 1.0, 1.0, 1.0},
    magenta = {1.0, 0.0, 1.0, 1.0},

    -- Common extras
    orange  = {1.0, 0.5, 0.0, 1.0},
    purple  = {0.6, 0.2, 0.8, 1.0},
    pink    = {1.0, 0.4, 0.7, 1.0},
    brown   = {0.4, 0.2, 0.1, 1.0},

    -- Transparent helpers
    transparent = {1.0, 1.0, 1.0, 0.2},
}

return state