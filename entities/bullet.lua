vector = require("vector")

bullet = function(data)
    local entity = table.remove(state.current_level.pools.bullets)

    if not entity then
        return
    end

    entity.__index = entity
    entity.type = "bullet"
    entity.pos = data.pos or vector.new()
    entity.velocity = data.velocity or vector.new()
    entity.acceleration = data.acceleration or vector.new()
    entity.radius = data.radius or 3
    entity.sprite_key = data.sprite_key or "energyball"
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
    table.insert(state.current_level.entities.bullets, entity)
end

return bullet