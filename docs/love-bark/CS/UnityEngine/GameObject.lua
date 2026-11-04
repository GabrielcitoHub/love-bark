---@meta

---@class CSUnityEngineGameObject : CSUnityEngineObject
---@field transform CSUnityEngineTransform
---@field activeSelf boolean
---@field activeInHierarchy boolean
---@field isStatic boolean
---@field layer integer
---@field tag string
local GameObject = {}

---@param name string
---@param ... any
---@return CSUnityEngineGameObject
function GameObject(name, ...) end

---@param active boolean
function GameObject:SetActive(active) end

---@param componentType any
---@return any
function GameObject:GetComponent(componentType) end

---@param componentType any
---@return any
function GameObject:AddComponent(componentType) end

---@param componentType any
---@return boolean
function GameObject:TryGetComponent(componentType) end

---@param name string
---@return CSUnityEngineGameObject
function GameObject.Find(name) end