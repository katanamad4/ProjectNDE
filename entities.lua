local player = require("entities/player")
local bullet = require("entities/bullet")

local entities = {
    player(vector.new(300, 300), "goob"),
    bullet(vector.new(100, 100), vector.new(2, 1), vector.new(), 3),
    bullet(vector.new(200, 100), vector.new(2, 1), vector.new(), 3),


}

return entities