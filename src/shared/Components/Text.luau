--!strict
-- NOCTELLE React | Typography Component
-- SAO Minimal Design System

local RS = game:GetService("ReplicatedStorage")

local dev = RS:WaitForChild("NoctelleReactDev")
local React = require(dev:WaitForChild("Packages"):WaitForChild("React"))

local Tokens = require(script.Parent.Parent.Foundation.Tokens)

local e = React.createElement

local VARIANTS = {
	Heading = {
		Size = Tokens.Type.Heading,
		Font = Tokens.Font.Bold,
		Height = 28,
	},

	Title = {
		Size = Tokens.Type.Title,
		Font = Tokens.Font.Medium,
		Height = 24,
	},

	Body = {
		Size = Tokens.Type.Body,
		Font = Tokens.Font.Regular,
		Height = 22,
	},

	Caption = {
		Size = Tokens.Type.Caption,
		Font = Tokens.Font.Regular,
		Height = 20,
	},
}

local Text = {}

function Text.Component(props: any)
	local variant = VARIANTS[props.Variant or "Body"] or VARIANTS.Body

	return e("TextLabel", {
		Name = props.Name or "Text",

		Text = props.Text or "",

		Font = props.Font or variant.Font,
		TextSize = props.TextSize or variant.Size,

		TextColor3 = props.Color or Color3.fromRGB(245, 243, 248),

		TextTransparency = props.Transparency or 0,

		TextXAlignment = props.Align or Enum.TextXAlignment.Left,

		TextYAlignment = Enum.TextYAlignment.Center,

		TextWrapped = props.Wrap == true,
		TextTruncate = Enum.TextTruncate.AtEnd,

		BackgroundTransparency = 1,
		BorderSizePixel = 0,

		Size = props.Size or UDim2.new(1, 0, 0, variant.Height),

		LayoutOrder = props.LayoutOrder or 0,

		Visible = props.Visible ~= false,
	})
end

return Text
