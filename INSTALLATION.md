# Quick Installation Guide

## Step 1: Add the Library

1. Open Roblox Studio
2. In **Explorer**, find **ReplicatedStorage**
3. Right-click **ReplicatedStorage** → Insert Object → **ModuleScript**
4. Rename it to `CMDUILibrary`
5. Delete all code inside it
6. Copy the entire content from `CMDUILibrary.lua` file
7. Paste it into the ModuleScript

## Step 2: Create Your Script

1. In **Explorer**, navigate to **StarterPlayer** → **StarterPlayerScripts**
2. Right-click **StarterPlayerScripts** → Insert Object → **LocalScript**
3. Name it whatever you want (e.g., `MyScript`)
4. Delete all code inside it
5. Copy the example code from `ExampleScript.lua` OR write your own:

```lua
local CMDUILibrary = require(game.ReplicatedStorage:WaitForChild("CMDUILibrary"))

local cmdUI = CMDUILibrary.new("My App")
cmdUI:WaitForReady()

cmdUI:Print("Hello World!")
```

## Step 3: Test It!

1. Click the **Play** button in Roblox Studio
2. Wait for the rainbow ASCII art and loading bar
3. Your CMD UI should appear!

## File Structure

Your workspace should look like this:

```
Workspace
├── ReplicatedStorage
│   └── CMDUILibrary (ModuleScript) ← Paste CMDUILibrary.lua here
└── StarterPlayer
    └── StarterPlayerScripts
        └── MyScript (LocalScript) ← Your script here
```

## Troubleshooting

**Problem: UI doesn't show**
- Solution: Make sure both files are in the correct locations
- Check that the ModuleScript is named exactly `CMDUILibrary`

**Problem: Script error**
- Solution: Make sure you copied the ENTIRE code from CMDUILibrary.lua
- Check for any missing characters

**Problem: Can't type in input box**
- Solution: Click inside the input box first
- Make sure to press Enter after typing

## Need Help?

Check the full README.md for detailed documentation and more examples!
