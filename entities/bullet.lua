state = require("state")
vector = require("vector")

return function(data)
    local entity = {}
    entity.__index = entity
    entity.type = "bullet"
    entity.pos = data.pos
    entity.velocity = data.velocity
    entity.acceleration = data.acceleration
    entity.radius = data.radius
    entity.sprite_key = data.sprite_key
    entity.color = state.palette[data.color] or state.palette.white --i should add coustom colors to the data table 
    entity.despawn = false
    entity.dead = false
    entity.sprite = state.sprites[entity.sprite_key]
    entity.age = 0 


    entity.draw = function(self)
        if not self.sprite or not self.sprite.image then return end
        if self.sprite and self.sprite.image then
            love.graphics.setColor(self.color)
            love.graphics.draw(self.sprite.image,
            self.pos.x, self.pos.y,
            vector.angle(self.velocity),
            self.radius * self.sprite.scale,
            self.radius * self.sprite.scale,
            self.sprite.offset.x , self.sprite.offset.y)
        end

        -- if state.debug then
        --     love.graphics.setColor(state.palette.red)
        --     love.graphics.circle("fill", self.pos.x, self.pos.y, self.radius)
        -- end
    end

    entity.update = function(self)
        if not vector.pos_in_pf(self.pos, 10) then
            self.despawn = true
        end 
        self.pos = self.pos + self.velocity * state.time_scale
        self.velocity = self.velocity + self.acceleration
        self.age = self.age + state.time_scale  
        if self.script then
            self:script()
        end
    end

    entity.death = function(self)
        print("bullet dead!")
    end
        
    return entity
end
