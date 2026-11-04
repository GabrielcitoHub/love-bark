---@meta

---@class CSUnityEngineMathf
local Mathf = {}

---@param value number
---@return number
function Mathf.Abs(value) end

---@param value number
---@param min number
---@param max number
---@return number
function Mathf.Clamp(value, min, max) end

---@param value number
---@param min number
---@param max number
---@return number
function Mathf.Clamp01(value) end

---@param a number
---@param b number
---@param t number
---@return number
function Mathf.Lerp(a, b, t) end

---@param a number
---@param b number
---@return number
function Mathf.Max(a, b) end

---@param a number
---@param b number
---@return number
function Mathf.Min(a, b) end

---@param value number
---@return number
function Mathf.Round(value) end

---@param value number
---@return number
function Mathf.Floor(value) end

---@param value number
---@return number
function Mathf.Ceil(value) end

---@param value number
---@return number
function Mathf.Sin(value) end

---@param value number
---@return number
function Mathf.Cos(value) end

---@param value number
---@return number
function Mathf.Sqrt(value) end

---@type number
Mathf.PI = 3.141592653589793