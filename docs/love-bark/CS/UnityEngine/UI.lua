---@meta

---@class CSUnityEngineUI
local UI = {}

-- Image
---@class CSUnityEngineUIImage : CSUnityEngineBehaviour
---@field sprite CSUnityEngineSprite
---@field color CSUnityEngineColor
---@field enabled boolean
---@field raycastTarget boolean
---@field preserveAspect boolean
---@field type number
---@field fillAmount number
---@field material CSUnityEngineMaterial
---@field rectTransform CSUnityEngineRectTransform

---@param gameObject CSUnityEngineGameObject
function UI.Image(gameObject) end

-- Text
---@class CSUnityEngineUIText : CSUnityEngineBehaviour
---@field text string
---@field font CSUnityEngineFont
---@field fontSize integer
---@field color CSUnityEngineColor
---@field alignment number
---@field horizontalOverflow number
---@field verticalOverflow number
---@field raycastTarget boolean
---@field supportRichText boolean
---@field lineSpacing number
---@field resizeTextForBestFit boolean
---@field rectTransform CSUnityEngineRectTransform

---@param gameObject CSUnityEngineGameObject
function UI.Text(gameObject) end