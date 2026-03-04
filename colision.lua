local colision = {}
-- colision.__index = colision

colision.circle_circle = function(a, b)
    local dx = b.pos.x - a.pos.x
    local dy = b.pos.y - a.pos.y
    local radii = a.radius + b.radius

    return dx*dx + dy*dy < radii*radii
end

colision.rect_rect = function(a, b)
    return a.x < b.x + b.w and
           b.x < a.x + a.w and
           a.y < b.y + b.h and
           b.y < a.y + a.h
end

return colision