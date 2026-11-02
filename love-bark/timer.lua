---@class LoveTimer
local timer = {
    delta = 1,
    unscaledDelta = 1,
    unscaledTime = 0
}

---@return number
function timer.getDelta()
    return timer.delta
end

---@return number
function timer.getUnscaledDelta()
    return timer.unscaledDelta
end

---@return number
function timer.getUnscaledTime()
    return timer.unscaledTime
end

function timer.update()
    timer.delta = CS.UnityEngine.Time.deltaTime
    timer.unscaledDelta = CS.UnityEngine.Time.unscaledDeltaTime
    timer.unscaledTime = CS.UnityEngine.Time.unscaledTime
end

return timer