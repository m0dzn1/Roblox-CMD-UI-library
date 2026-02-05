# Frequently Asked Questions (FAQ)

## General Questions

### What is CMD UI Library?
CMD UI Library is a Roblox ModuleScript that creates a 100% accurate Windows Command Prompt interface for your games. It includes rainbow ASCII art, loading animations, and interactive input methods.

### Who made this?
Created by **m0dzn** for the Roblox community.

### Is it free to use?
Yes! CMD UI Library is completely free and open-source under the MIT License.

### Can I use this in my game?
Absolutely! You can use it in any Roblox game, modify it, and even use it in commercial projects.

---

## Installation & Setup

### Where do I put the files?
- **CMDUILibrary.lua** → ReplicatedStorage as a ModuleScript
- **Your script** → StarterPlayerScripts as a LocalScript

### Can I rename the ModuleScript?
Yes, but you'll need to update the `require()` path in your scripts:
```lua
local CMDUILibrary = require(game.ReplicatedStorage.YourCustomName)
```

### Does this work on mobile?
Yes! The UI is compatible with PC, mobile, and tablet devices. However, typing on mobile uses the device keyboard.

### Can I use this on the server side?
No, this is a client-side UI library and must run in a LocalScript. It cannot be used in ServerScripts.

---

## Usage Questions

### How do I change the window title?
```lua
cmdUI:SetTitle("New Title")
```

### How do I customize text colors?
```lua
-- Red text
cmdUI:Print("Error!", Color3.fromRGB(255, 0, 0))

-- Yellow text
cmdUI:Print("Warning!", Color3.fromRGB(255, 255, 0))

-- Cyan text
cmdUI:Print("Info", Color3.fromRGB(0, 255, 255))
```

### How do I make the window bigger?
Edit the `WINDOW_SIZE` constant in the ModuleScript:
```lua
local WINDOW_SIZE = UDim2.new(0, 1000, 0, 800) -- Width: 1000, Height: 800
```

### Can I create multiple windows?
Yes! Just create multiple instances:
```lua
local window1 = CMDUILibrary.new("Window 1")
local window2 = CMDUILibrary.new("Window 2")
```

### How do I close the UI?
```lua
cmdUI:Destroy()
```

### Can I disable the boot sequence?
Not directly, but you can modify the `BootSequence()` function in the ModuleScript to skip or shorten it.

---

## Input Questions

### How do I validate number inputs?
```lua
local age = cmdUI:Input("Enter your age:", "number")
-- Returns a number or prompts again if invalid
```

### Can I set a default value for inputs?
Not currently, but you can check the returned value:
```lua
local input = cmdUI:Input("Enter name (or press Enter for default):", "string")
if input == "" then
    input = "Default Name"
end
```

### How do I create a multi-line input?
Currently not supported. The library is designed for single-line inputs to match CMD behavior.

### Can users cancel an input?
Not currently. Once prompted, users must provide input. You can add a "Cancel" option using SelectByNumber before asking for input.

---

## Troubleshooting

### The UI doesn't appear
**Solutions:**
1. Check that the ModuleScript is in ReplicatedStorage
2. Make sure your LocalScript is in StarterPlayerScripts
3. Verify the require() path is correct
4. Check the output console for errors

### Input box doesn't work
**Solutions:**
1. Click inside the input box to focus it
2. Make sure to press Enter after typing
3. Wait for the boot sequence to complete using `WaitForReady()`

### Rainbow text doesn't show colors
**Solutions:**
1. Make sure the UIGradient is not being removed
2. Check if any other scripts are interfering
3. Verify the text label has the gradient as a child

### Text is cut off or overlapping
**Solutions:**
1. Increase the window size
2. Use shorter text or line breaks
3. Check the TextWrapped property if you modified the code

### Loading animation freezes
**Solutions:**
1. Don't run intensive code during boot sequence
2. Make sure you're not blocking the main thread
3. Check for infinite loops in your script

---

## Customization

### Can I change the font?
Yes, edit the `FONT` constant:
```lua
local FONT = Enum.Font.SourceSans -- or any Roblox font
```

### Can I change the background color?
Yes, edit the `BACKGROUND_COLOR` constant:
```lua
local BACKGROUND_COLOR = Color3.new(0.1, 0.1, 0.1) -- Dark gray instead of black
```

### Can I change the title bar color?
Yes, find this line in `CreateUI()`:
```lua
self.TitleBar.BackgroundColor3 = Color3.fromRGB(0, 0, 128)
```

### Can I add custom ASCII art?
Yes! Edit the `ASCII_ART` constant or create your own:
```lua
local myArt = [[
  _____ _    _ _____ _____ _____ _____ 
 / ____| |  | / ____|_   _|  __ \_   _|
| |    | |  | | (___   | | | |  | || |  
| |    | |  | |\___ \  | | | |  | || |  
| |____| |__| |____) |_| |_| |__| || |_ 
 \_____|\____/|_____/|_____|_____/_____|
]]
```

### Can I disable the rainbow effect?
Yes, remove or comment out the UIGradient creation in the `CreateRainbowText()` function.

---

## Advanced Questions

### Can I integrate this with my existing UI?
Yes, but you may need to adjust positioning and z-index to avoid conflicts.

### How do I save user inputs to a DataStore?
```lua
local input = cmdUI:Input("Enter username:", "string")
-- Use normal DataStore code here
dataStore:SetAsync(player.UserId, input)
```

### Can I use this with RemoteEvents?
Yes! Collect input client-side, then fire to server:
```lua
local choice = cmdUI:SelectByNumber("Choose action:", options)
remoteEvent:FireServer(choice)
```

### How do I make it work with teams?
```lua
local team = cmdUI:SelectByNumber("Choose team:", {"Red", "Blue"})
player.Team = game.Teams[team == 1 and "Red" or "Blue"]
```

### Can I add custom widgets?
Yes, you can extend the library by adding new methods to the CMDUILibrary table.

---

## Performance

### Is it laggy?
No, the library is lightweight and optimized. The rainbow animation is the most intensive part but runs smoothly.

### How many windows can I create?
You can create multiple windows, but each uses memory and UI elements. Recommended: 1-3 windows max.

### Does it affect FPS?
Minimal impact. The UI is static except for the rainbow animation.

---

## Compatibility

### What Roblox features does it use?
- ScreenGui
- Frames
- TextLabels
- TextBoxes
- UIGradient
- UIListLayout
- UserInputService

### Does it work with Filtering Enabled?
Yes, it's fully compatible with FE since it's client-side only.

### Can I use it with Roact or other frameworks?
Not directly, but you can create wrappers or adapt the code.

---

## Common Use Cases

### How do I create an admin panel?
See `AdvancedExamples.lua` - Admin Panel example

### How do I create a shop?
See `AdvancedExamples.lua` - Shop System example

### How do I create a quiz?
See `AdvancedExamples.lua` - Quiz Game example

### How do I create a settings menu?
See `AdvancedExamples.lua` - Settings Menu example

---

## Contributing

### Can I contribute to the project?
Yes! Check CONTRIBUTING.md for guidelines.

### I found a bug, where do I report it?
Open an issue on GitHub with details about the bug.

### I have a feature request
Open an issue on GitHub labeled as "enhancement"

---

## License & Credits

### What license is this under?
MIT License - free to use, modify, and distribute.

### Do I need to credit m0dzn?
Not required, but appreciated!

### Can I sell games using this?
Yes, the MIT license allows commercial use.

---

**Still have questions? Open an issue on GitHub!**
