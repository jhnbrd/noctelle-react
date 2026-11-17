--!strict
-- NOCTELLE React | Responsive Foundation
-- Phase 1C | Adaptive layout, no global UI shrinking

local Tokens = require(script.Parent.Tokens)

local Responsive = {}

-- Maximum dimensions of the component playground.
Responsive.PanelWidth = 340
Responsive.PanelHeight = 510

-- Space between the panel and the safe screen edges.
Responsive.Margin = 16

-- Controls now render at their intended pixel sizes.
Responsive.ControlHeight = Tokens.Control.StandardHeight

-- Six theme choices in two rows.
Responsive.SwatchColumns = 3
Responsive.SwatchRows = 2
Responsive.SwatchSize = math.max(Tokens.Control.MinimumRenderedTarget, 48)
Responsive.SwatchGap = Tokens.Space.SM

-- Useful for future viewport diagnostics.
-- Actual panel resizing is handled by Roblox UI constraints.
function Responsive.GetPanelSize(availableArea: Vector2): Vector2
	local width = math.min(Responsive.PanelWidth, math.max(0, availableArea.X - Responsive.Margin * 2))

	local height = math.min(Responsive.PanelHeight, math.max(0, availableArea.Y - Responsive.Margin * 2))

	return Vector2.new(width, height)
end

function Responsive.GetControlHeight(): number
	return Responsive.ControlHeight
end

function Responsive.GetSwatchHeight(): number
	return Responsive.SwatchRows * Responsive.SwatchSize + (Responsive.SwatchRows - 1) * Responsive.SwatchGap
end

return table.freeze(Responsive)
