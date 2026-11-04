---@meta

---@class CSUnityEngineObject
---@field name string
---@field hideFlags number
---@field GetInstanceID fun(self: CSUnityEngineObject): number
---@field ToString fun(self: CSUnityEngineObject): string
local Object = {}

---@param obj CSUnityEngineObject
function Object.Destroy(obj) end

---@param obj CSUnityEngineObject
---@param t number
function Object.Destroy(obj, t) end

---@param obj CSUnityEngineObject
function Object.DontDestroyOnLoad(obj) end

---@generic T
---@param original T
---@return T
function Object.Instantiate(original) end

---@generic T
---@param original T
---@param parent CSUnityEngineTransform
---@return T
function Object.Instantiate(original, parent) end