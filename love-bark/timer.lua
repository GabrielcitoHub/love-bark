---@class LoveTimer
local timer = {
    delta = 1,
    unscaledDelta = 1
}

---@return number
function timer.getDelta()
    return timer.delta
end

---@return number
function timer.getUnscaledDelta()
    return timer.unscaledDelta
end

function timer.update()
    timer.delta = CS.UnityEngine.Time.deltaTime
    timer.unscaledDelta = CS.UnityEngine.Time.unscaledDeltaTime
end

return timer