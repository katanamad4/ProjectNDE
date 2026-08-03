local player = require("entities/player")
local bullet = require("entities/bullet")
local playfield = require("entities/playefield")
local enemy = require("entities/enemy")
local state = require("state")
local vector = require("vector")
local deep = require "deep"

local level = {}

function level.load(entities, layers)

    local enemy_script = {
        tidal_sine = function(self)
            if math.floor(self.age) % 2  == 0 then
                for i = 1, 3, 1 do
                    bullet({
                        pos = vector.new(self.pos.x + math.sin(math.floor(self.age) / i * 0.15) * 250, self.pos.y),
                        velocity = vector.new(0, i + 2),
                        acceleration = vector.new(0, 0),
                        radius = 3, 
                        sprite_key = "energyball", 
                        color = "orange"
                    })
                end
            end
        end,
        spread = function(self)
            if math.floor(self.age) % 3  == 0 then
                for i = 0, 150, 1 do
                    bullet({
                        pos = self.pos,
                        velocity = vector.from_angle(math.pi/64 * i * math.floor(self.age) % 6, 4),
                        acceleration = vector.from_angle(math.pi/64 * i, 0),
                        -- vector.new(),
                        radius = 3, 
                        sprite_key = "energyball", 
                        color  = "orange"
                    })
                end
            end
        end,
    }    


    table.insert(entities.hud, playfield({
        pos = state.pf_pos,
        dimensions = state.pf_dimensions,
        border = 10
    }))
    entities.player[1] = player({
        pos = vector.new(state.pf_pos.x + state.pf_dimensions.x / 2, state.pf_pos.y + (state.pf_dimensions.y / 3 ) * 2),
        sprite_key = "goob",

    })
    table.insert(entities.enemies, enemy({
        pos = vector.new(state.pf_pos.x + state.pf_dimensions.x / 2 , 200),
        sprite_key = "jerky",
        script = enemy_script.spread
    }))

    return entities, layers
end

return level