-- WoodUI/Components/Button.lua
local Button = {}
Button.__index = Button

function Button.new(data, parent)
    local self = setmetatable({}, Button)

    -- Data defaults
    local text = data.Name or "Button"
    local description = data.Description or ""
    local callback = data.Callback or function() end

    -- Holder (so button + description stack together in scrolling frame)
    self.Holder = Instance.new("Frame")
    self.Holder.Size = UDim2.new(1, -10, 0, description ~= "" and 50 or 35)
    self.Holder.BackgroundTransparency = 1
    self.Holder.Parent = parent

    -- Button itself
    self.Button = Instance.new("TextButton")
    self.Button.Size = UDim2.new(0, 150, 0, 30)
    self.Button.Position = UDim2.new(0, 5, 0, 0)
    self.Button.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    self.Button.BorderSizePixel = 0
    self.Button.Text = text
    self.Button.TextColor3 = Color3.new(0, 0, 0)
    self.Button.FontFace = Font.new("rbxassetid://12187365364") -- inline font
    self.Button.TextSize = 16
    self.Button.Parent = self.Holder

    -- Description (optional)
    if description ~= "" then
        self.Description = Instance.new("TextLabel")
        self.Description.Size = UDim2.new(1, -10, 0, 15)
        self.Description.Position = UDim2.new(0, 5, 0, 32)
        self.Description.BackgroundTransparency = 1
        self.Description.Text = description
        self.Description.TextColor3 = Color3.fromRGB(100, 100, 100)
        self.Description.FontFace = Font.new("rbxassetid://12187365364")
        self.Description.TextSize = 12
        self.Description.TextXAlignment = Enum.TextXAlignment.Left
        self.Description.Parent = self.Holder
    end

    -- Click event
    self.Button.MouseButton1Click:Connect(function()
        task.spawn(callback)
    end)

    return self
end

return Button
