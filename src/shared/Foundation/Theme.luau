--!strict
-- NOCTELLE React | Theme Foundation
-- SAO Minimal | Six accent themes

local Theme = {}

local BASE = table.freeze({
	Background = Color3.fromRGB(16, 14, 20),
	Surface = Color3.fromRGB(29, 26, 34),
	Text = Color3.fromRGB(245, 243, 248),
	Muted = Color3.fromRGB(170, 165, 182),
	Border = Color3.fromRGB(115, 98, 130),
	DarkText = Color3.fromRGB(22, 18, 28),
})

local ACCENTS = table.freeze({
	Noctelle = Color3.fromRGB(202, 157, 240),
	Rose = Color3.fromRGB(244, 114, 182),
	Ocean = Color3.fromRGB(56, 189, 248),
	Emerald = Color3.fromRGB(52, 211, 153),
	Ember = Color3.fromRGB(251, 146, 60),
	Monochrome = Color3.fromRGB(229, 231, 235),
})

Theme.Names = table.freeze({
	"Noctelle",
	"Rose",
	"Ocean",
	"Emerald",
	"Ember",
	"Monochrome",
})

function Theme.Get(name: string?)
	local selected = name or "Noctelle"
	local accent = ACCENTS[selected] or ACCENTS.Noctelle

	return table.freeze({
		Name = if ACCENTS[selected] then selected else "Noctelle",
		Accent = accent,
		Background = BASE.Background,
		Surface = BASE.Surface,
		Text = BASE.Text,
		Muted = BASE.Muted,
		Border = BASE.Border,
		DarkText = BASE.DarkText,
	})
end

return table.freeze(Theme)
