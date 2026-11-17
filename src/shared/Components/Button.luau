--!strict
-- NOCTELLE React | Reusable Button
-- SAO Minimal Design System

local RS = game:GetService("ReplicatedStorage")

local dev = RS:WaitForChild("NoctelleReactDev")

local React = require(dev:WaitForChild("Packages"):WaitForChild("React"))

local Tokens = require(script.Parent.Parent.Foundation.Tokens)

local e = React.createElement

local DEFAULT_THEME = {
	Accent = Color3.fromRGB(202, 157, 240),
	Surface = Color3.fromRGB(29, 26, 34),
	Text = Color3.fromRGB(245, 243, 248),
	Border = Color3.fromRGB(115, 98, 130),
	DarkText = Color3.fromRGB(22, 18, 28),
}

local Button = {}

function Button.Component(props: any)
	local variant = props.Variant or "Secondary"
	local disabled = props.Disabled == true

	-- Effective ancestor UI scale, supplied by the layout.
	local scale = props.EffectiveScale or 1

	local minimumHeight = Tokens.GetLogicalTarget(Tokens.Control.MinimumRenderedTarget, scale)

	local height = math.max(Tokens.Control.StandardHeight, minimumHeight)

	local theme = props.Theme or DEFAULT_THEME

	local background = theme.Surface
	local textColor = theme.Text
	local backgroundTransparency = 0.12
	local borderTransparency = 0.65

	if variant == "Primary" then
		background = theme.Accent
		textColor = theme.DarkText
		backgroundTransparency = 0
		borderTransparency = 1
	elseif variant == "Ghost" then
		backgroundTransparency = 1
		borderTransparency = 1
	end

	return e("TextButton", {
		Name = props.Name or "Button",

		Text = props.Text or "Button",

		Font = Tokens.Font.Medium,
		TextSize = Tokens.Type.Body,
		TextColor3 = textColor,
		TextTransparency = if disabled then 0.5 else 0,

		TextXAlignment = Enum.TextXAlignment.Center,
		TextYAlignment = Enum.TextYAlignment.Center,
		TextWrapped = false,
		TextTruncate = Enum.TextTruncate.AtEnd,

		BackgroundColor3 = background,
		BackgroundTransparency = if disabled then 0.6 else backgroundTransparency,

		BorderSizePixel = 0,

		Size = props.Size or UDim2.new(1, 0, 0, height),

		LayoutOrder = props.LayoutOrder or 0,

		AutoButtonColor = not disabled,
		Active = not disabled,
		Selectable = not disabled,

		[React.Event.Activated] = function()
			if disabled then
				return
			end

			if props.OnActivated then
				props.OnActivated()
			end
		end,
	}, {
		Corner = e("UICorner", {
			CornerRadius = UDim.new(0, Tokens.Radius.Control),
		}),

		Stroke = e("UIStroke", {
			Color = theme.Border,
			Transparency = borderTransparency,
			Thickness = Tokens.Glass.BorderThickness,
		}),

		Padding = e("UIPadding", {
			PaddingLeft = UDim.new(0, Tokens.Space.LG),
			PaddingRight = UDim.new(0, Tokens.Space.LG),
		}),
	})
end

return Button
