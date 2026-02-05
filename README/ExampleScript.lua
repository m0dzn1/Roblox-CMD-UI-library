--[[
    CMD UI Library - Example Usage
    
    This script demonstrates how to use the CMD UI Library
    Place this in StarterPlayer > StarterPlayerScripts or StarterGui
]]

-- Require the library (adjust the path to where you put the ModuleScript)
local CMDUILibrary = require(game.ReplicatedStorage:WaitForChild("CMDUILibrary"))

-- Create new CMD UI instance
local cmdUI = CMDUILibrary.new("My Application")

-- Wait for the boot sequence to complete
cmdUI:WaitForReady()

-- Now you can use all the functions!

-- Example 1: Print some text
cmdUI:Print("Welcome to CMD UI Library!")
cmdUI:Print("This is a demonstration of all features.")
task.wait(1)

-- Example 2: Change the title
cmdUI:SetTitle("DEMO PROGRAM")
task.wait(0.5)

-- Example 3: Use SelectByNumber
local choice, selectedOption = cmdUI:SelectByNumber(
    "What would you like to do?",
    {
        "View System Info",
        "Run Calculation",
        "Change Settings",
        "Exit Program"
    }
)

cmdUI:Print("")
cmdUI:Print("You selected: " .. selectedOption)
task.wait(1)

-- Example 4: Use Confirm (Y/N)
if choice == 2 then
    cmdUI:Print("")
    cmdUI:Print("Let's do some math!")
    
    local num1 = cmdUI:Input("Enter first number:", "number")
    local num2 = cmdUI:Input("Enter second number:", "number")
    
    local operations = cmdUI:SelectByNumber(
        "Select operation:",
        {
            "Addition (+)",
            "Subtraction (-)",
            "Multiplication (*)",
            "Division (/)"
        }
    )
    
    local result
    if operations == 1 then
        result = num1 + num2
    elseif operations == 2 then
        result = num1 - num2
    elseif operations == 3 then
        result = num1 * num2
    elseif operations == 4 then
        result = num1 / num2
    end
    
    cmdUI:Print("")
    cmdUI:Print(string.format("Result: %.2f", result), Color3.fromRGB(0, 255, 255))
end

-- Example 5: General text input
task.wait(1)
cmdUI:Print("")
local userName = cmdUI:Input("What is your name?", "string")
cmdUI:Print("")
cmdUI:Print("Hello, " .. userName .. "! Nice to meet you!")

-- Example 6: Final confirmation
task.wait(1)
local shouldExit = cmdUI:Confirm("Do you want to exit the program?")

if shouldExit then
    cmdUI:Print("")
    cmdUI:Print("Goodbye! Thanks for using CMD UI Library.", Color3.fromRGB(255, 255, 0))
    task.wait(2)
    cmdUI:Destroy()
else
    cmdUI:Print("")
    cmdUI:Print("Program will continue running...")
    cmdUI:Print("You can close the window manually.")
end

--[[
    AVAILABLE METHODS:
    
    cmdUI:SetTitle(string)
    - Updates the window title and header
    
    cmdUI:Print(text, color?)
    - Prints text to the console
    - Color is optional (defaults to CMD green)
    
    cmdUI:SelectByNumber(prompt, options)
    - Shows numbered list and waits for selection
    - Returns: selectedIndex, selectedValue
    
    cmdUI:Confirm(prompt)
    - Shows Y/N prompt
    - Returns: boolean (true for Yes, false for No)
    
    cmdUI:Input(prompt, inputType?)
    - General input field
    - inputType can be "number" or "string" (default: "string")
    - Returns: the input value
    
    cmdUI:Clear()
    - Clears all content from the console
    
    cmdUI:WaitForReady()
    - Waits until the boot sequence is complete
    
    cmdUI:Destroy()
    - Closes and removes the UI
]]
