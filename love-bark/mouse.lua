---@class LoveMouse : LoveModule
local mouse = {
    buttonMap = {
        l = 0, -- Left
        r = 1, -- Right
        m = 2, -- Middle
        x1 = 3, -- Extra 1
        x2 = 4, -- Extra 2
    },

    position = {
        x = 0,
        y = 0
    },
    last = {
        x = 0,
        y = 0,
    },

    global_position = {
        x = 0,
        y = 0
    },
    global_last = {
        x = 0,
        y = 0,
    },

    world_position = {
        x = 0,
        y = 0
    },
    world_last = {
        x = 0,
        y = 0
    },

    global_world_position = {
        x = 0,
        y = 0
    },
    global_world_last = {
        x = 0,
        y = 0
    },

    tile_position = {
        x = 0,
        y = 0
    },

    tile_last = {
        x = 0,
        y = 0
    },

    global_tile_position = {
        x = 0,
        y = 0
    },

    global_tile_last = {
        x = 0,
        y = 0
    },
}

function mouse.load()
    mouse.updatePosition()
    mouse.updatePositionGlobal()
    mouse.updatePositionWorld()
    mouse.updatePositionWorldGlobal()
    mouse.updatePositionTile()
    mouse.updatePositionTileGlobal()

    mouse.updateLastPosition()
    mouse.updateLastPositionGlobal()
    mouse.updateLastPositionWorld()
    mouse.updateLastPositionWorldGlobal()
    mouse.updateLastPositionTile()
    mouse.updateLastPositionTileGlobal()
end

---@param button number|string
---@param ... number|string?
function mouse.isDown(button, ...)
    for i = 0, select("#", ...) do
        local currentButton = (i == 0) and button or select(i, ...)
        local unityButton = mouse.buttonMap[currentButton]
            or (type(currentButton) == "number" and currentButton - 1)

        if unityButton and unityButton >= 0 then
            if CS.UnityEngine.Input.GetMouseButton(unityButton) then
                return true
            end
        end
    end

    return false
end

---@return number, number
function mouse.getGlobalPosition()
    local position = CS.UnityEngine.Input.mousePosition
    local height = mouse.love.graphics.getPixelHeight()

    return position.x, height - position.y
end

function mouse.getGlobalX()
    local x = mouse.getGlobalPosition()
    return x
end

function mouse.getGlobalY()
    local _, y = mouse.getGlobalPosition()
    return y
end

function mouse.getPosition()
    local x, y = mouse.getGlobalPosition()
    local width, height = mouse.love.graphics.getPixelDimensions()

    if x < 0 or x > width or y < 0 or y > height then
        local last = mouse.last
        return last.x or x, last.y or y
    end

    return x, y
end

function mouse.getX()
    local x = mouse.getPosition()
    return x
end

function mouse.getY()
    local _, y = mouse.getPosition()
    return y
end

---@return number, number
function mouse.getWorldPositionGlobal()
    local position = Input:GetMousePosition()
    return position.x, position.y
end

function mouse.getWorldGlobalX()
    local x = mouse.getWorldPositionGlobal()
    return x
end

function mouse.getWorldGlobalY()
    local _, y = mouse.getWorldPositionGlobal()
    return y
end

function mouse.getWorldPosition()
    local x, y = mouse.getWorldPositionGlobal()
    local screen_x, screen_y = mouse.getGlobalPosition()
    local width, height = mouse.love.graphics.getPixelDimensions()

    if screen_x < 0 or screen_x > width or screen_y < 0 or screen_y > height then
        local last = mouse.world_last
        return last.x or x, last.y or y
    end

    return x, y
end

function mouse.getWorldX()
    local x = mouse.getWorldPosition()
    return x
end

function mouse.getWorldY()
    local _, y = mouse.getWorldPosition()
    return y
end

---@return integer, integer
function mouse.getTilePositionGlobal()
    local x, y = mouse.getWorldPositionGlobal()
    local tilePos = World:ToTilePosition(x, y)
    return tilePos.x, tilePos.y
end

function mouse.getTileGlobalX()
    local x = mouse.getTilePositionGlobal()
    return x
end

function mouse.getTileGlobalY()
    local _, y = mouse.getTilePositionGlobal()
    return y
end

function mouse.getTilePosition()
    local x, y = mouse.getTilePositionGlobal()
    local screen_x, screen_y = mouse.getGlobalPosition()
    local width, height = mouse.love.graphics.getPixelDimensions()

    if screen_x < 0 or screen_x > width or screen_y < 0 or screen_y > height then
        local last = mouse.tile_last
        return last.x or x, last.y or y
    end

    return x, y
end

function mouse.getTileX()
    local x = mouse.getTilePosition()
    return x
end

function mouse.getTileY()
    local _, y = mouse.getTilePosition()
    return y
end

function mouse.getLastPosition()
    local last = mouse.last
    return last.x, last.y
end

function mouse.getLastGlobalPosition()
    local last = mouse.global_last
    return last.x, last.y
end

function mouse.getLastWorldPosition()
    local last = mouse.world_last
    return last.x, last.y
end

function mouse.getLastGlobalWorldPosition()
    local last = mouse.global_world_last
    return last.x, last.y
end

function mouse.getLastTilePosition()
    local last = mouse.tile_last
    return last.x, last.y
end

function mouse.getLastGlobalTilePosition()
    local last = mouse.global_tile_last
    return last.x, last.y
end

function mouse.updatePosition()
    local x, y = mouse.getPosition()
    mouse.position.x = x
    mouse.position.y = y
end

function mouse.updateLastPosition()
    local x, y = mouse.getPosition()
    mouse.last.x = x
    mouse.last.y = y
end

function mouse.updatePositionGlobal()
    local x, y = mouse.getGlobalPosition()
    mouse.global_position.x = x
    mouse.global_position.y = y
end

function mouse.updateLastPositionGlobal()
    local x, y = mouse.getGlobalPosition()
    mouse.global_last.x = x
    mouse.global_last.y = y
end

function mouse.updatePositionWorld()
    local x, y = mouse.getWorldPosition()
    mouse.world_position.x = x
    mouse.world_position.y = y
end

function mouse.updateLastPositionWorld()
    local x, y = mouse.getWorldPosition()
    mouse.world_last.x = x
    mouse.world_last.y = y
end

function mouse.updatePositionWorldGlobal()
    local x, y = mouse.getWorldPositionGlobal()
    mouse.global_world_position.x = x
    mouse.global_world_position.y = y
end

function mouse.updateLastPositionWorldGlobal()
    local x, y = mouse.getWorldPositionGlobal()
    mouse.global_world_last.x = x
    mouse.global_world_last.y = y
end

function mouse.updatePositionTile()
    local x, y = mouse.getTilePosition()
    mouse.tile_position.x = x
    mouse.tile_position.y = y
end

function mouse.updateLastPositionTile()
    local x, y = mouse.getTilePosition()
    mouse.tile_last.x = x
    mouse.tile_last.y = y
end

function mouse.updatePositionTileGlobal()
    local x, y = mouse.getTilePositionGlobal()
    mouse.global_tile_position.x = x
    mouse.global_tile_position.y = y
end

function mouse.updateLastPositionTileGlobal()
    local x, y = mouse.getTilePositionGlobal()
    mouse.global_tile_last.x = x
    mouse.global_tile_last.y = y
end

function mouse.updatePositionEvent()
    mouse.updatePosition()

    local x, y = mouse.getPosition()
    local lastX, lastY = mouse.getLastPosition()
    if x ~= lastX or y ~= lastY then
        local dx = x - lastX
        local dy = y - lastY
        mouse.love.mousemoved(x, y, dx, dy)
    end
    
    mouse.updateLastPosition()
end

function mouse.updateGlobalPositionEvent()
    mouse.updatePositionGlobal()

    local x, y = mouse.getGlobalPosition()
    local lastX, lastY = mouse.getLastGlobalPosition()
    if x ~= lastX or y ~= lastY then
        local dx = x - lastX
        local dy = y - lastY
        mouse.love.mousemovedglobal(x, y, dx, dy)
    end
    
    mouse.updateLastPositionGlobal()
end

function mouse.updateWorldPositionEvent()
    mouse.updatePositionWorld()

    local x, y = mouse.getWorldPosition()
    local lastX, lastY = mouse.getLastWorldPosition()
    if x ~= lastX or y ~= lastY then
        local dx = x - lastX
        local dy = y - lastY
        mouse.love.mousemovedworld(x, y, dx, dy)
    end

    mouse.updateLastPositionWorld()
end

function mouse.updateGlobalWorldPositionEvent()
    mouse.updatePositionWorldGlobal()

    local x, y = mouse.getWorldPositionGlobal()
    local lastX, lastY = mouse.getLastGlobalWorldPosition()
    if x ~= lastX or y ~= lastY then
        local dx = x - lastX
        local dy = y - lastY
        mouse.love.mousemovedworldglobal(x, y, dx, dy)
    end

    mouse.updateLastPositionWorldGlobal()
end

function mouse.updateTilePositionEvent()
    mouse.updatePositionTile()

    local x, y = mouse.getTilePosition()
    local lastX, lastY = mouse.getLastTilePosition()
    if x ~= lastX or y ~= lastY then
        local dx = x - lastX
        local dy = y - lastY
        mouse.love.mousemovedtile(x, y, dx, dy)
    end
    
    mouse.updateLastPositionTile()
end

function mouse.updateGlobalTilePositionEvent()
    mouse.updatePositionTileGlobal()

    local x, y = mouse.getTilePositionGlobal()
    local lastX, lastY = mouse.getLastGlobalTilePosition()
    if x ~= lastX or y ~= lastY then
        local dx = x - lastX
        local dy = y - lastY
        mouse.love.mousemovedtileglobal(x, y, dx, dy)
    end
    
    mouse.updateLastPositionTileGlobal()
end

function mouse.update()
    mouse.updatePositionEvent()
    mouse.updateGlobalPositionEvent()
    mouse.updateWorldPositionEvent()
    mouse.updateGlobalWorldPositionEvent()
    mouse.updateTilePositionEvent()
    mouse.updateGlobalTilePositionEvent()
end

return mouse