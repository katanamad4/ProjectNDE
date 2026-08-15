vec = require("vector")

bullet = function(data, level)
    local entity = table.remove(level.pools.bullets)

    if not entity then
        return
    end

    entity.__index = entity
    entity.type = "bullet"
    entity.posX = data.posX 
    entity.posY = data.posY
    entity.velX = data.velX or 0
    entity.velY = data.velY or 0
    entity.accelX = data.accelX or 0
    entity.accelY = data.accelY or 0
    entity.radius = data.radius or 3
    entity.angle = vec.toPolar(entity.velX, entity.velY) 
    entity.sprite_key = data.sprite_key or "energyball"
    entity.sprite = state.sprites[entity.sprite_key]
    entity.color = state.palette[data.color] or state.palette.white --i should add coustom colors to the data table 
    entity.script = data.script
    entity.despawn = false
    entity.dead = false
    entity.age = 0 

    entity.draw = function(self)
        if not self.sprite or not self.sprite.image then return end
        if self.sprite and self.sprite.image then
            love.graphics.setColor(self.color)
            love.graphics.draw(self.sprite.image,
            self.posX, self.posY,
            self.angle,
            self.radius * self.sprite.scale,
            self.radius * self.sprite.scale,
            self.sprite.offsetX , self.sprite.offsetY)
        end

        -- if state.debug then
        --     love.graphics.setColor(state.palette.red)
        --     love.graphics.circle("fill", self.pos.X, self.pos.Y, self.radius)
        -- end
    end

    entity.update = function(self)
        self.posX, self.posY = vec.mul(state.time_scale, vec.add(self.posX, self.posY, self.velX, self.velY))
        self.velX, self.velY = vec.mul(state.time_scale, vec.add(self.velX, self.velY, self.accelX, self.accelY))
        self.age = self.age + state.time_scale
        self.angle = vec.toPolar(self.velX, self.velY)
        if self.script then
            self:script()
        end
    end

    entity.death = function(self)
        -- print("bullet dead!")
    end
    table.insert(level.entities.bullets, entity)
end

return bullet