local vec = require("vector")
local profiler = require "profiler"


bullet = function(data, level)
    local entity = table.remove(level.pools.bullets)

    if not entity then
        return
    end
    profiler.start("bInit")
    entity.__index = entity
    entity.type = "bullet"
    entity.posX = data.posX 
    entity.posY = data.posY
    entity.velX = data.velX or 0
    entity.velY = data.velY or 0
    entity.accelX = data.accelX or 0
    entity.accelY = data.accelY or 0
    entity.radius = data.radius or 3
    entity.rotate_with_velocity = data.rotate_with_velocity or false
    entity.collides_with_group = data.collides_with_group or "player"
    entity.collides_with_group2 = data.collides_with_group2     
    entity.hitbox_type = data.hitbox_type or "circle"
    entity.angle = data.angle or vec.toPolar(entity.velX, entity.velY) 
    entity.sprite_key = data.sprite_key or "energyball"
    entity.sprite = state.sprites[entity.sprite_key]
    entity.color = state.palette[data.color] or state.palette.white --i should add coustom colors to the data table 
    entity.script = data.script
    entity.despawn = false
    entity.dead = false
    entity.age = 0 
    profiler.stop("bInit")

    entity.draw = function(self)
        profiler.start("bDraw")
        if not self.sprite or not self.sprite.image then return end
        love.graphics.setColor(self.color)
        love.graphics.draw(self.sprite.image,
        self.posX, self.posY,
        self.angle,
        self.radius * self.sprite.scale,
        self.radius * self.sprite.scale,
        self.sprite.offsetX , self.sprite.offsetY)

        -- if state.debug then
        --     love.graphics.setColor(state.palette.red)
        --     love.graphics.circle("fill", self.pos.X, self.pos.Y, self.radius)
        -- end
        profiler.stop("bDraw")
    end

    entity.update = function(self)
        profiler.start("bUpd")

    self.posX, self.posY = vec.add(
        self.posX,
        self.posY,
        self.velX * state.time_scale,
        self.velY * state.time_scale
    )        
    self.velX, self.velY = vec.mul(state.time_scale, vec.add(self.velX, self.velY, self.accelX, self.accelY))
        self.age = self.age + state.time_scale
        if self.rotate_with_velocity then
            self.angle = vec.toPolar(self.velX, self.velY)
        end
        if self.script then
            self:script()
        end
        profiler.stop("bUpd")
    end

    entity.colision = data.colision or function(self, ent2)
    end

    entity.death = data.death or function(self)
        -- print("bullet dead!")
    end
    table.insert(level.entities.bullets, entity)
end

return bullet