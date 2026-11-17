
--!strict
-- NOCTELLE React | Premium Glass Card
-- Phase 1D.3 | Theme-aware glassmorphism

local RS = game:GetService("ReplicatedStorage")
local dev = RS:WaitForChild("NoctelleReactDev")

local React = require(dev.Packages.React)
local Tokens = require(script.Parent.Parent.Foundation.Tokens)
local Theme = require(script.Parent.Parent.Foundation.Theme)

local e = React.createElement

local Card = {}

function Card.Component(props: any)
    local theme = props.Theme or Theme.Get("Noctelle")

    -- Subtle tinted surfaces with enough contrast for text.
    local topColor = theme.Surface:Lerp(theme.Accent, 0.13)
    local bottomColor = theme.Surface:Lerp(
        Color3.new(0, 0, 0),
        0.08
    )

    local children = {
        Corner = e("UICorner", {
            CornerRadius = UDim.new(
                0,
                Tokens.Radius.Card
            ),
        }),

        -- Theme-aware glass outline.
        Stroke = e("UIStroke", {
            Color = theme.Accent,
            Transparency = 0.48,
            Thickness = 1,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        }),

        -- Consistent inner spacing.
        Padding = e("UIPadding", {
            PaddingTop = UDim.new(0, Tokens.Space.MD),
            PaddingBottom = UDim.new(0, Tokens.Space.MD),
            PaddingLeft = UDim.new(0, Tokens.Space.MD),
            PaddingRight = UDim.new(0, Tokens.Space.MD),
        }),
    }

    for key, child in pairs(props.Children or {}) do
        children[key] = child
    end

    return e("Frame", {
        Name = props.Name or "Card",

        Size = props.Size or UDim2.new(1, 0, 0, 100),
        LayoutOrder = props.LayoutOrder or 0,

        -- White base preserves UIGradient colors.
        BackgroundColor3 = theme.Surface:Lerp(
            theme.Accent,
            0.035
        ),
        BackgroundTransparency = 0.08,

        BorderSizePixel = 0,
        Visible = props.Visible ~= false,
    }, children)
end

return table.freeze(Card)
