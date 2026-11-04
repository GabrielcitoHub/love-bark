---@meta

---@class CSUnityEngineInput
local Input = {}

-- =========================================================
-- Mouse
-- =========================================================

---@param button integer
---@return boolean
function Input.GetMouseButton(button) end

---@param button integer
---@return boolean
function Input.GetMouseButtonDown(button) end

---@param button integer
---@return boolean
function Input.GetMouseButtonUp(button) end

---@return CSUnityEngineVector3
function Input.GetMousePosition() end

---@type CSUnityEngineVector3
Input.mousePosition = nil

---@type CSUnityEngineVector2
Input.mouseScrollDelta = nil

-- =========================================================
-- Keyboard
-- =========================================================

---@param key integer
---@return boolean
function Input.GetKey(key) end

---@param key integer
---@return boolean
function Input.GetKeyDown(key) end

---@param key integer
---@return boolean
function Input.GetKeyUp(key) end

---@type string
Input.inputString = ""

-- =========================================================
-- Axes
-- =========================================================

---@param axisName string
---@return number
function Input.GetAxis(axisName) end

---@param axisName string
---@return number
function Input.GetAxisRaw(axisName) end

---@param buttonName string
---@return boolean
function Input.GetButton(buttonName) end

---@param buttonName string
---@return boolean
function Input.GetButtonDown(buttonName) end

---@param buttonName string
---@return boolean
function Input.GetButtonUp(buttonName) end