--!strict
-- NOCTELLE React | Card

local RS = game:GetService("ReplicatedStorage")
local dev = RS:WaitForChild("NoctelleReactDev")

local React = require(dev.Packages.React)
local Tokens = require(script.Parent.Parent.Foundation.Tokens)
local Theme = require(script.Parent.Parent.Foundation.Theme)

local e = React.createElement

local Card = {}

function Card.Component(props: any)
	local theme = props.Theme or Theme.Get("Noctelle")

	local children = {
		Corner = e("UICorner", {
			CornerRadius = UDim.new(0, Tokens.Radius.Card),
		}),

		Stroke = e("UIStroke", {
            Color = theme.Accent,
            Transparency = 0.45,
            Thickness = 1,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        }),

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
		BackgroundColor3 = theme.Surface,
		BackgroundTransparency = 0.04,
		BorderSizePixel = 0,
		Visible = props.Visible ~= false,
	}, children)
end

return Card
