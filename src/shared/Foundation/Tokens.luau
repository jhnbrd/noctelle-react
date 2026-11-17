--!strict
-- NOCTELLE DEV | SAO Minimal Design Tokens
-- Canonical foundation for the new React UI
-- No dependency on legacy UI component modules

local Tokens = {}

Tokens.Font = table.freeze({
	Regular = Enum.Font.Gotham,
	Medium = Enum.Font.GothamMedium,
	Bold = Enum.Font.GothamBold,
})

Tokens.Type = table.freeze({
	Heading = 20,
	Title = 17,
	Body = 15,
	Caption = 13,
})

Tokens.Space = table.freeze({
	XS = 4,
	SM = 8,
	MD = 12,
	LG = 16,
	XL = 24,
	XXL = 32,
})

Tokens.Radius = table.freeze({
	Control = 8,
	Card = 12,
	Panel = 16,
})

Tokens.Control = table.freeze({
	StandardHeight = 48,
	CompactVisual = 40,
	MinimumRenderedTarget = 44,
	Icon = 20,
})

Tokens.Glass = table.freeze({
	SurfaceTransparency = 0.04,
	BorderThickness = 1,
	BorderTransparency = 0.55,
})

-- The rendered size depends on ancestor UIScale.
-- Use this for sizing logical interaction targets.
function Tokens.GetLogicalTarget(renderedMinimum: number, effectiveScale: number): number
	assert(effectiveScale > 0, "Scale must be positive")

	return math.ceil(renderedMinimum / effectiveScale)
end

return table.freeze(Tokens)
