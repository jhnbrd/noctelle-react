--!strict
-- NOCTELLE React | Glass Panel

local RS = game:GetService("ReplicatedStorage")
local dev = RS:WaitForChild("NoctelleReactDev")

local React = require(dev.Packages.React)
local Tokens = require(script.Parent.Parent.Foundation.Tokens)
local Theme = require(script.Parent.Parent.Foundation.Theme)

local e = React.createElement

local GlassPanel = {}

function GlassPanel.Component(props: any)
	local theme = props.Theme or Theme.Get("Noctelle")

	local children = {
		Corner = e("UICorner", {
			CornerRadius = UDim.new(0, Tokens.Radius.Panel),
		}),

		Stroke = e("UIStroke", {
			Color = theme.Border,
			Thickness = Tokens.Glass.BorderThickness,
			Transparency = Tokens.Glass.BorderTransparency,
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
		Size = props.Size or UDim2.fromOffset(300, 240),
		AnchorPoint = props.AnchorPoint or Vector2.new(0, 0),
		Position = props.Position or UDim2.fromOffset(0, 0),
		LayoutOrder = props.LayoutOrder or 0,
		BackgroundColor3 = theme.Surface,
		BackgroundTransparency = Tokens.Glass.SurfaceTransparency,
		BorderSizePixel = 0,
		ClipsDescendants = props.Clip == true,
		Visible = props.Visible ~= false,
	}, children)
end

return GlassPanel
