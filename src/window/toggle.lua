-- WoodUI/Components/Toggle.lua
local Toggle = {}
Toggle.__index = Toggle

function Toggle.new(data, parent)
    local self = setmetatable({}, Toggle)

    -- Data defaults
    local text = data.Name or "Toggle"
    local description = data.Description or ""
    local callback = data.Callback or function() end
    local state = data.Default or false

    -- Holder
    self.Holder = Instance.new("Frame")
    self.Holder.Size = UDim2.new(1, -10, 0, description ~= "" and 50 or 35)
    self.Holder.BackgroundTransparency = 1
    self.Holder.Parent = parent

    -- Label
    self.Label = Instance.new("TextLabel")
    self.Label.Size = UDim2.new(1, -40, 0, 30)
    self.Label.Position = UDim2.new(0, 5, 0, 0)
    self.Label.BackgroundTransparency = 1
    self.Label.Text = text
    self.Label.TextColor3 = Color3.new(0, 0, 0)
    self.Label.FontFace = Font.new("rbxassetid://12187365364")
    self.Label.TextSize = 16
    self.Label.TextXAlignment = Enum.TextXAlignment.Left
    self.Label.Parent = self.Holder

    -- Toggle button (indicator)
    self.Indicator = Instance.new("TextButton")
    self.Indicator.Size = UDim2.new(0, 30, 0, 30)
    self.Indicator.Position = UDim2.new(1, -35, 0, 0)
    self.Indicator.BackgroundColor3 = state and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
    self.Indicator.BorderSizePixel = 0
    self.Indicator.Text = ""
    self.Indicator.Parent = self.Holder

    -- Description
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

    -- Click logic
    self.Indicator.MouseButton1Click:Connect(function()
        state = not state
        self.Indicator.BackgroundColor3 = state and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
        task.spawn(callback, state)
    end)

    return self
end

return Toggle
