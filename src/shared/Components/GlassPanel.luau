
--!strict
-- NOCTELLE | GlassPanel
-- Phase 1D | Seamless Glass + Animated Border

local RS = game:GetService("ReplicatedStorage")

local dev = RS:WaitForChild("NoctelleReactDev")
local React = require(dev.Packages.React)

local Tokens = require(script.Parent.Parent.Foundation.Tokens)
local Theme = require(script.Parent.Parent.Foundation.Theme)

local e = React.createElement

local GlassPanel = {}

function GlassPanel.Component(props: any)
    local theme = props.Theme or Theme.Get("Noctelle")

    -- Uniform dark glass with subtle theme tint.
    local glassColor = theme.Surface:Lerp(
        theme.Accent,
        0.055
    )

    glassColor = glassColor:Lerp(
        Color3.new(1, 1, 1),
        0.09
    )

    local children = {
        -- Subtle glass surface gradient.
        -- This is separate from the animated border.
        SurfaceGradient = e("UIGradient", {
            Name = "SurfaceGradient",

            -- Soft elliptical gradient, not a straight band.
            Type = Enum.GradientType.Elliptical,

            -- Move the brightest point toward the upper left.
            Offset = Vector2.new(-0.25, -0.3),

            Scale = 1.55,

            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(
                    0,
                    theme.Surface:Lerp(theme.Accent, 0.23)
                        :Lerp(Color3.new(1, 1, 1), 0.17)
                ),

                ColorSequenceKeypoint.new(
                    0.25,
                    theme.Surface:Lerp(theme.Accent, 0.12)
                        :Lerp(Color3.new(1, 1, 1), 0.12)
                ),

                ColorSequenceKeypoint.new(
                    0.55,
                    theme.Surface:Lerp(theme.Accent, 0.06)
                        :Lerp(Color3.new(1, 1, 1), 0.09)
                ),

                ColorSequenceKeypoint.new(
                    0.8,
                    theme.Surface:Lerp(Color3.new(1, 1, 1), 0.075)
                ),

                ColorSequenceKeypoint.new(
                    1,
                    theme.Surface:Lerp(Color3.new(1, 1, 1), 0.06)
                ),
            }),
        }),



        Corner = e("UICorner", {
            CornerRadius = UDim.new(
                0,
                Tokens.Radius.Panel
            ),
        }),

        -- Main animated theme-colored border.
        Stroke = e("UIStroke", {
            Name = "AnimatedBorderStroke",
            Color = theme.Accent,
            Thickness = 1.5,
            Transparency = 0.12,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        }, {
            OrbitGradient = e("UIGradient", {
                Name = "OrbitGradient",
                Rotation = 0,

                Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, theme.Accent),
                    ColorSequenceKeypoint.new(0.35, theme.Accent),
                    ColorSequenceKeypoint.new(
                        0.5,
                        theme.Accent:Lerp(Color3.new(1, 1, 1), 0.9)
                    ),
                    ColorSequenceKeypoint.new(0.65, theme.Accent),
                    ColorSequenceKeypoint.new(1, theme.Accent),
                }),

                Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 0.55),
                    NumberSequenceKeypoint.new(0.35, 0.45),
                    NumberSequenceKeypoint.new(0.5, 0),
                    NumberSequenceKeypoint.new(0.65, 0.45),
                    NumberSequenceKeypoint.new(1, 0.55),
                }),
            }),
        }),


        Padding = e("UIPadding", {
            PaddingTop = UDim.new(0, Tokens.Space.LG),
            PaddingBottom = UDim.new(0, Tokens.Space.LG),
            PaddingLeft = UDim.new(0, Tokens.Space.LG),
            PaddingRight = UDim.new(0, Tokens.Space.LG),
        }),
    }

    for key, child in pairs(props.Children or {}) do
        children[key] = child
    end

    return e("Frame", {
        Name = props.Name or "GlassPanel",

        Size = props.Size
            or UDim2.fromOffset(300, 240),

        AnchorPoint = props.AnchorPoint
            or Vector2.new(0, 0),

        Position = props.Position
            or UDim2.fromOffset(0, 0),

        LayoutOrder = props.LayoutOrder or 0,

        BackgroundColor3 = Color3.new(1, 1, 1),

        -- Mostly opaque for consistent readability.
        BackgroundTransparency = 0.08,

        BorderSizePixel = 0,

        ClipsDescendants = props.Clip == true,
        Visible = props.Visible ~= false,
    }, children)
end

return table.freeze(GlassPanel)
