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



    table.insert(entities.hud, playfield(state.pf_pos, state.pf_dimensions))
    entities.player[1] = player(vector.new(state.pf_pos.x + state.pf_dimensions.x / 2, state.pf_pos.y + (state.pf_dimensions.y / 3 ) * 2), "goob")
    table.insert(entities.enemies, enemy(vector.new(682, 300), "test", "jerky"))


    


    return entities, layers
end

return level