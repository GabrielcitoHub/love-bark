---@meta

---@class CSUnityEngineComponent : CSUnityEngineObject
---@field gameObject CSUnityEngineGameObject
---@field transform CSUnityEngineTransform
---@field tag string
local Component = {}

---@param componentType any
---@return any
function Component:GetComponent(componentType) end

---@param componentType any
---@return any
function Component:GetComponentInParent(componentType) end

---@param componentType any
---@return any
function Component:GetComponentInChildren(componentType) end