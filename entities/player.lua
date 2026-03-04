local vector = require("vector")
local state = require("state")
local colision = require("colision")

return function(pos, sprite_key)
    local entity = {}
    entity.__index = entity
    entity.type = "player"
    entity.pos = pos
    entity.velocity = vector.new()
    entity.radius = 4.0
    entity.maxspeed = 7.0
    entity.sprite_key = sprite_key
    entity.scale = 0.8
    entity.invincible = 0



    entity.hit = function(self) 
        state.lives =  state.lives - 1
        self.invincible = 100
    end

    entity.draw = function(self)
        local sprite = state.sprites[self.sprite_key]
        if not sprite or not sprite.image then return end

        local image = sprite.image
        local ox = image:getWidth() / 2
        local oy = image:getHeight() / 2

        if self.invincible > 0 then 
            love.graphics.setColor(state.palette.red)
        else
            love.graphics.setColor(state.palette.white)
        end
        love.graphics.draw(image, self.pos.x, self.pos.y, 0, self.scale, self.scale, ox, oy)
        if state.keys_down.focus then 
            love.graphics.setColor(state.palette.red)
            love.graphics.circle("fill", self.pos.x, self.pos.y, self.radius)
            love.graphics.setColor(state.palette.white)
            love.graphics.circle("fill", self.pos.x, self.pos.y, self.radius - 2)
        end
    end

    entity.update = function(self)
        self.velocity = vector.limit(state.movement_vector * self.maxspeed, self.maxspeed)
        
        if self.velocity.x + self.pos.x < state.pf_pos.x then 
            self.velocity.x = 0 
        end
        if self.velocity.x + self.pos.x > state.pf_pos.x + state.pf_dimensions.x then 
            self.velocity.x = 0 
        end
        if self.velocity.y + self.pos.y < state.pf_pos.y then 
            self.velocity.y = 0 
        end
        if self.velocity.y + self.pos.y > state.pf_pos.y + state.pf_dimensions.y then 
            self.velocity.y = 0 
        end

        self.pos = self.velocity + self.pos
        if self.invincible > 0 then
            self.invincible = self.invincible - 1
        end
    end
    return entity
end