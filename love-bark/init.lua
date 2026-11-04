local _, absolutePath = ...

-- Normalize separators
absolutePath = absolutePath:gsub("\\", "/")

-- Find the Mods directory
local modsStart = absolutePath:find("/ScriptMod/Mods/", 1, true)

assert(modsStart, "Could not locate ScriptMod/Mods in module path")

-- Find the beginning of the mod folder name
local modNameStart = modsStart + #"/ScriptMod/Mods/"

-- Find the end of the mod folder name
local modNameEnd = absolutePath:find("/", modNameStart, true)

assert(modNameEnd, "Could not locate mod folder")

-- Extract both paths
local modPath = absolutePath:sub(1, modNameEnd - 1)
local modulePath = absolutePath:sub(modNameEnd + 1)

-- Remove init.lua
modulePath = modulePath:match("^(.*)/[^/]+$")
local moduleRequirePath = modulePath:gsub("/", ".")

local newPaths = {
    modPath .. "/?.lua",
    modPath .. "/?/init.lua"
}

for _, path in ipairs(newPaths) do
    if not package.path:find(path, 1, true) then
        package.path = package.path .. ";" .. path
    end
end

local function requiremodule(path)
    local requirePath = moduleRequirePath .. "." .. path
    return require(requirePath)
end

_G.unpack = table.unpack

---@class LoveLog
local function log(...)
    local args = {}

    for i = 1, select("#", ...) do
        args[i] = tostring(select(i, ...))
    end

    Log:Info(table.concat(args, "\t"))
end

---@class Love
local love = {
    crashed = false,
    error = nil
}

local function attachmodule(path)
    local module = requiremodule(path)
    module.love = love

    return module
end

function love.errorhandler(err)
    local traceback = debug.traceback(tostring(err), 2)
    local love_bark_err = "[love-bark] Error:\n" .. traceback
    print(love_bark_err)

    love.crashed = true

    return function()
        local graphics = love.graphics

        graphics.clear(89 / 255, 157 / 255, 220 / 255, 0.1)

        graphics.setColor(1, 1, 1, 1)

        local x, y = 30, 70
        local width = graphics.getPixelWidth()
        graphics.printf(love_bark_err, x, y, width - x, "left")

        graphics.update()
    end
end

function love.call(callback, ...)
    local args = {...}

    local success, result = xpcall(function()
        return callback(unpack(args))
    end, love.errorhandler)

    if not success then
        love.error = result
    end

    return success, result
end

-- love

---@type LoveAudio
love.audio = attachmodule("audio")

---@type LoveGraphics
love.graphics = attachmodule("graphics")

---@type LoveTimer
love.timer = requiremodule("timer")

love.keyboard = attachmodule("keyboard")

---@type LoveMouse
love.mouse = attachmodule("mouse")


-- bark

---@type LovePlayer
love.player = attachmodule("bark.player")

---@type LoveBody
love.body = attachmodule("bark.body")

---@class LoveModule
---@field love Love

-- Use only for cheap and dirty callback implementation
function love.callback(name, ...)
    local fn = love[name]
    if type(fn) ~= "function" then return end

    return fn(...)
end

-- *Override* Called when the game is loaded.
function love.load()
end

-- *Override* Called every frame when the game updates.
---@param dt number
---@param udt number
function love.update(dt, udt)
end

-- *Override* Called every frame when the game draws.
function love.draw()
end

function onLoad()
    love.call(love.load)

    love.graphics.load()
    love.mouse.load()
end

function love.run()
    if love.crashed then
        love.error()
        return
    end

    local timer = love.timer
    if timer then
        timer.update()
    end

    local keyboard = love.keyboard
    if keyboard then
        keyboard.update()
    end

    local mouse = love.mouse
    if mouse then
        mouse.update()
    end

    local graphics = love.graphics
    if graphics then
        graphics.preUpdate()
        graphics.clear()
    end

    local dt = love.timer:getDelta()
    local udt = love.timer:getUnscaledDelta()
    love.call(love.update, dt, udt)
    
    love.call(love.draw)

    local graphics = love.graphics
    if graphics then
        graphics.update()
    end
end

function onUpdate()
    love.run()
end

-- *Override* Called when the mod is disabled.
function love.quit()
end

function onDisable()
    local graphics = love.graphics
    if graphics then
        graphics.clear()
        graphics.release()
    end

    love.quit()
end

-- Keyboard Events

-- *Override* Called when pressing a key.
function love.keypressed(key, scancode, isrepeat)
end

-- *Override* Called when releasing a key.
function love.keyreleased(key, scancode)
end

-- Mouse Events

---@alias LoveMouseMovedEvent fun(x: number, y: number, dx: number, dy: number)

-- *Override* Called when the mouse moves across the screen.
---@type LoveMouseMovedEvent
function love.mousemoved(x, y, dx, dy)
end

-- *Override* Called when the mouse moves across the screen... even outside of the screen.
---@type LoveMouseMovedEvent
function love.mousemovedglobal(x, y, dx, dy)
end

-- *Override* Called when the mouse moves across the world.
---@type LoveMouseMovedEvent
function love.mousemovedworld(x, y, dx, dy)
end

-- *Override* Called when the mouse moves across the world even outside the screen.
---@type LoveMouseMovedEvent
function love.mousemovedworldglobal(x, y, dx, dy)
end

-- *Override* Called when the mouse moves across a tile.
---@type LoveMouseMovedEvent
function love.mousemovedtile(x, y, dx, dy)
end

-- *Override* Called when the mouse moves across a tile even outside the screen.
---@type LoveMouseMovedEvent
function love.mousemovedtileglobal(x, y, dx, dy)
end

---@alias LoveMousePressReleaseEvent fun(x: number, y: number, button: number, istouch: boolean, presses: number)

---@type LoveMousePressReleaseEvent
function love.mousepressed(x, y, button, istouch, presses)
end

---@type LoveMousePressReleaseEvent
function love.mousepressedworld(x, y, button, istouch, presses)
end

---@type LoveMousePressReleaseEvent
function love.mousepressedtile(x, y, button, istouch, presses)
end

---@type LoveMousePressReleaseEvent
function love.mousereleased(x, y, button, istouch, presses)
end

---@type LoveMousePressReleaseEvent
function love.mousereleasedworld(x, y, button, istouch, presses)
end

---@type LoveMousePressReleaseEvent
function love.mousereleasedtile(x, y, button, istouch, presses)
end

---@param x number
---@param y number
-- *Override* Called while scrolling with the mouse wheel.
function love.wheelmoved(x, y)
end

-- Bark

-- Player Events

function love.jumped()
end

function love.landed()
end

function love.died()
end

-- Body Events

function love.cardiacarrest()
end

function love.cardiacarrestrecover()
end

function love.fibrillation()
end

function love.fibrillationrecover()
end

function love.breathstop()
end

function love.breathrecover()
end

function love.unconscious()
end

function love.conscious()
end

function love.braindying()
end

function love.braindyingrecover()
end

function love.climb()
end

function love.climbend()
end

function love.exercise()
end

function love.exerciseend()
end

function love.switchhands()
end

---@param right boolean True if the character is now facing right, false if facing left.
function love.turnaround(right)
end

function love.crouch()
end

function love.uncrouch()
end

---@param itemid string
---@param slot integer
function love.pickup(itemid, slot)
end

---@param itemid integer
function love.drop(itemid)
end

function love.fellasleep()
end

function love.wokeup()
end

function love.laststand()
end

function love.disfigure()
end

---@param eyeless boolean True if lost both eyes, false otherwise.
function love.losteye(eyeless)
end

love.log = log

return love