---@meta

---@class CSUnityEngine
local UnityEngine = {}

---@type CSUnityEngineObject
UnityEngine.Object = nil

-- =========================================================
-- Vector2
-- =========================================================

---@param x number
---@param y number
---@return CSUnityEngineVector2
function UnityEngine.Vector2(x, y)
    return {
        x = x,
        y = y,
    }
end

-- =========================================================
-- Vector3
-- =========================================================

---@param x number
---@param y number
---@param z number
---@return CSUnityEngineVector3
function UnityEngine.Vector3(x, y, z)
    return {
        x = x,
        y = y,
        z = z,
    }
end

-- =========================================================
-- Quaternion
-- =========================================================

---@param x number
---@param y number
---@param z number
---@param w number
---@return CSUnityEngineQuaternion
function UnityEngine.Quaternion(x, y, z, w)
    return {
        x = x,
        y = y,
        z = z,
        w = w,
    }
end

-- =========================================================
-- Color
-- =========================================================

---@param r number
---@param g number
---@param b number
---@param a? number
---@return CSUnityEngineColor
function UnityEngine.Color(r, g, b, a) end

---@type CSUnityEngineTransform
UnityEngine.Transform = nil

---@type CSUnityEngineGameObject
UnityEngine.GameObject = nil

---@type CSUnityEngineComponent
UnityEngine.Component = nil

-- =========================================================
-- Behaviour / MonoBehaviour
-- =========================================================

---@class CSUnityEngineBehaviour : CSUnityEngineComponent
---@field enabled boolean
---@field isActiveAndEnabled boolean

---@class CSUnityEngineMonoBehaviour : CSUnityEngineBehaviour

-- =========================================================
-- Resources
-- =========================================================

---@type CSUnityEngineResources
UnityEngine.Resources = nil

---@type CSUnityEngineScreen
UnityEngine.Screen = nil

---@type CSUnityEngineCursor
UnityEngine.Cursor = nil

---@type CSUnityEngineCursorLockMode
UnityEngine.CursorLockMode = nil

---@type CSUnityEngineInput
UnityEngine.Input = nil

---@type CSUnityEngineKeyCode
UnityEngine.KeyCode = nil

---@type CSUnityEngineTime
UnityEngine.Time = nil

---@type CSUnityEngineMathf
UnityEngine.Mathf = nil

---@type CSUnityEngineDebug
UnityEngine.Debug = nil

---@type CSUnityEngineUI
UnityEngine.UI = nil

---@type CSUnityEngineTextAnchor
UnityEngine.TextAnchor = nil

---@type CSUnityEngineHorizontalWrapMode
UnityEngine.HorizontalWrapMode = nil

---@type CSUnityEngineVerticalWrapMode
UnityEngine.VerticalWrapMode = nil

---@type CSUnityEngineRenderMode
UnityEngine.RenderMode = nil