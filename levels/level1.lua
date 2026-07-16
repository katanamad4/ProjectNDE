local player = require("entities/player")
local bullet = require("entities/bullet")
local playfield = require("entities/playefield")
local enemy = require("entities/enemy")
local state = require("state")
local vector = require("vector")
local deep = require "deep"

local level = {}

function level.load()
    local entities = {
        player = {},
        shots = {},
        bullets = {},
        enemies = {},
        hud = {},
        debug = {}
    }

    local layers = {}
    for k, _ in pairs(entities) do
        layers[k] = deep:new()
    end

    local enemy_script = {
        test = function(self)
            if state.time % 2  == 0 then
                for i = 1, 10, 1 do
                    table.insert(
                        state.current_level.entities.bullets, 
                        bullet(
                            self.pos, 
                            vector.from_angle(math.rad((i * 2 * state.time + i * 0.2 / 360 )*  love.math.random( -100, 100 ) / 100), 5),
                            vector.new(0,0),
                            3, 
                            "energyball", 
                            "orange"
                        )
                    )
                end
            end
        end
    }    


    table.insert(entities.hud, playfield(state.pf_pos, state.pf_dimensions))
    entities.player[1] = player(vector.new(state.pf_pos.x + state.pf_dimensions.x / 2, state.pf_pos.y + (state.pf_dimensions.y / 3 ) * 2), "goob")
    table.insert(entities.enemies, enemy(vector.new(682, 300), "jerky", enemy_script.test))

    return entities, layers
end

return level