local typeof = require("puerts").typeof

---@class LoveGraphics : LoveModule
local graphics = {
    width = 0,
    height = 0,

    color = {1, 1, 1, 1},

    canvas = nil,
    square = nil,
    squareRect = nil,

    images = {},
    drawIndex = 1,

    texts = {},
    textIndex = 1,
    fontSize = 16,
}

local function createImage()
    local gameObject = CS.UnityEngine.GameObject(
        "LoveGraphicsRectangle",
        typeof(CS.UnityEngine.RectTransform),
        typeof(CS.UnityEngine.CanvasRenderer),
        typeof(CS.UnityEngine.UI.Image)
    )

    gameObject.transform:SetParent(graphics.canvasObject.transform, false)

    local rect = gameObject:GetComponent(typeof(CS.UnityEngine.RectTransform))
    local image = gameObject:GetComponent(typeof(CS.UnityEngine.UI.Image))

    rect.anchorMin = CS.UnityEngine.Vector2(0.5, 0.5)
    rect.anchorMax = CS.UnityEngine.Vector2(0.5, 0.5)
    rect.pivot = CS.UnityEngine.Vector2(0.5, 0.5)

    image.enabled = false

    return {
        object = gameObject,
        rect = rect,
        image = image
    }
end

local function createText()
    local gameObject = CS.UnityEngine.GameObject(
        "LoveGraphicsText",
        typeof(CS.UnityEngine.RectTransform),
        typeof(CS.UnityEngine.CanvasRenderer),
        typeof(CS.UnityEngine.UI.Text)
    )

    gameObject.transform:SetParent(graphics.canvasObject.transform, false)

    local rect = gameObject:GetComponent(typeof(CS.UnityEngine.RectTransform))
    local text = gameObject:GetComponent(typeof(CS.UnityEngine.UI.Text))

    rect.sizeDelta = CS.UnityEngine.Vector2(
        graphics.width,
        64
    )
    rect.anchorMin = CS.UnityEngine.Vector2(0.5, 0.5)
    rect.anchorMax = CS.UnityEngine.Vector2(0.5, 0.5)
    rect.pivot = CS.UnityEngine.Vector2(0, 1)

    text.text = ""
    text.font = CS.UnityEngine.Resources.GetBuiltinResource(
        typeof(CS.UnityEngine.Font),
        "Arial.ttf"
    )

    text.fontSize = 16
    text.color = CS.UnityEngine.Color(1, 1, 1, 1)
    text.alignment = CS.UnityEngine.TextAnchor.UpperLeft
    text.raycastTarget = false
    text.enabled = false

    return {
        object = gameObject,
        rect = rect,
        text = text
    }
end

function graphics.load()
    graphics.width = CS.UnityEngine.Screen.width
    graphics.height = CS.UnityEngine.Screen.height

    -- Create an overlay canvas
    local canvasObject = CS.UnityEngine.GameObject("LoveGraphicsCanvas")
    local canvas = canvasObject:AddComponent(typeof(CS.UnityEngine.Canvas))
    graphics.canvasObject = canvasObject

    canvas.renderMode = CS.UnityEngine.RenderMode.ScreenSpaceOverlay
    canvas.overrideSorting = true
    canvas.sortingOrder = 32767

    graphics.canvas = canvas

    -- Create a UI image
    local squareObject = CS.UnityEngine.GameObject(
        "LoveGraphicsSquare",
        typeof(CS.UnityEngine.RectTransform),
        typeof(CS.UnityEngine.CanvasRenderer),
        typeof(CS.UnityEngine.UI.Image)
    )

    squareObject.transform:SetParent(canvasObject.transform, false)

    graphics.square = squareObject:GetComponent(typeof(CS.UnityEngine.UI.Image))
    graphics.squareRect = squareObject:GetComponent(typeof(CS.UnityEngine.RectTransform))

    graphics.square.color = CS.UnityEngine.Color.white
    graphics.square.enabled = false

    graphics.images[1] = {
        object = graphics.square.gameObject,
        rect = graphics.squareRect,
        image = graphics.square
    }
end

function graphics.getPixelDimensions()
    return graphics.width, graphics.height
end

function graphics.getPixelWidth()
    local width = graphics.getPixelDimensions()
    return width
end

function graphics.getPixelHeight()
    local _, height = graphics.getPixelDimensions()
    return height
end

---@param r number
---@param g number
---@param b number
---@param a? number
function graphics.setColor(r, g, b, a)
    graphics.color = {r, g, b, a or 1}
end

---@param mode '"fill"'|'"line"'
---@param x number
---@param y number
---@param width number
---@param height number
function graphics.rectangle(mode, x, y, width, height)
    if mode ~= "fill" then return end

    local index = graphics.drawIndex
    local entry = graphics.images[index]

    -- Grow the pool only when necessary
    if not entry then
        entry = createImage()
        graphics.images[index] = entry
    end

    graphics.drawIndex = index + 1

    local rect = entry.rect
    local image = entry.image

    rect.sizeDelta = CS.UnityEngine.Vector2(width, height)

    rect.anchoredPosition = CS.UnityEngine.Vector2(
        x + width / 2 - graphics.width / 2,
        graphics.height / 2 - y - height / 2
    )

    local color = graphics.color
    image.color = CS.UnityEngine.Color(table.unpack(color))

    image.enabled = true
end

---@param text string
---@param x number?
---@param y number?
function graphics.print(text, x, y)
    x = x or 0
    y = y or 0

    local index = graphics.textIndex
    local entry = graphics.texts[index]

    if not entry then
        entry = createText()
        graphics.texts[index] = entry
    end

    graphics.textIndex = index + 1

    entry.text.text = tostring(text)
    entry.text.fontSize = graphics.fontSize
    entry.text.horizontalOverflow = CS.UnityEngine.HorizontalWrapMode.Overflow
    entry.text.verticalOverflow = CS.UnityEngine.VerticalWrapMode.Overflow

    local color = graphics.color
    entry.text.color = CS.UnityEngine.Color(
        color[1],
        color[2],
        color[3],
        color[4]
    )

    entry.rect.anchoredPosition = CS.UnityEngine.Vector2(
        x - graphics.width / 2,
        graphics.height / 2 - y
    )

    entry.text.enabled = true
end

---@param text string
---@param x number
---@param y number
---@param limit number
---@param align? string
function graphics.printf(text, x, y, limit, align)
    local index = graphics.textIndex
    local entry = graphics.texts[index]

    if not entry then
        entry = createText()
        graphics.texts[index] = entry
    end

    graphics.textIndex = index + 1

    entry.text.text = tostring(text)
    entry.text.fontSize = graphics.fontSize

    local color = graphics.color
    entry.text.color = CS.UnityEngine.Color(
        color[1],
        color[2],
        color[3],
        color[4]
    )

    entry.text.horizontalOverflow = CS.UnityEngine.HorizontalWrapMode.Wrap
    entry.text.verticalOverflow = CS.UnityEngine.VerticalWrapMode.Overflow

    entry.text.alignment = align == "center"
        and CS.UnityEngine.TextAnchor.UpperCenter
        or align == "right"
        and CS.UnityEngine.TextAnchor.UpperRight
        or CS.UnityEngine.TextAnchor.UpperLeft

    entry.rect.sizeDelta = CS.UnityEngine.Vector2(limit, graphics.height)

    entry.rect.anchoredPosition = CS.UnityEngine.Vector2(
        x - graphics.width / 2,
        graphics.height / 2 - y
    )

    entry.text.enabled = true
end

---@param r? number
---@param g? number
---@param b? number
---@param a? number
function graphics.clear(r, g, b, a)
    local color = graphics.color

    if r then
        color[1] = r
    end

    if g then
        color[2] = g
    end

    if b then
        color[3] = b
    end

    if a then
        color[4] = a
    end

    graphics.square.enabled = false
    graphics.drawIndex = 1

    graphics.textIndex = 1

    if r or g or b or a then
        local width, height = graphics.getPixelDimensions()
        graphics.rectangle("fill", 0, 0, width, height)
    end
end
function graphics.preUpdate()
end

function graphics.update()
    -- Disable images that weren't used this frame
    for i = graphics.drawIndex, #graphics.images do
        graphics.images[i].image.enabled = false
    end

    for i = graphics.textIndex, #graphics.texts do
        graphics.texts[i].text.enabled = false
    end
end

function graphics.__release()
    for i = 1, #graphics.images do
        local entry = graphics.images[i]

        if entry and entry.object then
            CS.UnityEngine.Object.Destroy(entry.object)
        end
    end

    if graphics.canvasObject then
        CS.UnityEngine.Object.Destroy(graphics.canvasObject)
    end

    graphics.images = {}
    graphics.drawIndex = 1

    graphics.texts = {}
    graphics.textIndex = 1

    graphics.square = nil
    graphics.squareRect = nil
    graphics.canvasObject = nil
    graphics.canvas = nil
end

return graphics