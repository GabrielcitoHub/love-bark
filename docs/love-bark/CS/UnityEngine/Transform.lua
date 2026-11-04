---@meta

---@class CSUnityEngineTransform : CSUnityEngineObject
---@field position CSUnityEngineVector3
---@field localPosition CSUnityEngineVector3
---@field rotation CSUnityEngineQuaternion
---@field localRotation CSUnityEngineQuaternion
---@field eulerAngles CSUnityEngineVector3
---@field localEulerAngles CSUnityEngineVector3
---@field localScale CSUnityEngineVector3
---@field lossyScale CSUnityEngineVector3
---@field parent CSUnityEngineTransform
---@field root CSUnityEngineTransform
---@field childCount integer
---@field forward CSUnityEngineVector3
---@field right CSUnityEngineVector3
---@field up CSUnityEngineVector3
---@field gameObject CSUnityEngineGameObject
local Transform = {}

---@param parent CSUnityEngineTransform
---@param worldPositionStays boolean|nil
function Transform:SetParent(parent, worldPositionStays) end

---@param index integer
---@return CSUnityEngineTransform
function Transform:GetChild(index) end

function Transform:DetachChildren() end