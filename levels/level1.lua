local player = require("entities/player")
local bullet = require("entities/bullet")
local playfield = require("entities/playefield")
local enemy = require("entities/enemy")
local vec = require("vector")
local deep = require "deep"

local level = {}

function level.load(entities, layers)

    local enemy_script = {
        tidal_sine = function(self)
            if math.floor(self.age) % 2  == 0 then
                for i = 1, 3, 1 do
                    bullet({
                        posX = self.pos.X + math.sin(math.floor(self.age) / i * 0.15) * 250,
                        posY = self.pos.Y,
                        velX = 0,
                        velY = i + 2,
                        radius = 3, 
                        sprite_key = "energyball", 
                        color = "orange"
                    })
                end
            end
        end,
        spread = function(self)
            if math.floor(self.age) % 3  == 0 then
                for i = 1, 31, 1 do
                    vX, vY = vec.fromPolar(math.pi/12 * i * math.floor(self.age) % 7, 2)
                    aX, aY = vec.fromPolar(math.pi/12 * i, 0.01)
                    bullet({
                        posX = self.posX,
                        posY = self.posY,
                        velX = vX,
                        velY = vY,
                        accelX = aX,
                        accelY = aY,
                        radius = 3, 
                        sprite_key = "energyball", 
                        color  = "pink"
                    })
                end
            end
        end,
        pool_test = function(self)
            if math.floor(self.age) % 1  == 0 then
                for i = -2, 2 , 1 do
                    vX, vY = vec.fromPolar(math.pi/2 + i, 10)
                    bullet({
                        posX = self.posX,
                        posY = self.posY,
                        velX = vX,
                        velY = vY,
                        radius = 3, 
                        sprite_key = "energyball", 
                        color  = "purple"
                    })
                end
            end
        end,
    }    


    table.insert(entities.hud, playfield({
        posX = state.pf_posX,
        posY = state.pf_posY,
        dimensionsX = state.pf_dimensionsX,
        dimensionsY = state.pf_dimensionsY,
        border = 10
    }))
    entities.player[1] = player({
        posX = state.pf_posX + state.pf_dimensionsX / 2,
        posY = state.pf_posY + (state.pf_dimensionsY / 3 ) * 2,
        sprite_key = "goob",

    })
    table.insert(entities.enemies, enemy({
        posX = state.pf_posX + state.pf_dimensionsX / 2,
        posY = 200,
        sprite_key = "jerky",
        script = enemy_script.spread 
    }))

    return entities, layers
end

return level