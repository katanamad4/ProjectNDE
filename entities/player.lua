local vector = require("vector")
local state = require("state")
local shot = require("entities/shot")


return function(pos, sprite_key)
    local entity = {}
    entity.__index = entity
    entity.type = "player"
    entity.pos = pos
    entity.velocity = vector.new()
    entity.radius = 1.2
    entity.maxspeed = 6.0
    entity.sprite_key = sprite_key
    entity.invincible = 0
    entity.visible = true
    entity.sprite = state.sprites[entity.sprite_key]

    entity.hit = function(self) 
        state.lives =  state.lives - 1
        self.invincible = 100
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
                    self.pos.x,
                    self.pos.y,
                    0,                 
                    self.sprite.scale,
                    self.sprite.scale,
                    self.sprite.offset.x,
                    self.sprite.offset.y
                )
            end
        
            if state.keys_down.focus then 
            -- if true then
                love.graphics.setColor(state.palette.red)
                love.graphics.circle("fill", self.pos.x, self.pos.y, self.radius + 3)
                love.graphics.setColor(state.palette.white)
                love.graphics.circle("fill", self.pos.x, self.pos.y, self.radius + 2)
                if state.debug then
                    love.graphics.setColor(state.palette.blue)
                    love.graphics.circle("fill", self.pos.x, self.pos.y, self.radius)

                end
            end
        end
        if self.invincible == 0 then
            self.visible = true
        end    
    end

    entity.update = function(self, dt)
        if self.mouse_controls then 
            self.velocity = vector.limit(state.movement_vector * state.time_scale, self.maxspeed * state.time_scale)
        else
            self.velocity = vector.limit(state.movement_vector * self.maxspeed * state.time_scale, self.maxspeed * state.time_scale)
        end
        if self.velocity.x + self.pos.x < state.pf_pos.x - state.pf_player_border_offset then 
            self.velocity.x = 0 
        end
        if self.velocity.x + self.pos.x > state.pf_pos.x + state.pf_dimensions.x + state.pf_player_border_offset then 
            self.velocity.x = 0 
        end
        if self.velocity.y + self.pos.y < state.pf_pos.y - state.pf_player_border_offset then 
            self.velocity.y = 0 
        end
        if self.velocity.y + self.pos.y > state.pf_pos.y + state.pf_dimensions.y + state.pf_player_border_offset then 
            self.velocity.y = 0 
        end
        if state.keys_down.shooting then
            if state.time % 2 == 0 then
                for i = -2, 2, 1 do
                    table.insert(
                        state.current_level.entities.shots,
                        shot(
                            self.pos,
                            vector.from_angle(math.rad(270 + i * 5) ) * 20,
                            vector.new(),
                            3,
                            "knife",
                            "transparent"
                        )
                    )
                end
            end
        end 
        self.pos = self.velocity + self.pos
        if self.invincible > 0 then
            self.invincible = self.invincible - 1
        end
        state.player = self
    end
    return entity
end