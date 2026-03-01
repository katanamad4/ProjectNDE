local vector = require("vector")
local state = require("state")
local colision = require("colision")

return function(pos, sprite)
    entity = {}
    entity.__index = entity
    entity.type = "player"
    entity.pos = pos
    entity.velocity = vector.new()
    entity.radius = 4.0
    entity.maxspeed = 4.0
    entity.sprite = love.graphics.newImage(state.sprites[sprite])
    entity.scale = 0.8
    entity.invincible = 0

    entity.hit = function(self) 
        state.lives =  state.lives - 1
        self.invincible = 100
    end

    entity.draw = function(self)
        local ox = self.sprite:getWidth() / 2
        local oy = self.sprite:getHeight() / 2
        if self.invincible > 0 then 
            love.graphics.setColor(state.palette.red)
        else
            love.graphics.setColor(state.palette.white)
        end
        love.graphics.draw(self.sprite, self.pos.x, self.pos.y, 0, self.scale, self.scale, ox, oy)
        if state.keys_down.focus then 
            love.graphics.setColor(state.palette.red)
            love.graphics.circle("fill", self.pos.x, self.pos.y, self.radius)
            love.graphics.setColor(state.palette.white)
            love.graphics.circle("fill", self.pos.x, self.pos.y, self.radius - 2)
        end
    end

    entity.update = function(self)
        self.velocity = vector.limit(state.movement_vector * self.maxspeed, self.maxspeed)
        self.pos = self.pos + self.velocity
        if self.invincible > 0 then
            self.invincible = self.invincible - 1
        end
    end
    return entity
end