--[[ 
    CMD UI Library 
    Style: Windows Command Prompt (101% Accurate)
    Author: m0dzn (Generated via Assistance)
]]

local Library = {}
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- Constants
local FONT = Enum.Font.Code -- Closest to Consolas/Lucida Console
local TEXT_SIZE = 16
local BG_COLOR = Color3.fromRGB(12, 12, 12) -- standard cmd black
local TEXT_COLOR = Color3.fromRGB(204, 204, 204) -- standard cmd grey/white
local RAINBOW_SPEED = 5

-- UI State
local ScreenGui
local MainFrame
local ConsoleLog
local InputBox
local TitleBarText

-- Helper: Create UI Instance
local function create(className, properties, children)
    local obj = Instance.new(className)
    for k, v in pairs(properties) do obj[k] = v end
    if children then
        for _, child in pairs(children) do child.Parent = obj end
    end
    return obj
end

-- Helper: Get Rainbow Color
local function getRainbowGradient()
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 127, 0)),
        ColorSequenceKeypoint.new(0.4, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(139, 0, 255))
    })
    return gradient
end

function Library:Init()
    -- Protect GUI (If using Synapse/Krnl/etc use proper protection, otherwise Parent to PlayerGui)
    local parent = CoreGui:FindFirstChild("RobloxGui") or LocalPlayer:WaitForChild("PlayerGui")
    
    -- cleanup old
    if parent:FindFirstChild("CMD_UI_m0dzn") then parent["CMD_UI_m0dzn"]:Destroy() end

    ScreenGui = create("ScreenGui", {Name = "CMD_UI_m0dzn", Parent = parent, ResetOnSpawn = false, IgnoreGuiInset = true})
    
    MainFrame = create("Frame", {
        Name = "Window",
        Parent = ScreenGui,
        BackgroundColor3 = BG_COLOR,
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, -300, 0.5, -200),
        Size = UDim2.new(0, 600, 0, 400),
        Active = true,
        Draggable = true
    })

    -- Title Bar (Visual only to look like window)
    local TitleBar = create("Frame", {
        Parent = MainFrame,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        Size = UDim2.new(1, 0, 0, 25),
        BorderSizePixel = 0
    })
    
    TitleBarText = create("TextLabel", {
        Parent = TitleBar,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0, 0),
        Size = UDim2.new(1, -20, 1, 0),
        Font = FONT,
        Text = "Administrator: CMD",
        TextColor3 = Color3.new(0,0,0),
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    -- Console Area
    ConsoleLog = create("ScrollingFrame", {
        Parent = MainFrame,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 5, 0, 30),
        Size = UDim2.new(1, -10, 1, -35),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ScrollBarThickness = 6,
        ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
    })
    
    create("UIListLayout", {
        Parent = ConsoleLog,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 2)
    })

    -- Input Box (Hidden, captures focus)
    InputBox = create("TextBox", {
        Parent = MainFrame,
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 0, 0, 0), -- Hidden
        Text = "",
        Font = FONT,
        TextSize = TEXT_SIZE
    })
end

function Library:Print(text, color, isRainbow)
    local label = create("TextLabel", {
        Parent = ConsoleLog,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, TEXT_SIZE),
        Font = FONT,
        Text = text,
        TextColor3 = color or TEXT_COLOR,
        TextSize = TEXT_SIZE,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true,
        RichText = true
    })
    
    if isRainbow then
        local grad = getRainbowGradient()
        grad.Parent = label
    end

    -- Auto scroll
    ConsoleLog.CanvasSize = UDim2.new(0, 0, 0, ConsoleLog.UIListLayout.AbsoluteContentSize.Y)
    ConsoleLog.CanvasPosition = Vector2.new(0, ConsoleLog.UIListLayout.AbsoluteContentSize.Y)
    return label
end

function Library:Clear()
    for _, v in pairs(ConsoleLog:GetChildren()) do
        if v:IsA("TextLabel") then v:Destroy() end
    end
    ConsoleLog.CanvasSize = UDim2.new(0,0,0,0)
end

function Library:SetTitle(titleName)
    TitleBarText.Text = "Administrator: " .. titleName
    Library:Print(titleName, TEXT_COLOR)
    Library:Print("------------------------", TEXT_COLOR)
end

-- The "Yielding" Input Function
function Library:Input(promptText)
    -- Display prompt
    local promptLine = Library:Print(promptText, TEXT_COLOR)
    
    InputBox.Text = ""
    InputBox:CaptureFocus()
    
    local finished = false
    local result = ""
    
    -- Visual Cursor logic
    local connection
    connection = InputBox:GetPropertyChangedSignal("Text"):Connect(function()
        promptLine.Text = promptText .. InputBox.Text .. "_"
    end)
    
    local enterConnection
    enterConnection = InputBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            finished = true
            result = InputBox.Text
            promptLine.Text = promptText .. result -- Remove cursor
        else
            -- If they clicked away, force focus back until they hit enter? 
            -- For UX, we usually let them click away, but for accuracy we keep focus.
            InputBox:CaptureFocus() 
        end
    end)
    
    repeat task.wait() until finished
    
    connection:Disconnect()
    enterConnection:Disconnect()
    
    return result
end

function Library:SelectByNumber(prompt, options)
    Library:Print(prompt)
    for i, v in pairs(options) do
        Library:Print("["..i.."] " .. v)
    end
    
    while true do
        local res = Library:Input("Type number to select: ")
        local num = tonumber(res)
        if num and options[num] then
            return num, options[num]
        else
            Library:Print("Invalid selection.", Color3.fromRGB(255, 50, 50))
        end
    end
end

function Library:Confirm(prompt)
    while true do
        local res = Library:Input(prompt .. " (Y/N): ")
        if res:lower() == "y" or res:lower() == "yes" then
            return true
        elseif res:lower() == "n" or res:lower() == "no" then
            return false
        else
            Library:Print("Please type Y or N.", Color3.fromRGB(255, 50, 50))
        end
    end
end

function Library:BootSequence()
    Library:Init()
    
    -- 1. Rainbow ASCII
    local ascii = [[
  ____ __  __ ____     _   _ ___ 
 / ___|  \/  |  _ \   | | | |_ _|
| |   | |\/| | | | |  | | | || | 
| |___| |  | | |_| |  | |_| || | 
 \____|_|  |_|____/    \___/|___|
                                 
      made by m0dzn
]]
    local logo = Library:Print(ascii, Color3.new(1,1,1), true)
    logo.Size = UDim2.new(1, 0, 0, 130) -- Adjust for ASCII height
    
    -- 2. Loading Bar
    local loadTime = math.random(1000, 2000) / 1000 -- 1.0 to 2.0 seconds
    local startTime = tick()
    local loadingLine = Library:Print("UI Loading [                  ] 0%")
    
    while (tick() - startTime) < loadTime do
        local elapsed = tick() - startTime
        local progress = math.clamp(elapsed / loadTime, 0, 1)
        local percent = math.floor(progress * 100)
        
        local hashes = math.floor(progress * 20) -- 20 chars bar
        local barStr = string.rep("#", hashes) .. string.rep(" ", 20 - hashes)
        
        loadingLine.Text = string.format("UI Loading [%s] %d%%", barStr, percent)
        task.wait()
    end
    
    loadingLine.Text = string.format("UI Loading [%s] 100%%", string.rep("#", 20))
    Library:Print("Load UI in " .. string.format("%.3f", loadTime) .. " sec")
    
    -- 3. Transition
    task.wait(3)
    Library:Clear()
end

return Library
