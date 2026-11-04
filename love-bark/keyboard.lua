local KeyCode = CS.UnityEngine.KeyCode

---@class LoveKeyboard : LoveModule
local keyboard = {
    keyMap = {
        -- Letters
        a = KeyCode.A,
        b = KeyCode.B,
        c = KeyCode.C,
        d = KeyCode.D,
        e = KeyCode.E,
        f = KeyCode.F,
        g = KeyCode.G,
        h = KeyCode.H,
        i = KeyCode.I,
        j = KeyCode.J,
        k = KeyCode.K,
        l = KeyCode.L,
        m = KeyCode.M,
        n = KeyCode.N,
        o = KeyCode.O,
        p = KeyCode.P,
        q = KeyCode.Q,
        r = KeyCode.R,
        s = KeyCode.S,
        t = KeyCode.T,
        u = KeyCode.U,
        v = KeyCode.V,
        w = KeyCode.W,
        x = KeyCode.X,
        y = KeyCode.Y,
        z = KeyCode.Z,

        -- Numbers
        ["0"] = KeyCode.Alpha0,
        ["1"] = KeyCode.Alpha1,
        ["2"] = KeyCode.Alpha2,
        ["3"] = KeyCode.Alpha3,
        ["4"] = KeyCode.Alpha4,
        ["5"] = KeyCode.Alpha5,
        ["6"] = KeyCode.Alpha6,
        ["7"] = KeyCode.Alpha7,
        ["8"] = KeyCode.Alpha8,
        ["9"] = KeyCode.Alpha9,

        -- Common keys
        space = KeyCode.Space,
        ["return"] = KeyCode.Return,
        escape = KeyCode.Escape,
        backspace = KeyCode.Backspace,
        tab = KeyCode.Tab,
        delete = KeyCode.Delete,
        insert = KeyCode.Insert,

        -- Modifiers
        lshift = KeyCode.LeftShift,
        rshift = KeyCode.RightShift,
        lctrl = KeyCode.LeftControl,
        rctrl = KeyCode.RightControl,
        lalt = KeyCode.LeftAlt,
        ralt = KeyCode.RightAlt,

        -- Arrows
        up = KeyCode.UpArrow,
        down = KeyCode.DownArrow,
        left = KeyCode.LeftArrow,
        right = KeyCode.RightArrow,

        -- Function keys
        f1 = KeyCode.F1,
        f2 = KeyCode.F2,
        f3 = KeyCode.F3,
        f4 = KeyCode.F4,
        f5 = KeyCode.F5,
        f6 = KeyCode.F6,
        f7 = KeyCode.F7,
        f8 = KeyCode.F8,
        f9 = KeyCode.F9,
        f10 = KeyCode.F10,
        f11 = KeyCode.F11,
        f12 = KeyCode.F12,
    },

    delay = 0.8,
    interval = 0.05,

    held = {},
}

---@param key string
function keyboard.toKeyCode(key)
    ---@type CSUnityEngineKeyCode
---@diagnostic disable-next-line: assign-type-mismatch
    local keyCode = keyboard.keyMap[key]
    return keyCode
end

---@param key string
---@param ... string
function keyboard.isDown(key, ...)
    local unityKey = keyboard.toKeyCode(key)

    if unityKey and CS.UnityEngine.Input.GetKey(unityKey) then
        return true
    end

    for i = 1, select("#", ...) do
        unityKey = keyboard.toKeyCode(select(i, ...))

        if unityKey and CS.UnityEngine.Input.GetKey(unityKey) then
            return true
        end
    end

    return false
end

function keyboard.pressed(key, scancode, isrepeat)
    keyboard.love.keypressed(key, scancode, isrepeat)
end

function keyboard.released(key, scancode)
    keyboard.love.keyreleased(key, scancode)
end

function keyboard.updateKeyEvents()
    local input = CS.UnityEngine.Input
    local timer = keyboard.love.timer

    local dt = timer.getDelta()

    for key, keyCode in pairs(keyboard.keyMap) do
        local scancode = (scancodeMap and scancodeMap[key]) or key
        if input.GetKeyDown(keyCode) then
            keyboard.held[key] = {
                repeatTimer = keyboard.delay
            }

            keyboard.pressed(key, scancode, false)

        elseif input.GetKey(keyCode) then
            local state = keyboard.held[key]

            if state then
                state.repeatTimer = state.repeatTimer - dt

                while state.repeatTimer <= 0 do
                    keyboard.pressed(key, scancode, true)
                    state.repeatTimer = state.repeatTimer + keyboard.interval
                end
            end

        elseif keyboard.held[key] then
            keyboard.held[key] = nil

            keyboard.released(key, scancode)
        end
    end
end

function keyboard.update()
    keyboard.updateKeyEvents()
end

return keyboard