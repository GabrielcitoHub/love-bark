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

local function moduleRequire(path)
    local requirePath = moduleRequirePath .. "." .. path
    return require(requirePath)
end

---@class Love
local love = {}

local function attachmodule(path)
    local module = moduleRequire(path)
    module.love = love

    if module.load then
        module.load()
    end

    return module
end

---@type LoveAudio
love.audio = attachmodule("audio")

---@type LoveGraphics
love.graphics = attachmodule("graphics")

---@type LoveTimer
love.timer = moduleRequire("timer")

love.keyboard = attachmodule("keyboard")

---@type LoveMouse
love.mouse = attachmodule("mouse")

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
    love.load()
end

function onUpdate()
    local timer = love.timer
    if timer then
        timer.update()
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
    love.update(dt, udt)
    
    love.draw()

    local graphics = love.graphics
    if graphics then
        graphics.update()
    end
end

function onDisable()
    local graphics = love.graphics
    if graphics then
        graphics.clear()
        graphics.__release()
    end
end

---@class LoveLog
local function log(...)
    local args = {}

    for i = 1, select("#", ...) do
        args[i] = tostring(select(i, ...))
    end

    Log:Info(table.concat(args, "\t"))
end

-- *Override* Called when the mouse moves across the screen.
---@param x number
---@param y number
---@param dx number
---@param dy number
function love.mousemoved(x, y, dx, dy)
end

-- *Override* Called when the mouse moves across the screen... even outside of the screen.
---@param x number
---@param y number
---@param dx number
---@param dy number
function love.mousemovedglobal(x, y, dx, dy)
end

-- *Override* Called when the mouse moves across the world.
---@param x number
---@param y number
---@param dx number
---@param dy number
function love.mousemovedworld(x, y, dx, dy)
end

-- *Override* Called when the mouse moves across the world even outside the screen.
---@param x number
---@param y number
---@param dx number
---@param dy number
function love.mousemovedworldglobal(x, y, dx, dy)
end

-- *Override* Called when the mouse moves across a tile.
---@param x number
---@param y number
---@param dx number
---@param dy number
function love.mousemovedtile(x, y, dx, dy)
end

-- *Override* Called when the mouse moves across a tile even outside the screen.
---@param x number
---@param y number
---@param dx number
---@param dy number
function love.mousemovedtileglobal(x, y, dx, dy)
end

local data = {
    love = love,
    log = log,
}

return data