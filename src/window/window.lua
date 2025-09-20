-- WoodUI/Components/Window.lua
local Window = {}
Window.__index = Window

-- Utility: make frame draggable
local function MakeDraggable(frame, dragger)
    dragger = dragger or frame
    local dragging = false
    local dragInput, mousePos, framePos
    local UserInputService = game:GetService("UserInputService")

    dragger.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = input.Position
            framePos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    dragger.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            frame.Position = UDim2.new(
                framePos.X.Scale,
                framePos.X.Offset + delta.X,
                framePos.Y.Scale,
                framePos.Y.Offset + delta.Y
            )
        end
    end)
end

-- Constructor
function Window.new(options)
    local self = setmetatable({}, Window)

    local CoreGui = game:GetService("CoreGui")
    local theme = options.ThemeData or {
        BackgroundColor = Color3.fromRGB(245, 245, 245),
        HeaderColor = Color3.fromRGB(200, 200, 200),
        TextColor = Color3.new(0, 0, 0)
    }

    -- Main frame
    self.Frame = Instance.new("Frame")
    self.Frame.Size = UDim2.new(0, 400, 0, 300)
    self.Frame.Position = UDim2.new(0.5, -200, 0.5, -150)
    self.Frame.AnchorPoint = Vector2.new(0.5, 0.5)
    self.Frame.BackgroundColor3 = theme.BackgroundColor
    self.Frame.BorderSizePixel = 0
    self.Frame.Parent = CoreGui

    -- Title bar
    self.TitleBar = Instance.new("Frame")
    self.TitleBar.Size = UDim2.new(1, 0, 0, 30)
    self.TitleBar.BackgroundColor3 = theme.HeaderColor
    self.TitleBar.Parent = self.Frame

    -- Title label
    self.TitleLabel = Instance.new("TextLabel")
    self.TitleLabel.Size = UDim2.new(1, -10, 1, 0)
    self.TitleLabel.Position = UDim2.new(0, 10, 0, 0)
    self.TitleLabel.BackgroundTransparency = 1
    self.TitleLabel.Text = options.Title or "Window"
    self.TitleLabel.TextColor3 = theme.TextColor
    self.TitleLabel.FontFace = Font.new("rbxassetid://12187365364") -- applied inline
    self.TitleLabel.TextSize = 18
    self.TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    self.TitleLabel.Parent = self.TitleBar

    -- Make draggable
    MakeDraggable(self.Frame, self.TitleBar)

    -- Tabs container
    self.TabsContainer = Instance.new("Frame")
    self.TabsContainer.Size = UDim2.new(1, 0, 1, -30)
    self.TabsContainer.Position = UDim2.new(0, 0, 0, 30)
    self.TabsContainer.BackgroundTransparency = 1
    self.TabsContainer.Parent = self.Frame

    -- Table to store tabs
    self.Tabs = {}

    return self
end

-- AddTab
function Window:AddTab(tabName)
    local TabModule = require(script.Parent:WaitForChild("Tab"))
    local tab = TabModule.new(tabName, self.TabsContainer)
    table.insert(self.Tabs, tab)
    return tab
end

return Window
