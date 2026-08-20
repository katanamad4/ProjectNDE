local player = require("entities/player")
local bullet = require("entities/bullet")
local playfield = require("entities/playfield")
local enemy = require("entities/enemy")
local vec = require("vector")
local deep = require "deep"

local level = {}

function level.load(thisLevel)

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
                    }, thisLevel)
                end
            end
        end,
        spread = function(self)
            if math.floor(self.age) % 3  == 0 then
                for i = 1, 5, 1 do
                    vX, vY = vec.fromPolar(math.pi/5 * i * math.floor(self.age) % 7, 2)
                    aX, aY = vec.fromPolar(math.pi/5 * i, 0.01)
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
                    }, thisLevel)
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
                    }, thisLevel)
                end
            end
        end,
    }    


    playfield({
        posX = state.pf_posX,
        posY = state.pf_posY,
        dimensionsX = state.pf_dimensionsX,
        dimensionsY = state.pf_dimensionsY,
        border = 5
    }, thisLevel)
    player({
        posX = state.pf_posX + state.pf_dimensionsX / 2,
        posY = state.pf_posY + (state.pf_dimensionsY / 3 ) * 2,
        sprite_key = "goob",

    }, thisLevel)
    enemy({
        posX = state.pf_posX + state.pf_dimensionsX / 2,
        posY = state.pf_posY + state.pf_dimensionsY / 2,
        sprite_key = "jerky",
        script = enemy_script.spread 
    }, thisLevel)

end

return level