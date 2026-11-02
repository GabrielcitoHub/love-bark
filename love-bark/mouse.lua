---@class LoveMouse : LoveModule
local mouse = {
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

    buttonMap = {
        l = 0, -- Left
        r = 1, -- Right
        m = 2, -- Middle
        x1 = 3, -- Extra 1
        x2 = 4, -- Extra 2
    },

    doubleClickDelay = 0.3, -- Seconds
    doubleClickDistance = 10, -- Pixels

    clicks = {},
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
    local position = mouse.global_position
    return position.x, position.y
end

function mouse.getGlobalX()
    local x = mouse.getGlobalPosition()
    return x
end

function mouse.getGlobalY()
    local _, y = mouse.getGlobalPosition()
    return y
end

function mouse.outScreen(x, y)
    local width, height = mouse.love.graphics.getPixelDimensions()
    return x < 0 or x > width or y < 0 or y > height
end

---@param x number
---@param y number
---@param lastX number
---@param lastY number
function mouse._getPosition(x, y, lastX, lastY)
    local outScreen = mouse.outScreen(x, y)

    if outScreen then
        return lastX or x, lastY or y
    end

    return x, y
end

function mouse.getPosition()
    local x, y = mouse.getGlobalPosition()
    local lastX, lastY = mouse.getLastPosition()

    return mouse._getPosition(x, y, lastX, lastY)
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
    local lastX, lastY = mouse.getLastWorldPosition()

    return mouse._getPosition(x, y, lastX, lastY)
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
    local lastX, lastY = mouse.getLastTilePosition()

    return mouse._getPosition(x, y, lastX, lastY)
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

function mouse.updatePositionGlobal()
    local unityPosition = CS.UnityEngine.Input.mousePosition
    local height = mouse.love.graphics.getPixelHeight()

    mouse.global_position.x = unityPosition.x
    mouse.global_position.y = height - unityPosition.y
end

function mouse.updatePositionWorld()
    local x, y = mouse.getWorldPosition()
    mouse.world_position.x = x
    mouse.world_position.y = y
end

function mouse.updatePositionWorldGlobal()
    local x, y = mouse.getWorldPositionGlobal()
    mouse.global_world_position.x = x
    mouse.global_world_position.y = y
end

function mouse.updatePositionTile()
    local x, y = mouse.getTilePosition()
    mouse.tile_position.x = x
    mouse.tile_position.y = y
end

function mouse.updatePositionTileGlobal()
    local x, y = mouse.getTilePositionGlobal()
    mouse.global_tile_position.x = x
    mouse.global_tile_position.y = y
end

function mouse.updateLastPosition(last, position)
    last = last or mouse.last
    position = position or mouse.position
    last.x = position.x
    last.y = position.y
end

function mouse.updateLastPositionGlobal()
    mouse.updateLastPosition(mouse.global_last, mouse.global_position)
end

function mouse.updateLastPositionWorld()
    mouse.updateLastPosition(mouse.world_last, mouse.world_position)
end

function mouse.updateLastPositionWorldGlobal()
    mouse.updateLastPosition(mouse.global_world_last, mouse.global_world_position)
end

function mouse.updateLastPositionTile()
    mouse.updateLastPosition(mouse.tile_last, mouse.tile_position)
end

function mouse.updateLastPositionTileGlobal()
    mouse.updateLastPosition(mouse.global_tile_last, mouse.global_tile_position)
end

---@param x number
---@param y number
---@param lastX number
---@param lastY number
function mouse.moved(x, y, lastX, lastY)
    if x ~= lastX or y ~= lastY then
        local dx = x - lastX
        local dy = y - lastY
        return true, dx, dy
    end

    return false, 0, 0
end

function mouse.updateGlobalPositionEvent()
    local x, y = mouse.getGlobalPosition()
    local lastX, lastY = mouse.getLastGlobalPosition()
    local moved, dx, dy = mouse.moved(x, y, lastX, lastY)
    if moved then
        mouse.love.call(mouse.love.mousemovedglobal, x, y, dx, dy)
    end
end

function mouse.updatePositionEvent()
    local x, y = mouse.getPosition()
    local lastX, lastY = mouse.getLastPosition()
    local moved, dx, dy = mouse.moved(x, y, lastX, lastY)
    if moved then
        mouse.love.call(mouse.love.mousemoved, x, y, dx, dy)
    end
end

function mouse.updateGlobalWorldPositionEvent()
    local x, y = mouse.getWorldPositionGlobal()
    local lastX, lastY = mouse.getLastGlobalWorldPosition()
    local moved, dx, dy = mouse.moved(x, y, lastX, lastY)
    if moved then
        mouse.love.call(mouse.love.mousemovedworldglobal, x, y, dx, dy)
    end
end

function mouse.updateWorldPositionEvent()
    local x, y = mouse.getWorldPosition()
    local lastX, lastY = mouse.getLastWorldPosition()
    local moved, dx, dy = mouse.moved(x, y, lastX, lastY)
    if moved then
        mouse.love.call(mouse.love.mousemovedworld, x, y, dx, dy)
    end
end

function mouse.updateGlobalTilePositionEvent()
    local x, y = mouse.getTilePositionGlobal()
    local lastX, lastY = mouse.getLastGlobalTilePosition()
    local moved, dx, dy = mouse.moved(x, y, lastX, lastY)
    if moved then
        mouse.love.call(mouse.love.mousemovedtileglobal, x, y, dx, dy)
    end
end

function mouse.updateTilePositionEvent()
    local x, y = mouse.getTilePosition()
    local lastX, lastY = mouse.getLastTilePosition()
    local moved, dx, dy = mouse.moved(x, y, lastX, lastY)
    if moved then
        mouse.love.call(mouse.love.mousemovedtile, x, y, dx, dy)
    end
end

---@param button number
---@param presses number
function mouse.pressed(button, presses)
    local love = mouse.love

    local x, y = mouse.getPosition()
    love.call(mouse.love.mousepressed, x, y, button, false, presses)

    local world_x, world_y = mouse.getWorldPosition()
    love.call(mouse.love.mousepressedworld, world_x, world_y, button, false, presses)

    local tile_x, tile_y = mouse.getTilePosition()
    love.call(mouse.love.mousepressedtile, tile_x, tile_y, button, false, presses)
end

---@param button number
---@param presses number
function mouse.released(button, presses)
    local love = mouse.love

    local x, y = mouse.getPosition()
    love.call(mouse.love.mousereleased, x, y, button, false, presses)

    local world_x, world_y = mouse.getWorldPosition()
    love.call(mouse.love.mousereleasedworld, world_x, world_y, button, false, presses)

    local tile_x, tile_y = mouse.getTilePosition()
    love.call(mouse.love.mousereleasedtile, tile_x, tile_y, button, false, presses)
end

---@param button number
---@param pressed boolean
function mouse.getPressCount(button, pressed)
    local x, y = mouse.getPosition()
    local timer = mouse.love.timer.getUnscaledTime()

    mouse.clicks[pressed] = mouse.clicks[pressed] or {}
    local previous = mouse.clicks[pressed][button]

    local presses = 1

    if previous then
        local dx = x - previous.x
        local dy = y - previous.y
        local distanceSquared = dx * dx + dy * dy

        if timer - previous.time <= mouse.doubleClickDelay
            and distanceSquared <= mouse.doubleClickDistance ^ 2 then
            presses = previous.presses + 1
        end
    end

    mouse.clicks[pressed][button] = {
        x = x,
        y = y,
        time = timer,
        presses = presses
    }

    return presses
end

function mouse.updateButtonEvents()
    local input = CS.UnityEngine.Input

    for unityButton = 0, 4 do
        -- Love2D uses 1-based button indices.
        local button = unityButton + 1

        if input.GetMouseButtonDown(unityButton) then
            local presses = mouse.getPressCount(button, true)
            mouse.pressed(button, presses)
        end

        if input.GetMouseButtonUp(unityButton) then
            local presses = mouse.getPressCount(button, false)
            mouse.released(button, presses)
        end
    end
end

function mouse.update()
    mouse.updatePositionGlobal()
    mouse.updateGlobalPositionEvent()
    mouse.updateLastPositionGlobal()
    
    mouse.updatePosition()
    mouse.updatePositionEvent()
    mouse.updateLastPosition()

    mouse.updatePositionWorldGlobal()
    mouse.updateGlobalWorldPositionEvent()
    mouse.updateLastPositionWorldGlobal()
    
    mouse.updatePositionWorld()
    mouse.updateWorldPositionEvent()
    mouse.updateLastPositionWorld()

    mouse.updatePositionTileGlobal()
    mouse.updateGlobalTilePositionEvent()
    mouse.updateLastPositionTileGlobal()

    mouse.updatePositionTile()
    mouse.updateTilePositionEvent()
    mouse.updateLastPositionTile()

    mouse.updateButtonEvents()
end

return mouse