
enemy = function(data, level)
    local entity = table.remove(level.pools.enemies)

    if not entity then
        return
    end
    entity.__index = entity
    entity.type = "enemy"
    entity.posX = data.posX 
    entity.posY = data.posY
    entity.velX = data.velX or 0
    entity.velY = data.velY or 0
    entity.accelX = data.accelX or 0
    entity.accelY = data.accelY or 0
    entity.radius = data.radius or 3
    entity.angle = vec.toPolar(entity.velX, entity.velY) 
    entity.script = data.script
    entity.health = 1000
    entity.radius = 40
    entity.sprite_key = data.sprite_key
    entity.sprite = state.sprites[entity.sprite_key]
    entity.invincible = 0
    entity.age = 0
    entity.dead = false
    entity.despawn = false
    entity.collides_with_group = data.collides_with_group or "shots"
    entity.collides_with_group2 = data.collides_with_group2 or "player"   
    entity.hitbox_type = data.hitbox_type or "circle"

    entity.hit = function(self, damage)
        self.health = self.health - damage
    end

    entity.draw = function(self)
        if not self.sprite or not self.sprite.image then love.graphics.print("NO SPRITE", 10, 200) end
        love.graphics.print("enemy health" .. self.health, 10, 200)
        if self.sprite and self.sprite.image then
            love.graphics.setColor(state.palette.white)
            love.graphics.draw(
            self.sprite.image,
            self.posX,
            self.posY,
            self.angle,                 
            self.sprite.scale,
            self.sprite.scale,
            self.sprite.offsetX,
            self.sprite.offsetY
            )
        end
        if state.debug then
            love.graphics.setColor(state.palette.magenta)
            love.graphics.circle("line", self.posX, self.posY, self.radius)
        end
    end
--TODO: add enemy movement 
    entity.update = function(self)
        self.invincible = self.invincible - 1
        if self.health <= 0 then
            self.dead = true
        end

        self.age = self.age + state.time_scale
        if self.script then 
            self.script(self, level)
        end    
    end

    entity.collision = data.collision or function(self, ent2)
        if ent2.damage then
            self:hit(ent2.damage)
        end
        if ent2.type == "shot" then
            ent2.dead = true
        end
    end

    entity.death = data.death or function(self)
    end

    table.insert(level.entities.enemies, entity)
end
return enemy