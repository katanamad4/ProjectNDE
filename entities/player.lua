local vec = require("vector")

local shot = require("entities/shot")


return function(data)
    local entity = {}
    entity.__index = entity
    entity.type = "player"
    entity.posX = data.posX 
    entity.posY = data.posY
    entity.velX = data.velX or 0
    entity.velY = data.velY or 0
    entity.accelX = data.accelX or 0
    entity.accelY = data.accelY or 0
    entity.radius = data.radius or 3
    entity.angle = 0  
    entity.radius = data.radius or 1.2
    entity.maxspeed = data.maxspeed or 6.0
    entity.sprite_key = data.sprite_key
    entity.invincible = data.invincible or 0
    entity.visible = true
    entity.sprite = state.sprites[entity.sprite_key]

    entity.hit = function(self) 
        state.lives =  state.lives - 1
        self.invincible = 120
    end

    entity.draw = function(self)
        if not self.sprite or not self.sprite.image then love.graphics.print("NO SPRITE", 10, 200) end
        if self.invincible > 0 and state.time % 4 == 0 then 
            self.visible = not self.visible
        end
        if self.visible then
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
        
            if state.keys_down.focus then 
            -- if true then
                love.graphics.setColor(state.palette.red)
                love.graphics.circle("fill", self.posX, self.posY, self.radius + 3)
                love.graphics.setColor(state.palette.white)
                love.graphics.circle("fill", self.posX, self.posY, self.radius + 2)
                if state.debug then
                    love.graphics.setColor(state.palette.blue)
                    love.graphics.circle("fill", self.posX, self.posY, self.radius)

                end
            end
        end
        if self.invincible == 0 then
            self.visible = true
        end    
    end

    entity.update = function(self, dt)
        if self.mouse_controls then 
            self.velX, self.velY = vec.trim(self.maxspeed * state.time_scale, state.movement_vecX * state.time_scale, state.movement_vecY * state.time_scale)
        else
            self.velX, self.velY = vec.trim(self.maxspeed * state.time_scale, state.movement_vecX * self.maxspeed * state.time_scale, state.movement_vecY * self.maxspeed * state.time_scale)
        end
        if self.velX + self.posX < state.pf_posX - state.pf_player_border_offset then 
            self.velX = 0 
        end
        if self.velX + self.posX > state.pf_posX + state.pf_dimensionsX + state.pf_player_border_offset then 
            self.velX = 0 
        end
        if self.velY + self.posY < state.pf_posY - state.pf_player_border_offset then 
            self.velY = 0 
        end
        if self.velY + self.posY > state.pf_posY + state.pf_dimensionsY + state.pf_player_border_offset then 
            self.velY = 0 
        end
        if state.keys_down.shooting then
            if state.time % 2 == 0 then
                for i = -2, 2, 1 do
                    local vX, vY = vec.fromPolar(math.pi/2 * 3 + math.pi/36 * i, 20)
                    shot({
                        posX = self.posX,
                        posY = self.posY,
                        velX = vX,
                        velY = vY,
                        radius = 3,
                        sprite_key = "knife",
                        color = "transparent"
                    })
                end
            end
        end 
        self.posX, self.posY = vec.add(self.velX, self.velY, self.posX, self.posY)
        if self.invincible > 0 then
            self.invincible = self.invincible - 1
        end
        state.player = self
    end
    return entity
end