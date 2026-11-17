--!strict
-- NOCTELLE React | Divider

local RS = game:GetService("ReplicatedStorage")
local dev = RS:WaitForChild("NoctelleReactDev")

local React = require(dev.Packages.React)
local Theme = require(script.Parent.Parent.Foundation.Theme)

local e = React.createElement

local Divider = {}

function Divider.Component(props: any)
	local theme = props.Theme or Theme.Get("Noctelle")

	return e("Frame", {
		Name = props.Name or "Divider",
		Size = props.Size or UDim2.new(1, 0, 0, 1),
		LayoutOrder = props.LayoutOrder or 0,
		BackgroundColor3 = theme.Accent,
		BackgroundTransparency = props.Transparency or 0.65,
		BorderSizePixel = 0,
	})
end

return Divider
