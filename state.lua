vec = require("vector")

local state = {}

state.lives = 5
state.movement_vecX = 0
state.movement_vecY = 0
state.movement_directionX = 0
state.movement_directionY = 0
state.movement_multiplier = 1.0
state.focus_movement_multiplier = 0.6
state.paused = false
state.player = {}
state.debug = false
state.current_level = {}
state.time = 0
state.time_scale = 1
state.window_dimensionsX, state.window_dimensionsY = love.window.getMode( )
state.pf_dimensionsX = 528
state.pf_dimensionsY = 704
state.pf_posX = (state.window_dimensionsX - state.pf_dimensionsX) / 2
state.pf_posY = (state.window_dimensionsY - state.pf_dimensionsY) / 2

-- state.pf_dimensionsX = state.window_dimensionsX - 20
-- state.pf_dimensionsY = state.window_dimensionsY - 20
-- state.pf_posX = 20
-- state.pf_posY = 10

state.pf_player_border_offset = -10
state.pf_entities_border_offset = 5
state.mouse_controls = false
state.mouse_deltaX = 0
state.mouse_deltaY = 0
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
        offsetX = 40,
        offsetY = 40,
        scale = 0.7
    },
    grayball = {
        path = "assets/grayball.png",
        offsetX = 32,
        offsetY = 32,
        scale = 0.06
    },
    energyball = {
        path = "assets/energyball.png",
        offsetX = 96,
        offsetY = 32,
        scale = 0.06
    },
    jerky = {
        path = "assets/jerky.png",
        offsetX = 64,
        offsetY = 64,
        scale = 0.8,
    },
    knife = {
        path = "assets/knife.png",
        offsetX = 32,
        offsetY = 32,
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