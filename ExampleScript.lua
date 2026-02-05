--[[
    CMD UI Library - Loadstring Usage Examples
    
    This shows different ways to load and use the CMD UI Library with loadstring
]]

local CMDUI = loadstring(game:HttpGet("YOUR_URL_HERE"))()

-- Create UI
local cmdUI = CMDUI.new("Example App")
cmdUI:WaitForReady()

-- Use it like normal
cmdUI:Print("Welcome!")
cmdUI:Print("")

local choice = cmdUI:SelectByNumber(
    "What would you like to do?",
    {
        "Option 1",
        "Option 2",
        "Option 3"
    }
)

cmdUI:Print("You selected option " .. choice)

local confirm = cmdUI:Confirm("Continue?")

if confirm then
    local name = cmdUI:Input("What's your name?", "string")
    cmdUI:Print("Hello, " .. name .. "!")
else
    cmdUI:Print("Goodbye!")
end

task.wait(2)
cmdUI:Destroy()


-- ============================================================================
-- ERROR HANDLING (Recommended)
-- ============================================================================

local success, CMDUI = pcall(function()
    return loadstring(game:HttpGet("YOUR_URL_HERE"))()
end)

if success then
    local cmdUI = CMDUI.new("My App")
    cmdUI:WaitForReady()
    cmdUI:Print("Loaded successfully!")
else
    warn("Failed to load CMD UI Library:", CMDUI)
end


-- ============================================================================
-- LOADING WITH CUSTOM SETTINGS
-- ============================================================================

local CMDUI = loadstring(game:HttpGet("YOUR_URL_HERE"))()

-- You can create multiple instances
local mainMenu = CMDUI.new("Main Menu")
local settings = CMDUI.new("Settings")
local shop = CMDUI.new("Shop")

-- Wait for all to be ready
mainMenu:WaitForReady()
settings:WaitForReady()
shop:WaitForReady()


-- ============================================================================
-- NOTES & TIPS
-- ============================================================================

--[[
    IMPORTANT:
    - Make sure HTTP requests are enabled in your game
    - Go to Game Settings > Security > Allow HTTP Requests = ON
    - The URL must be a direct link to the raw code
    - Don't use shortened URLs (bit.ly, etc.) - Roblox blocks them
    
    RECOMMENDED HOSTING:
    1. GitHub (Free, reliable, easy)
    2. Pastebin (Free, but pastes may expire)
    3. paste.ee (Free alternative)
    4. Your own server (Most control)
    
    GITHUB RAW URL FORMAT:
    https://raw.githubusercontent.com/USERNAME/REPOSITORY/BRANCH/FILE.lua
    
    Example:
    https://raw.githubusercontent.com/m0dzn/cmdui/main/CMDUILibrary_Loadstring.lua
]]
