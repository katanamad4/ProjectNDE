local vector = {}
vector.__index = vector

function vector.new(x, y)
    local self = setmetatable({}, vector)
    self.x = x or 0
    self.y = y or 0
    return self
end

function vector.__add(a, b)
    if type(b) == "number" then
        return vector.new(a.x + b, a.y + b)
    else
        return vector.new(a.x + b.x, a.y + b.y)
    end
end

function vector.__sub(a, b)
if type(b) == "number" then
        return vector.new(a.x - b, a.y - b)
    else
        return vector.new(a.x - b.x, a.y - b.y)
    end
end

function vector.__mul(a, b)
    if type(a) == "number" then
        return vector.new(a * b.x, a * b.y)
    elseif type(b) == "number" then
        return vector.new(a.x * b, a.y * b)
    else
        return vector.new(a.x * b.x, a.y * b.y)
    end
end


function vector.__div(a, b)
    if type(a) == "number" then
        return vector.new(a / b.x, a / b.y)
    elseif type(b) == "number" then
        return vector.new(a.x / b, a.y / b)
    else
        return vector.new(a.x / b.x, a.y / b.y)
    end
end

function vector:length()
    return (math.sqrt( self.x * self.x + self.y * self.y ))
end

function vector:length_squared()
    return (self.x * self.x + self.y * self.y )
end

function vector:normalize()
    local len = self:length()
    if len == 0 then
        return vector.new(0, 0)
    end 
    return vector.new( self.x / len, self.y / len)
end

function vector:dot(other)
    return self.x * other.x + self.y * other.y
end

function vector:distance(other)
    return (self - other):length()
end

function vector:distance_squared(other)
    return (self - other):length_squared()
end

function vector:clone()
    return vector.new(self.x, self.y)
end

function vector:limit(max)
    if self:length_squared() > max * max then
        return self:normalize() * max
    end
    return self
end

function vector:angle()
    return math.atan2(self.y, self.x)
end

function vector.from_angle(angle, length)
    length = length or 1
    return vector.new(
        math.cos(angle) * length,
        math.sin(angle) * length
    )
end

return vector

