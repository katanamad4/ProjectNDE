local vector = require("vector")
local state = require("state")
local bullet = require("entities/bullet")



return function(start_pos, sprite_key, script)
    local entity = {}
    entity.__index = entity
    entity.type = "enemy"
    entity.pos = start_pos
    entity.script = script
    entity.health = 1000
    entity.radius = 40
    entity.sprite_key = sprite_key
    entity.sprite = state.sprites[entity.sprite_key]
    entity.invincible = 0
    entity.age = 0

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
            self.pos.x,
            self.pos.y,
            0,                 
            self.sprite.scale,
            self.sprite.scale,
            self.sprite.offset.x,
            self.sprite.offset.y
            )
        end
        if state.debug then
            love.graphics.setColor(state.palette.magenta)
            love.graphics.circle("line", self.pos.x, self.pos.y, self.radius)
        end
    end
--TODO: add enemy movement 
    entity.update = function(self)
        self.invincible = self.invincible - 1
        if self.health <= 0 then
            self.dead = true
        end

        self.age = self.age + 1
        self.script(self)


        -- if enemy_type == "test" then
        --     if state.time % 2  == 0 then
        --         for i = 1, 10, 1 do
        --             table.insert(
        --                 state.current_level.entities.bullets, 
        --                 bullet(
        --                     self.pos, 
        --                     vector.from_angle(math.rad((i * 2 * state.time + i * 0.2 / 360 )*  love.math.random( -100, 100 ) / 100), 5),
        --                     vector.new(0,0),
        --                     3, 
        --                     "energyball", 
        --                     "orange"
        --                 )
        --             )
        --         end
        --     end
        --     -- if state.time % 4 == 0 then
            --     for i = -2, 2, 1 do
            --         table.insert(
            --             state.current_level.entities,
            --             bullet(
            --                 self.pos,
            --                 vector.from_angle(math.rad(math.deg(vector.angle((state.player.pos - self.pos):normalize())) + i * 5)) * 6,
            --                 vector.new(),
            --                 3,
            --                 "grayball",
            --                 "yellow"
            --             )
            --         )
            --     end
            -- end

        -- elseif enemy_type == "aiming" then
        --     if state.time % 4 == 0 then
        --         for i = -2, 2, 1 do
        --             table.insert(
        --                 state.current_level.entities.bullets,
        --                 bullet(
        --                     self.pos,
        --                     vector.from_angle(math.rad(math.deg(vector.angle((state.player.pos - self.pos):normalize())) + i * 5)) * 6,
        --                     vector.new(),
        --                     3,
        --                     "grayball",
        --                     "yellow"
        --                 )
        --             )
        --         end
        --     end
        -- end
    end

    return entity
end