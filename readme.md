# Love Bark (or simply Love Barking)

Love bark is a Bark wrapper that takes some of their functions and adapts each to the usual Love2d functions, using unity counterparts when Bark doesn't have it.

# How to use

In your bark mod, when requiring love-bark do it like this:

```lua
local data = require("ScriptMod.Mods.YourModFolderName.WhateverPathYouPutLoveBarkAt.love-bark")
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

# Documentation

If you'd like to have documentation copy paste this into your .vscode/settings.json file:

```json
{
	"Lua.runtime.version": "LuaJIT",
	"Lua.diagnostics.disable": [
		"duplicate-set-field",
		"need-check-nil",
	],
	"Lua.type.weakNilCheck": true,
	"Lua.type.weakUnionCheck": true,
	"Lua.runtime.builtin": {
		"utf8": "enable"
	},
	"Lua.workspace.library": [
		"${workspaceFolder}/love-bark",
	]
}
```

note that "love-bark" here must point to your actual path to the module
like for example in "lib" it would be " "${workspaceFolder}/lib/love-bark", "

using the above as exmaple path if you cloned the repo, the path should instead point to " "${workspaceFolder}/lib/love-bark/love-bark", ".

If you already have a ".vscode/settings.json" file, you can also append this to your library field:

```
"${workspaceFolder}/love-bark",
```

like so:

```json
"Lua.workspace.library": [
    "<your-libraries>",
	"${workspaceFolder}/love-bark",
]
```

# Features

- When using require() the mod's folder is used in the check automatically, so something like require("lib.timer") will point to "ScriptMod/Mods/my-mod/lib/timer.lua".

# Implemented

- None yet, most are work in progress. (Check love-bark for available functions)

# Work in progress

- Most Love2d Modules.