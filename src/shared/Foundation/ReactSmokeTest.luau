--!strict
-- NOCTELLE DEV | React smoke test
-- Isolated from the legacy HUD

local RS = game:GetService("ReplicatedStorage")

local packages = RS:WaitForChild("NoctelleReactDev")
    :WaitForChild("Packages")

local React = require(packages:WaitForChild("React"))
local ReactRoblox = require(packages:WaitForChild("ReactRoblox"))

local e = React.createElement

local Preview = {}

function Preview.Mount(playerGui)
    local previous = playerGui:FindFirstChild("NoctelleReactPreview")
    if previous then
        previous:Destroy()
    end

    local gui = Instance.new("ScreenGui")
    gui.Name = "NoctelleReactPreview"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.DisplayOrder = 950
    gui.Parent = playerGui

    local root = ReactRoblox.createRoot(gui)

    root:render(e("Frame", {
        Name = "PreviewPanel",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(300, 160),
        BackgroundColor3 = Color3.fromRGB(22, 20, 28),
        BackgroundTransparency = 0.12,
        BorderSizePixel = 0,
    }, {
        Corner = e("UICorner", {
            CornerRadius = UDim.new(0, 10),
        }),

        Stroke = e("UIStroke", {
            Color = Color3.fromRGB(202, 157, 240),
            Transparency = 0.65,
            Thickness = 1,
        }),

        Title = e("TextLabel", {
            AnchorPoint = Vector2.new(0.5, 0),
            Position = UDim2.new(0.5, 0, 0, 24),
            Size = UDim2.new(1, -32, 0, 28),
            BackgroundTransparency = 1,
            Font = Enum.Font.GothamBold,
            Text = "NOCTELLE",
            TextSize = 20,
            TextColor3 = Color3.fromRGB(245, 243, 248),
        }),

        Subtitle = e("TextLabel", {
            AnchorPoint = Vector2.new(0.5, 0),
            Position = UDim2.new(0.5, 0, 0, 54),
            Size = UDim2.new(1, -32, 0, 24),
            BackgroundTransparency = 1,
            Font = Enum.Font.Gotham,
            Text = "React-Luau / Source Managed",
            TextSize = 14,
            TextColor3 = Color3.fromRGB(170, 165, 182),
        }),

        Button = e("TextButton", {
            AnchorPoint = Vector2.new(0.5, 0),
            Position = UDim2.new(0.5, 0, 0, 94),
            Size = UDim2.new(1, -32, 0, 44),
            BackgroundColor3 = Color3.fromRGB(202, 157, 240),
            BorderSizePixel = 0,
            Font = Enum.Font.GothamMedium,
            Text = "Source sync working",
            TextSize = 15,
            TextColor3 = Color3.fromRGB(22, 20, 28),
        }, {
            Corner = e("UICorner", {
                CornerRadius = UDim.new(0, 8),
            }),
        }),
    }))

    return function()
        root:unmount()
        gui:Destroy()
    end
end

return Preview
