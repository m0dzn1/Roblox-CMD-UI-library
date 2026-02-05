-- CMD UI Library - Loadstring Version
-- Usage: local CMDUI = loadstring(game:HttpGet("YOUR_URL_HERE"))()
-- Made by m0dzn

local CMDUILibrary = {}
CMDUILibrary.__index = CMDUILibrary

-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Constants
local BACKGROUND_COLOR = Color3.new(0, 0, 0)
local TEXT_COLOR = Color3.fromRGB(0, 204, 0)
local FONT = Enum.Font.Code
local TITLE_BAR_HEIGHT = 30
local WINDOW_SIZE = UDim2.new(0, 800, 0, 600)

-- ASCII Art
local ASCII_ART = [[
  ██████╗███╗   ███╗██████╗     ██╗   ██╗██╗
 ██╔════╝████╗ ████║██╔══██╗    ██║   ██║██║
 ██║     ██╔████╔██║██║  ██║    ██║   ██║██║
 ██║     ██║╚██╔╝██║██║  ██║    ██║   ██║██║
 ╚██████╗██║ ╚═╝ ██║██████╔╝    ╚██████╔╝██║
  ╚═════╝╚═╝     ╚═╝╚═════╝      ╚═════╝ ╚═╝
                                            
           made by m0dzn
]]

function CMDUILibrary.new(title)
    local self = setmetatable({}, CMDUILibrary)
    self.Title = title or "CMD"
    self.IsReady = false
    self.CurrentInput = nil
    self.InputConnection = nil
    self:CreateUI()
    task.spawn(function() self:BootSequence() end)
    return self
end

function CMDUILibrary:CreateUI()
    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
    
    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Name = "CMDUI"
    self.ScreenGui.ResetOnSpawn = false
    self.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    self.ScreenGui.Parent = playerGui
    
    self.MainFrame = Instance.new("Frame")
    self.MainFrame.Name = "Window"
    self.MainFrame.Size = WINDOW_SIZE
    self.MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    self.MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    self.MainFrame.BackgroundColor3 = BACKGROUND_COLOR
    self.MainFrame.BorderSizePixel = 2
    self.MainFrame.BorderColor3 = Color3.fromRGB(128, 128, 128)
    self.MainFrame.Parent = self.ScreenGui
    
    self.TitleBar = Instance.new("Frame")
    self.TitleBar.Name = "TitleBar"
    self.TitleBar.Size = UDim2.new(1, 0, 0, TITLE_BAR_HEIGHT)
    self.TitleBar.BackgroundColor3 = Color3.fromRGB(0, 0, 128)
    self.TitleBar.BorderSizePixel = 0
    self.TitleBar.Parent = self.MainFrame
    
    self.TitleLabel = Instance.new("TextLabel")
    self.TitleLabel.Name = "Title"
    self.TitleLabel.Size = UDim2.new(1, -10, 1, 0)
    self.TitleLabel.Position = UDim2.new(0, 5, 0, 0)
    self.TitleLabel.BackgroundTransparency = 1
    self.TitleLabel.Text = self.Title
    self.TitleLabel.TextColor3 = Color3.new(1, 1, 1)
    self.TitleLabel.Font = FONT
    self.TitleLabel.TextSize = 14
    self.TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    self.TitleLabel.Parent = self.TitleBar
    
    self.ContentFrame = Instance.new("ScrollingFrame")
    self.ContentFrame.Name = "Content"
    self.ContentFrame.Size = UDim2.new(1, -10, 1, -TITLE_BAR_HEIGHT - 10)
    self.ContentFrame.Position = UDim2.new(0, 5, 0, TITLE_BAR_HEIGHT + 5)
    self.ContentFrame.BackgroundColor3 = BACKGROUND_COLOR
    self.ContentFrame.BorderSizePixel = 0
    self.ContentFrame.ScrollBarThickness = 10
    self.ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    self.ContentFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    self.ContentFrame.Parent = self.MainFrame
    
    self.ContentLayout = Instance.new("UIListLayout")
    self.ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    self.ContentLayout.Padding = UDim.new(0, 0)
    self.ContentLayout.Parent = self.ContentFrame
    
    self:MakeDraggable()
end

function CMDUILibrary:MakeDraggable()
    local dragging = false
    local dragInput, mousePos, framePos
    
    self.TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = input.Position
            framePos = self.MainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    self.TitleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            self.MainFrame.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
        end
    end)
end

function CMDUILibrary:BootSequence()
    local startTime = tick()
    local loadTime = math.random(1000, 2000) / 1000
    local asciiLabel = self:CreateRainbowText(ASCII_ART, 12)
    local loadingLabel = self:CreateText("UI Loading [                    ] 0%", TEXT_COLOR)
    local steps = 20
    local stepTime = loadTime / steps
    
    for i = 1, steps do
        local progress = i / steps
        local filled = math.floor(progress * 20)
        local bar = string.rep("#", filled) .. string.rep(" ", 20 - filled)
        local percentage = math.floor(progress * 100)
        loadingLabel.Text = string.format("UI Loading [%s] %d%%", bar, percentage)
        task.wait(stepTime)
    end
    
    local actualTime = tick() - startTime
    local completionLabel = self:CreateText(string.format("Load UI in %.3f sec", actualTime), TEXT_COLOR)
    task.wait(0.5)
    self:Clear()
    self:ShowMainInterface()
    self.IsReady = true
end

function CMDUILibrary:CreateRainbowText(text, textSize)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Font = FONT
    label.TextSize = textSize or 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextYAlignment = Enum.TextYAlignment.Top
    label.AutomaticSize = Enum.AutomaticSize.Y
    label.Parent = self.ContentFrame
    
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 127, 0)),
        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(0.83, Color3.fromRGB(75, 0, 130)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(148, 0, 211))
    }
    gradient.Parent = label
    
    task.spawn(function()
        while label.Parent do
            for i = 0, 1, 0.01 do
                gradient.Offset = Vector2.new(i, 0)
                task.wait(0.03)
            end
        end
    end)
    
    return label
end

function CMDUILibrary:CreateText(text, color)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = color or TEXT_COLOR
    label.Font = FONT
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextYAlignment = Enum.TextYAlignment.Top
    label.AutomaticSize = Enum.AutomaticSize.Y
    label.Parent = self.ContentFrame
    return label
end

function CMDUILibrary:ShowMainInterface()
    self:CreateText("\n" .. string.rep(" ", 10) .. self.Title, TEXT_COLOR)
    self:CreateText(string.rep("-", 50), TEXT_COLOR)
    self:CreateText("", TEXT_COLOR)
end

function CMDUILibrary:Clear()
    for _, child in ipairs(self.ContentFrame:GetChildren()) do
        if child:IsA("TextLabel") or child:IsA("TextBox") then
            child:Destroy()
        end
    end
end

function CMDUILibrary:SetTitle(newTitle)
    self.Title = newTitle
    self.TitleLabel.Text = newTitle
    self:Clear()
    self:ShowMainInterface()
end

function CMDUILibrary:Print(text, color)
    self:CreateText(text, color or TEXT_COLOR)
    self.ContentFrame.CanvasPosition = Vector2.new(0, self.ContentFrame.AbsoluteCanvasSize.Y)
end

function CMDUILibrary:WaitForInput(prompt)
    self:Print(prompt)
    local inputBox = Instance.new("TextBox")
    inputBox.Size = UDim2.new(1, -5, 0, 20)
    inputBox.BackgroundColor3 = BACKGROUND_COLOR
    inputBox.BorderSizePixel = 0
    inputBox.Text = ""
    inputBox.TextColor3 = TEXT_COLOR
    inputBox.Font = FONT
    inputBox.TextSize = 14
    inputBox.TextXAlignment = Enum.TextXAlignment.Left
    inputBox.ClearTextOnFocus = false
    inputBox.Parent = self.ContentFrame
    task.wait(0.1)
    inputBox:CaptureFocus()
    
    local result = nil
    local connection
    connection = inputBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            result = inputBox.Text
            inputBox:Destroy()
            connection:Disconnect()
        else
            inputBox:CaptureFocus()
        end
    end)
    
    while result == nil do task.wait(0.1) end
    self:Print("> " .. result, Color3.fromRGB(0, 255, 0))
    return result
end

function CMDUILibrary:SelectByNumber(prompt, options)
    if type(options) ~= "table" or #options == 0 then
        error("Options must be a non-empty table")
    end
    
    self:Print("")
    self:Print(prompt)
    for i, option in ipairs(options) do
        self:Print(string.format("  [%d] %s", i, option))
    end
    self:Print("")
    
    local input = nil
    while input == nil do
        local rawInput = self:WaitForInput("Type number to select: ")
        local num = tonumber(rawInput)
        if num and num >= 1 and num <= #options then
            input = num
        else
            self:Print("Invalid selection. Please try again.", Color3.fromRGB(255, 0, 0))
        end
    end
    
    return input, options[input]
end

function CMDUILibrary:Confirm(prompt)
    self:Print("")
    self:Print(prompt)
    local result = nil
    while result == nil do
        local input = self:WaitForInput("Type Y/N: ")
        local lower = string.lower(input)
        if lower == "y" or lower == "yes" then
            result = true
        elseif lower == "n" or lower == "no" then
            result = false
        else
            self:Print("Invalid input. Please type Y or N.", Color3.fromRGB(255, 0, 0))
        end
    end
    return result
end

function CMDUILibrary:Input(prompt, inputType)
    self:Print("")
    self:Print(prompt)
    local result = nil
    while result == nil do
        local input = self:WaitForInput((inputType == "number" and "Type number to set value: ") or "Type value: ")
        if inputType == "number" then
            local num = tonumber(input)
            if num then
                result = num
            else
                self:Print("Invalid number. Please try again.", Color3.fromRGB(255, 0, 0))
            end
        else
            result = input
        end
    end
    return result
end

function CMDUILibrary:WaitForReady()
    while not self.IsReady do task.wait(0.1) end
end

function CMDUILibrary:Destroy()
    if self.InputConnection then self.InputConnection:Disconnect() end
    if self.ScreenGui then self.ScreenGui:Destroy() end
end

return CMDUILibrary
