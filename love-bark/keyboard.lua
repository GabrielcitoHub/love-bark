---@class LoveKeyboard
local keyboard = {}

function keyboard.isDown(key, ...)
    local keys = {key}
    for i, key in ipairs(...) do
        table.insert(keys, #keys, key)
    end

    for _, key in ipairs(keys) do
        
    end

    return false
end

return keyboard