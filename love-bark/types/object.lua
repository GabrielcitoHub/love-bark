---@class LoveObject
local object = {}

function object:release()
    if self.__released then return false end

    self.__released = true

    if self.__release then
        self:__release()
    end

    return true
end

function object:type()
    return self.__type
end

function object:typeOf(name)
    local current = self

    while current do
        if current.__type == name then
            return true
        end

        current = getmetatable(current)
            and getmetatable(current).__index
    end

    return false
end

return object