local player = require("entities/player")
local bullet = require("entities/bullet")
local playfield = require("entities/playefield")
local state = require("state")
local vector = require("vector")

local level = {}

function level.load()
    local entities = {}

    local player_entity = player(vector.new(state.pf_pos.x + state.pf_dimensions.x / 2, state.pf_pos.y + (state.pf_dimensions.y / 3 ) * 2), "goob")
    table.insert(entities, playfield(state.pf_pos, state.pf_dimensions))
    entities.player = player_entity      -- named reference
    table.insert(entities, player_entity) -- numeric list entry
    table.insert(entities, bullet(vector.new(100, 100), vector.new(0, 0), vector.new(), 3, "grayball", "orange"))
    
    
    for i = 0, -200, -1 do
        table.insert(entities, bullet(vector.new(682, 200), vector.from_angle(i), vector.new(), 3, "energyball", "orange"))
    end


    return entities
end

return level