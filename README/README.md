# CMD UI Library for Roblox

A 100% accurate Windows Command Prompt (CMD) style UI library for Roblox, featuring rainbow ASCII art, dynamic loading animations, and interactive user input methods.

![CMD UI Preview](https://via.placeholder.com/800x600/000000/00CC00?text=CMD+UI+Library)

## Features

✨ **Visual Features**
- 100% accurate CMD window design with classic blue title bar
- Rainbow gradient ASCII art boot screen
- Dynamic loading animation (1.000-2.000 seconds randomized)
- Draggable window interface
- Auto-scrolling console output
- CMD green text on pure black background

🎮 **Functional Features**
- **Print** - Output text to console
- **SelectByNumber** - Numbered menu selection
- **Confirm** - Yes/No prompts
- **Input** - General text/number input
- **SetTitle** - Change window title dynamically
- **Clear** - Clear console content

## Installation

### Method 1: Quick Setup (Recommended)

1. Create a **ModuleScript** in `ReplicatedStorage`
2. Name it `CMDUILibrary`
3. Copy the contents of `CMDUILibrary.lua` into it
4. Create a **LocalScript** in `StarterPlayer > StarterPlayerScripts`
5. Copy the example code from `ExampleScript.lua`
6. Run the game!

### Method 2: Manual Setup

```plaintext
game
├── ReplicatedStorage
│   └── CMDUILibrary (ModuleScript)
└── StarterPlayer
    └── StarterPlayerScripts
        └── YourScript (LocalScript)
```

## Quick Start

```lua
-- Require the library
local CMDUILibrary = require(game.ReplicatedStorage:WaitForChild("CMDUILibrary"))

-- Create new instance
local cmdUI = CMDUILibrary.new("My App")

-- Wait for boot sequence
cmdUI:WaitForReady()

-- Use the UI!
cmdUI:Print("Hello, World!")

local choice = cmdUI:SelectByNumber("Choose an option:", {
    "Option 1",
    "Option 2",
    "Option 3"
})

local confirm = cmdUI:Confirm("Are you sure?")

local userInput = cmdUI:Input("Enter your name:", "string")
```

## API Documentation

### Constructor

#### `CMDUILibrary.new(title)`
Creates a new CMD UI instance.

**Parameters:**
- `title` (string, optional) - Initial window title. Default: "CMD"

**Returns:** CMD UI instance

**Example:**
```lua
local cmdUI = CMDUILibrary.new("My Application")
```

---

### Methods

#### `cmdUI:WaitForReady()`
Waits until the boot sequence completes before continuing execution.

**Example:**
```lua
cmdUI:WaitForReady()
cmdUI:Print("UI is ready!")
```

---

#### `cmdUI:SetTitle(newTitle)`
Updates the window title and console header.

**Parameters:**
- `newTitle` (string) - New title text

**Example:**
```lua
cmdUI:SetTitle("Settings Menu")
```

---

#### `cmdUI:Print(text, color?)`
Prints text to the console.

**Parameters:**
- `text` (string) - Text to display
- `color` (Color3, optional) - Text color. Default: CMD green

**Example:**
```lua
cmdUI:Print("Normal text")
cmdUI:Print("Error!", Color3.fromRGB(255, 0, 0))
cmdUI:Print("Success!", Color3.fromRGB(0, 255, 255))
```

---

#### `cmdUI:SelectByNumber(prompt, options)`
Displays a numbered list and waits for user selection.

**Parameters:**
- `prompt` (string) - Question or instruction
- `options` (table) - Array of option strings

**Returns:**
- `selectedIndex` (number) - Index of selected option (1-based)
- `selectedValue` (string) - The selected option text

**Example:**
```lua
local index, value = cmdUI:SelectByNumber(
    "Choose a difficulty:",
    {"Easy", "Medium", "Hard"}
)

cmdUI:Print("You chose: " .. value)
```

---

#### `cmdUI:Confirm(prompt)`
Shows a Yes/No confirmation prompt.

**Parameters:**
- `prompt` (string) - Question to ask

**Returns:** boolean (`true` for Yes, `false` for No)

**Example:**
```lua
local shouldContinue = cmdUI:Confirm("Do you want to continue?")

if shouldContinue then
    cmdUI:Print("Continuing...")
else
    cmdUI:Print("Cancelled.")
end
```

---

#### `cmdUI:Input(prompt, inputType?)`
General input field for text or numbers.

**Parameters:**
- `prompt` (string) - Question or instruction
- `inputType` (string, optional) - "number" or "string". Default: "string"

**Returns:** User's input (string or number)

**Example:**
```lua
local name = cmdUI:Input("Enter your name:", "string")
local age = cmdUI:Input("Enter your age:", "number")

cmdUI:Print(string.format("Hello %s, you are %d years old!", name, age))
```

---

#### `cmdUI:Clear()`
Clears all content from the console.

**Example:**
```lua
cmdUI:Clear()
cmdUI:ShowMainInterface() -- Redraw header
```

---

#### `cmdUI:Destroy()`
Closes and removes the UI completely.

**Example:**
```lua
cmdUI:Print("Shutting down...")
task.wait(1)
cmdUI:Destroy()
```

---

## Examples

### Simple Menu System

```lua
local CMDUILibrary = require(game.ReplicatedStorage.CMDUILibrary)
local cmdUI = CMDUILibrary.new("Main Menu")

cmdUI:WaitForReady()

while true do
    local choice = cmdUI:SelectByNumber(
        "Main Menu - Choose an option:",
        {
            "Start Game",
            "Settings",
            "Credits",
            "Exit"
        }
    )
    
    if choice == 1 then
        cmdUI:Print("Starting game...")
        break
    elseif choice == 2 then
        cmdUI:SetTitle("Settings")
        -- Settings menu here
    elseif choice == 3 then
        cmdUI:Print("Made by m0dzn")
        task.wait(2)
    elseif choice == 4 then
        cmdUI:Destroy()
        break
    end
end
```

### Calculator Example

```lua
local CMDUILibrary = require(game.ReplicatedStorage.CMDUILibrary)
local cmdUI = CMDUILibrary.new("Calculator")

cmdUI:WaitForReady()

cmdUI:Print("Welcome to CMD Calculator!")
cmdUI:Print("")

local num1 = cmdUI:Input("Enter first number:", "number")
local num2 = cmdUI:Input("Enter second number:", "number")

local op = cmdUI:SelectByNumber(
    "Choose operation:",
    {"+", "-", "*", "/"}
)

local result
if op == 1 then result = num1 + num2
elseif op == 2 then result = num1 - num2
elseif op == 3 then result = num1 * num2
elseif op == 4 then result = num1 / num2
end

cmdUI:Print("")
cmdUI:Print(string.format("Result: %.2f", result), Color3.fromRGB(0, 255, 255))
```

### User Registration

```lua
local CMDUILibrary = require(game.ReplicatedStorage.CMDUILibrary)
local cmdUI = CMDUILibrary.new("User Registration")

cmdUI:WaitForReady()

cmdUI:Print("=== New User Registration ===")
cmdUI:Print("")

local username = cmdUI:Input("Enter username:", "string")
local age = cmdUI:Input("Enter your age:", "number")
local agreed = cmdUI:Confirm("Do you agree to the terms of service?")

if agreed then
    cmdUI:Print("")
    cmdUI:Print("Account created successfully!", Color3.fromRGB(0, 255, 0))
    cmdUI:Print("Username: " .. username)
    cmdUI:Print("Age: " .. age)
else
    cmdUI:Print("")
    cmdUI:Print("Registration cancelled.", Color3.fromRGB(255, 255, 0))
end
```

## Customization

### Changing Colors

You can customize text colors when printing:

```lua
-- Red text
cmdUI:Print("Error message", Color3.fromRGB(255, 0, 0))

-- Yellow text
cmdUI:Print("Warning", Color3.fromRGB(255, 255, 0))

-- Cyan text
cmdUI:Print("Info", Color3.fromRGB(0, 255, 255))

-- Default CMD green
cmdUI:Print("Normal text")
```

### Window Size

To change the window size, edit the `WINDOW_SIZE` constant in the ModuleScript:

```lua
local WINDOW_SIZE = UDim2.new(0, 1000, 0, 700) -- Larger window
```

## Technical Specifications

- **Font**: `Enum.Font.Code` (closest to Lucida Console)
- **Background**: Pure black `Color3.new(0, 0, 0)`
- **Text Color**: CMD green `Color3.fromRGB(0, 204, 0)`
- **Title Bar**: Classic CMD blue `Color3.fromRGB(0, 0, 128)`
- **Boot Time**: Randomized 1.000-2.000 seconds
- **Rainbow ASCII**: 7-color gradient with animation

## Features Breakdown

### Boot Sequence
1. Rainbow ASCII art displays "CMD UI made by m0dzn"
2. Progress bar animates from 0% to 100%
3. Loading time is randomized (1.000-2.000 sec)
4. Shows exact load time in format "Load UI in X.XXX sec"
5. Screen clears and main interface appears

### Input Handling
- All inputs require pressing Enter to submit
- Input validation (e.g., number checking)
- Error messages for invalid input
- Visual feedback for user actions

### Window Features
- Draggable title bar
- Auto-scrolling content
- Classic CMD styling
- Responsive layout

## Troubleshooting

**UI doesn't appear:**
- Make sure the ModuleScript is in ReplicatedStorage
- Check that the LocalScript is in StarterPlayerScripts
- Verify the script is not disabled

**Input not working:**
- Click inside the input box
- Press Enter after typing
- Make sure UI is ready (use WaitForReady())

**Text is cut off:**
- Increase window size in WINDOW_SIZE constant
- Check ScrollingFrame CanvasSize

## License

This library is free to use and modify. Credit to m0dzn is appreciated but not required.

## Credits

**Made by m0dzn**

- Rainbow ASCII art system
- Dynamic loading animation
- Interactive input methods
- 100% CMD-accurate styling

## Support

For issues, suggestions, or contributions, please open an issue on GitHub.

---

**Enjoy your CMD UI Library! 💚**
