-- WoodUI/Components/Tab.lua
local Tab = {}
Tab.__index = Tab

function Tab.new(name, tabHolder, contentHolder)
    local self = setmetatable({}, Tab)

    -- Tab Button
    self.Button = Instance.new("TextButton")
    self.Button.Size = UDim2.new(0, 120, 0, 30)
    self.Button.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
    self.Button.BorderSizePixel = 0
    self.Button.Text = name
    self.Button.TextColor3 = Color3.new(0, 0, 0)
    self.Button.FontFace = Font.new("rbxassetid://12187365364")
    self.Button.TextSize = 16
    self.Button.Parent = tabHolder

    -- Tab Content (ScrollingFrame)
    self.Frame = Instance.new("ScrollingFrame")
    self.Frame.Size = UDim2.new(1, 0, 1, 0)
    self.Frame.CanvasSize = UDim2.new(0, 0, 0, 0)
    self.Frame.ScrollBarThickness = 4
    self.Frame.ScrollingDirection = Enum.ScrollingDirection.Y
    self.Frame.BackgroundTransparency = 1
    self.Frame.Visible = false
    self.Frame.Parent = contentHolder

    -- UIListLayout inside ScrollingFrame
    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 5)
    layout.Parent = self.Frame

    -- Auto resize CanvasSize
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        self.Frame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
    end)

    -- Tab switching
    self.Button.MouseButton1Click:Connect(function()
        for _, child in ipairs(contentHolder:GetChildren()) do
            if child:IsA("ScrollingFrame") then
                child.Visible = false
            end
        end
        self.Frame.Visible = true
    end)

    return self
end

-- Add button inside tab
function Tab:AddButton(text, callback)
    local ButtonModule = require(script.Parent:WaitForChild("Button"))
    local button = ButtonModule.new(text, callback, self.Frame)
    return button
end

return Tab
