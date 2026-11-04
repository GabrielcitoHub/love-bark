---@class LoveBody : LoveModule
local body = {}

function onBodyCardiacArrest(event)
    local isCardiacArrest = event.IsCardiacArrest

    if isCardiacArrest then
        body.love.call(body.love.cardiacarrest)
    else
        body.love.call(body.love.cardiacarrestrecover)
    end
end

function onBodyFibrillationStart()
    body.love.call(body.love.fibrillation)
end

function onBodyFibrillationEnd()
    body.love.call(body.love.fibrillationrecover)
end

function onBodyBreathChange(event)
    local isBreathing = event.IsBreathing

    if isBreathing then
        body.love.call(body.love.breathrecover)
    else
        body.love.call(body.love.breathstop)
    end
end

function onBodyConsciousnessChange(event)
    local isConscious = event.IsConscious

    if isConscious then
        body.love.call(body.love.conscious)
    else
        body.love.call(body.love.unconscious)
    end
end

function onBodyBrainDying(event)
    local isBrainDying = event.IsBrainDying

    if isBrainDying then
        body.love.call(body.love.braindying)
    else
        body.love.call(body.love.braindyingrecover)
    end
end

function onBodyClimbStart()
    body.love.call(body.love.climb)
end

function onBodyClimbEnd()
    body.love.call(body.love.climbend)
end

function onBodyExerciseStart()
    body.love.call(body.love.exercise)
end

function onBodyExerciseEnd()
    body.love.call(body.love.exerciseend)
end

function onBodySwitchHands()
    body.love.call(body.love.switchhands)
end

function onBodySwitchDir(event)
    local isRight = event.IsRight
    body.love.call(body.love.turnaround, isRight)
end

function onBodyCrouchChange(event)
    local isCrouching = event.IsCrouching

    if isCrouching then
        body.love.call(body.love.crouch)
    else
        body.love.call(body.love.uncrouch)
    end
end

function onBodyPickUp(event)
    local itemId, slot = event.ItemId, event.Slot
    body.love.call(body.love.pickup, itemId, slot)
end

function onBodyDrop(event)
    local itemId = event.ItemId
    body.love.call(body.love.drop, itemId)
end

function onBodySleepChange(event)
    local isSleeping = event.IsSleeping
    if isSleeping then
        body.love.call(body.love.fellasleep)
    else
        body.love.call(body.love.wokeup)
    end
end

function onBodyLastStand()
    body.love.call(body.love.laststand)
end

function onBodyDisfigure()
    body.love.call(body.love.disfigure)
end

function onBodyRemoveEye(event)
    local bothEyesGone = event.BothEyesGone
    body.love.call(body.love.losteye, bothEyesGone)
end

return body