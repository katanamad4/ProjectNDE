local colision = {}
colision.__index = colision

colision.circleCircle = function(a, b)
    if a.radius and b.radius and a.posX and b.posX and a.posY and b.posY then 
        local dx, dy = vec.sub(a.posX, a.posY, b.posX, b.posY)
        local radii = a.radius + b.radius
        return dx*dx + dy*dy < radii*radii
    else
        error("invalid entities for colision")
    end
end

colision.aabbAabb = function(a, b) --unused
    return a.X < b.X + b.w and
           b.X < a.X + a.w and
           a.Y < b.Y + b.h and
           b.Y < a.Y + a.h
end

colision.functions = {
    circle = {
        circle = colision.circleCircle,
        -- aabb = colision.circleAabb,
    },

    aabb = {
        -- circle = colision.circleAabb,
        aabb = colision.aaabbAabb,
    },
}

colision.findFunc = function(ent1, ent2)
    return colision.functions[ent1.hitbox_type][ent2.hitbox_type]
end

return colision