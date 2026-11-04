---@class LovePlayer : LoveModule
local player = {}

function onPlayerJumpStart()
    player.love.call(player.love.jumped)
end

function onPlayerJumpOver()
    player.love.call(player.love.landed)
end

function onPlayerDeath()
    player.love.call(player.love.died)
end

return player