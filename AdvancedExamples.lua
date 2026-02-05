--[[
    CMD UI Library - Advanced Examples
    
    Collection of practical examples showing different use cases
]]

local CMDUILibrary = require(game.ReplicatedStorage:WaitForChild("CMDUILibrary"))

-- ============================================================================
-- EXAMPLE 1: Simple Admin Panel
-- ============================================================================

local function AdminPanel()
    local cmdUI = CMDUILibrary.new("Admin Panel")
    cmdUI:WaitForReady()
    
    cmdUI:Print("=== ADMIN PANEL v1.0 ===")
    cmdUI:Print("Logged in as: Administrator")
    cmdUI:Print("")
    
    while true do
        local action = cmdUI:SelectByNumber(
            "Select admin action:",
            {
                "Kick Player",
                "Ban Player",
                "Teleport Player",
                "Give Item",
                "Server Announcement",
                "Exit"
            }
        )
        
        if action == 1 then
            local playerName = cmdUI:Input("Enter player name to kick:", "string")
            local confirm = cmdUI:Confirm("Are you sure you want to kick " .. playerName .. "?")
            if confirm then
                cmdUI:Print("Player " .. playerName .. " has been kicked.", Color3.fromRGB(255, 100, 100))
            end
            
        elseif action == 5 then
            local message = cmdUI:Input("Enter announcement message:", "string")
            cmdUI:Print("Broadcasting: " .. message, Color3.fromRGB(255, 255, 0))
            
        elseif action == 6 then
            cmdUI:Destroy()
            break
        end
    end
end

-- ============================================================================
-- EXAMPLE 2: Shop System
-- ============================================================================

local function ShopSystem()
    local cmdUI = CMDUILibrary.new("Item Shop")
    cmdUI:WaitForReady()
    
    local balance = 1000
    local inventory = {}
    
    cmdUI:Print("Welcome to the Item Shop!")
    cmdUI:Print(string.format("Your balance: $%d", balance))
    cmdUI:Print("")
    
    local items = {
        {name = "Sword", price = 100},
        {name = "Shield", price = 150},
        {name = "Potion", price = 50},
        {name = "Armor", price = 300}
    }
    
    while true do
        local options = {}
        for i, item in ipairs(items) do
            table.insert(options, string.format("%s - $%d", item.name, item.price))
        end
        table.insert(options, "View Inventory")
        table.insert(options, "Exit Shop")
        
        local choice = cmdUI:SelectByNumber("What would you like to buy?", options)
        
        if choice <= #items then
            local item = items[choice]
            if balance >= item.price then
                local confirm = cmdUI:Confirm(string.format("Buy %s for $%d?", item.name, item.price))
                if confirm then
                    balance = balance - item.price
                    table.insert(inventory, item.name)
                    cmdUI:Print(string.format("Purchased %s! New balance: $%d", item.name, balance), Color3.fromRGB(0, 255, 0))
                end
            else
                cmdUI:Print("Not enough money!", Color3.fromRGB(255, 0, 0))
            end
            
        elseif choice == #items + 1 then
            cmdUI:Print("")
            cmdUI:Print("=== YOUR INVENTORY ===")
            if #inventory == 0 then
                cmdUI:Print("Empty")
            else
                for i, itemName in ipairs(inventory) do
                    cmdUI:Print(string.format("  %d. %s", i, itemName))
                end
            end
            cmdUI:Print("")
            
        else
            cmdUI:Destroy()
            break
        end
    end
end

-- ============================================================================
-- EXAMPLE 3: Quiz Game
-- ============================================================================

local function QuizGame()
    local cmdUI = CMDUILibrary.new("Quiz Game")
    cmdUI:WaitForReady()
    
    cmdUI:Print("=== TRIVIA QUIZ ===")
    cmdUI:Print("Answer 5 questions correctly to win!")
    cmdUI:Print("")
    
    local questions = {
        {
            question = "What is 2 + 2?",
            options = {"3", "4", "5", "6"},
            correct = 2
        },
        {
            question = "What is the capital of France?",
            options = {"London", "Berlin", "Paris", "Madrid"},
            correct = 3
        },
        {
            question = "How many days are in a week?",
            options = {"5", "6", "7", "8"},
            correct = 3
        },
        {
            question = "What color is the sky?",
            options = {"Green", "Blue", "Red", "Yellow"},
            correct = 2
        },
        {
            question = "How many legs does a spider have?",
            options = {"6", "8", "10", "12"},
            correct = 2
        }
    }
    
    local score = 0
    
    for i, q in ipairs(questions) do
        cmdUI:Print(string.format("Question %d:", i))
        local answer = cmdUI:SelectByNumber(q.question, q.options)
        
        if answer == q.correct then
            score = score + 1
            cmdUI:Print("Correct! ✓", Color3.fromRGB(0, 255, 0))
        else
            cmdUI:Print("Wrong! ✗", Color3.fromRGB(255, 0, 0))
        end
        cmdUI:Print("")
        task.wait(0.5)
    end
    
    cmdUI:Print("=== FINAL SCORE ===")
    cmdUI:Print(string.format("You got %d out of %d correct!", score, #questions), Color3.fromRGB(0, 255, 255))
    
    if score == #questions then
        cmdUI:Print("Perfect score! You're a genius! 🏆", Color3.fromRGB(255, 255, 0))
    elseif score >= 3 then
        cmdUI:Print("Good job! 👍")
    else
        cmdUI:Print("Better luck next time! 📚")
    end
    
    task.wait(3)
    cmdUI:Destroy()
end

-- ============================================================================
-- EXAMPLE 4: Character Creator
-- ============================================================================

local function CharacterCreator()
    local cmdUI = CMDUILibrary.new("Character Creator")
    cmdUI:WaitForReady()
    
    cmdUI:Print("=== CREATE YOUR CHARACTER ===")
    cmdUI:Print("")
    
    local character = {}
    
    character.name = cmdUI:Input("Enter character name:", "string")
    
    local classChoice = cmdUI:SelectByNumber(
        "Choose your class:",
        {"Warrior", "Mage", "Rogue", "Archer"}
    )
    character.class = ({"Warrior", "Mage", "Rogue", "Archer"})[classChoice]
    
    cmdUI:Print("")
    cmdUI:Print("You have 10 points to distribute among your stats:")
    local points = 10
    
    character.strength = cmdUI:Input(string.format("Strength (Points left: %d):", points), "number")
    points = points - character.strength
    
    character.intelligence = cmdUI:Input(string.format("Intelligence (Points left: %d):", points), "number")
    points = points - character.intelligence
    
    character.agility = cmdUI:Input(string.format("Agility (Points left: %d):", points), "number")
    points = points - character.agility
    
    cmdUI:Print("")
    cmdUI:Print("=== CHARACTER SUMMARY ===", Color3.fromRGB(255, 255, 0))
    cmdUI:Print("Name: " .. character.name)
    cmdUI:Print("Class: " .. character.class)
    cmdUI:Print(string.format("Strength: %d", character.strength))
    cmdUI:Print(string.format("Intelligence: %d", character.intelligence))
    cmdUI:Print(string.format("Agility: %d", character.agility))
    cmdUI:Print("")
    
    local confirm = cmdUI:Confirm("Create this character?")
    
    if confirm then
        cmdUI:Print("Character created successfully! 🎮", Color3.fromRGB(0, 255, 0))
    else
        cmdUI:Print("Character creation cancelled.", Color3.fromRGB(255, 100, 100))
    end
    
    task.wait(2)
    cmdUI:Destroy()
end

-- ============================================================================
-- EXAMPLE 5: Settings Menu
-- ============================================================================

local function SettingsMenu()
    local cmdUI = CMDUILibrary.new("Settings")
    cmdUI:WaitForReady()
    
    local settings = {
        volume = 50,
        graphics = "Medium",
        controlScheme = "Keyboard"
    }
    
    while true do
        cmdUI:Clear()
        cmdUI:ShowMainInterface()
        
        cmdUI:Print("Current Settings:")
        cmdUI:Print(string.format("  Volume: %d%%", settings.volume))
        cmdUI:Print(string.format("  Graphics: %s", settings.graphics))
        cmdUI:Print(string.format("  Controls: %s", settings.controlScheme))
        cmdUI:Print("")
        
        local choice = cmdUI:SelectByNumber(
            "What would you like to change?",
            {
                "Volume",
                "Graphics Quality",
                "Control Scheme",
                "Reset to Default",
                "Save & Exit"
            }
        )
        
        if choice == 1 then
            settings.volume = cmdUI:Input("Enter volume (0-100):", "number")
            settings.volume = math.clamp(settings.volume, 0, 100)
            
        elseif choice == 2 then
            local gfx = cmdUI:SelectByNumber(
                "Select graphics quality:",
                {"Low", "Medium", "High", "Ultra"}
            )
            settings.graphics = ({"Low", "Medium", "High", "Ultra"})[gfx]
            
        elseif choice == 3 then
            local ctrl = cmdUI:SelectByNumber(
                "Select control scheme:",
                {"Keyboard", "Controller", "Touch"}
            )
            settings.controlScheme = ({"Keyboard", "Controller", "Touch"})[ctrl]
            
        elseif choice == 4 then
            local confirm = cmdUI:Confirm("Reset all settings to default?")
            if confirm then
                settings = {volume = 50, graphics = "Medium", controlScheme = "Keyboard"}
                cmdUI:Print("Settings reset!", Color3.fromRGB(255, 255, 0))
                task.wait(1)
            end
            
        else
            cmdUI:Print("Settings saved!", Color3.fromRGB(0, 255, 0))
            task.wait(1)
            cmdUI:Destroy()
            break
        end
    end
end

-- ============================================================================
-- EXAMPLE 6: File Manager Simulator
-- ============================================================================

local function FileManager()
    local cmdUI = CMDUILibrary.new("File Manager")
    cmdUI:WaitForReady()
    
    local files = {
        "document1.txt",
        "image.png",
        "video.mp4",
        "music.mp3"
    }
    
    cmdUI:Print("=== FILE MANAGER ===")
    cmdUI:Print("Current Directory: /home/user/")
    cmdUI:Print("")
    
    while true do
        cmdUI:Print("Files:")
        for i, file in ipairs(files) do
            cmdUI:Print(string.format("  [%d] %s", i, file))
        end
        cmdUI:Print("")
        
        local action = cmdUI:SelectByNumber(
            "Choose action:",
            {
                "Open File",
                "Delete File",
                "Create New File",
                "Exit"
            }
        )
        
        if action == 1 then
            local fileNum = cmdUI:Input("Enter file number to open:", "number")
            if files[fileNum] then
                cmdUI:Print("Opening " .. files[fileNum] .. "...", Color3.fromRGB(0, 255, 255))
                task.wait(1)
            else
                cmdUI:Print("File not found!", Color3.fromRGB(255, 0, 0))
            end
            
        elseif action == 2 then
            local fileNum = cmdUI:Input("Enter file number to delete:", "number")
            if files[fileNum] then
                local confirm = cmdUI:Confirm("Delete " .. files[fileNum] .. "?")
                if confirm then
                    table.remove(files, fileNum)
                    cmdUI:Print("File deleted.", Color3.fromRGB(255, 100, 100))
                end
            end
            
        elseif action == 3 then
            local filename = cmdUI:Input("Enter new filename:", "string")
            table.insert(files, filename)
            cmdUI:Print("File created!", Color3.fromRGB(0, 255, 0))
            
        else
            cmdUI:Destroy()
            break
        end
        
        cmdUI:Print("")
    end
end

-- ============================================================================
-- RUN ONE OF THE EXAMPLES
-- ============================================================================

-- Uncomment ONE of these to test:

-- AdminPanel()
-- ShopSystem()
-- QuizGame()
-- CharacterCreator()
-- SettingsMenu()
-- FileManager()

-- Or create a launcher menu:

local function LaunchMenu()
    local launcher = CMDUILibrary.new("Example Launcher")
    launcher:WaitForReady()
    
    launcher:Print("=== CMD UI LIBRARY - EXAMPLES ===")
    launcher:Print("")
    
    local choice = launcher:SelectByNumber(
        "Choose an example to run:",
        {
            "Admin Panel",
            "Shop System",
            "Quiz Game",
            "Character Creator",
            "Settings Menu",
            "File Manager"
        }
    )
    
    launcher:Destroy()
    task.wait(0.5)
    
    if choice == 1 then AdminPanel()
    elseif choice == 2 then ShopSystem()
    elseif choice == 3 then QuizGame()
    elseif choice == 4 then CharacterCreator()
    elseif choice == 5 then SettingsMenu()
    elseif choice == 6 then FileManager()
    end
end

-- Run the launcher
LaunchMenu()
