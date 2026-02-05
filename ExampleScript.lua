--[[ 
    CMD UI - Example Usage Script
    Loads the library from your GitHub URL
]]

-- 1. Load the Library
local CMDUI = loadstring(game:HttpGet("https://github.com/m0dzn1/Roblox-CMD-UI-library/raw/refs/heads/main/CMDUILibrary.lua"))()

if not CMDUI then
    warn("Failed to load CMD UI Library. Check the URL.")
    return
end

-- 2. Run the Boot Sequence 
-- (Rainbow text, Loading bar 1-2s, Clear screen)
CMDUI:BootSequence()

-- 3. Set your Script Title
-- This appears in the top header and changes the window title
local ScriptTitle = "M0DZN HUB v1"
CMDUI:SetTitle(ScriptTitle)

-- 4. Example: Selection Menu (SelectByNumber)
CMDUI:Print("Welcome user. Initializing resources...")
task.wait(0.5)

local choiceIdx, choiceName = CMDUI:SelectByNumber("Select Exploit Mode:", {
    [1] = "Legit Farm",
    [2] = "Rage Farm",
    [3] = "Teleport",
    [4] = "ESP Only"
})

CMDUI:Print(">> Mode Selected: " .. choiceName, Color3.fromRGB(0, 255, 0))
task.wait(1)

-- 5. Example: Confirmation (Confirm)
local useSafeMode = CMDUI:Confirm("Enable Safe Mode (Anti-Ban)?")

if useSafeMode then
    CMDUI:Print(">> Safe Mode: ACTIVE", Color3.fromRGB(0, 255, 0))
else
    CMDUI:Print(">> Safe Mode: OFF (Risky)", Color3.fromRGB(255, 50, 50))
end

-- 6. Example: Value Input (Input)
local walkspeed = CMDUI:Input("Set WalkSpeed Value (Default 16):")

if tonumber(walkspeed) then
    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = tonumber(walkspeed)
        CMDUI:Print(">> WalkSpeed updated to " .. walkspeed, Color3.fromRGB(0, 255, 0))
    else
        CMDUI:Print(">> Character not found.", Color3.fromRGB(255, 0, 0))
    end
else
    CMDUI:Print(">> Invalid Number.", Color3.fromRGB(255, 0, 0))
end

CMDUI:Print("------------------------")
CMDUI:Print("System Ready.")
