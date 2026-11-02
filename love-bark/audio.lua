---@class LoveAudio : LoveModule
local audio = {
    manager = CS.Bark.Audio.AudioManager
}

function audio.getAudioManager()
    return audio.manager
end

---@enum LoveSourceType
local loveSourceType = {
    stream = "stream",
    static = "static"
}

---@param filename string
---@param type LoveSourceType
function audio.newSource(filename, type)
    local audioManager = audio.getAudioManager()
    audioManager:LoadModAudio("", filename)
end

return audio