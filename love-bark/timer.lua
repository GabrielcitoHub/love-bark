---@class LoveTimer
local timer = {
    delta = 1.0,
    unscaledDelta = 1.0,
    unscaledTime = 0.0
}

function timer.getDelta()
    return timer.delta
end

function timer.getUnscaledDelta()
    return timer.unscaledDelta
end

function timer.getUnscaledTime()
    return timer.unscaledTime
end

function timer.update()
    timer.delta = CS.UnityEngine.Time.deltaTime
    timer.unscaledDelta = CS.UnityEngine.Time.unscaledDeltaTime
    timer.unscaledTime = CS.UnityEngine.Time.unscaledTime
end

return timer