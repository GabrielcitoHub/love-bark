# Love Bark (or simply love-barking)

Love bark is a Bark wrapper that takes some of their function and adapts each to the usual Love2d functions, using unity counterparts when Bark doesn't have it.

# How to use

In your bark mod, when requiring love-bark do it like this:

```lua
local data = require("ScriptMod.Mods.YourModFolderName.WhateverPathYouPutLoveBarkAt")
```

then, you can decide which components to use:

```lua
---@type Love
local love = data.love
```

(Optional)

```lua
---@type LoveLog
local log = data.log
```

(Or also simply)

```lua
---@type Love, LoveLog
local love, log = data.love, data.log
```

that's it! now you can use love callback, events, function, etc.

# Features

- When using require() the mod's folder is used in the check, so something like require("lib.timer") will point to "ScriptMod/Mods/<my-mod>/lib/timer.lua" automatically.

# Implemented

- None yet, most are work in progress. (Check the module field and callback for available functions)

# Work in progress

- Most Love2d Modules.