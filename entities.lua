local player = require("entities/player")
local bullet = require("entities/bullet")
local playfield = require("entities/playefield")

local entities = {}

local player_entity = player(vector.new(300, 300), "goob")

entities.player = player_entity      -- named reference
table.insert(entities, player_entity) -- numeric list entry

table.insert(entities, bullet(vector.new(100, 100), vector.new(0, 0), vector.new(), 3))
table.insert(entities, bullet(vector.new(200, 100), vector.new(2, 1), vector.new(), 3))



return entities