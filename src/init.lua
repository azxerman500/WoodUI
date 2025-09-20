-- WoodUI/init.lua
local WoodUI = {}

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")

-- Load modules
local Components = script:WaitForChild("Components")
local Themes = script:WaitForChild("Themes")
local Utils = script:WaitForChild("Utils")

-- Window module
local Window = loadstring(game:HttpGet('https://raw.githubusercontent.com/azxerman500/WoodUI/main/src/window/window.lua'))()

-- Theme handling
local CurrentTheme = "Default"
local ThemeModules = {}
for _, themeModule in pairs(Themes:GetChildren()) do
    ThemeModules[themeModule.Name] = require(themeModule)
end

-- CreateWindow function
function WoodUI:CreateWindow(options)
    options = options or {}
    options.ThemeData = ThemeModules[options.Theme or "Default"]
    
    local window = Window.new(options)
    return window
end

-- Optional: allow changing theme globally
function WoodUI:SetTheme(themeName)
    if ThemeModules[themeName] then
        CurrentTheme = themeName
    else
        warn("Theme not found:", themeName)
    end
end

return WoodUI
