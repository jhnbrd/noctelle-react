--!strict
-- NOCTELLE React | Component Playground
-- Phase 1A | Development preview only

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")

local dev = RS:WaitForChild("NoctelleReactDev")

local React = require(dev.Packages.React)
local ReactRoblox = require(dev.Packages.ReactRoblox)

local Components = dev:WaitForChild("Components")
local Foundation = dev:WaitForChild("Foundation")

local Text = require(Components.Text)
local Button = require(Components.Button)
local GlassPanel = require(Components.GlassPanel)
local Card = require(Components.Card)
local Divider = require(Components.Divider)

local Tokens = require(Foundation.Tokens)
local Theme = require(Foundation.Theme)

local e = React.createElement

local Playground = {}

local function text(variant, value, order, theme)
	return e(Text.Component, {
		Variant = variant,
		Text = value,
		Color = theme.Text,
		LayoutOrder = order,
	})
end

local function makeLayout(padding)
	return e("UIListLayout", {
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, padding),
		HorizontalAlignment = Enum.HorizontalAlignment.Left,
	})
end

local function makeSwatches()
	local swatches = {
		Layout = e("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalAlignment = Enum.HorizontalAlignment.Left,
			Padding = UDim.new(0, 8),
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
	}

	for index, name in ipairs(Theme.Names) do
		local palette = Theme.Get(name)

		swatches[name] = e("Frame", {
			Name = name,
			LayoutOrder = index,
			Size = UDim2.fromOffset(28, 28),
			BackgroundColor3 = palette.Accent,
			BorderSizePixel = 0,
		}, {
			Corner = e("UICorner", {
				CornerRadius = UDim.new(0, 7),
			}),
		})
	end

	return e("Frame", {
		Name = "ThemeSwatches",
		LayoutOrder = 8,
		Size = UDim2.new(1, 0, 0, 30),
		BackgroundTransparency = 1,
	}, swatches)
end

function Playground.Mount(playerGui)
	assert(game.PlaceId == 119625856408570, "Component playground is DEV-only")

	assert(Players.LocalPlayer ~= nil, "Mount must run on the client")

	local previous = playerGui:FindFirstChild("NoctelleComponentPlayground")

	if previous then
		previous:Destroy()
	end

	local gui = Instance.new("ScreenGui")
	gui.Name = "NoctelleComponentPlayground"
	gui.ResetOnSpawn = false
	gui.IgnoreGuiInset = false
	gui.DisplayOrder = 1000
	gui.Parent = playerGui

	local root = ReactRoblox.createRoot(gui)
	local palette = Theme.Get("Noctelle")

	local children = {
		Layout = makeLayout(Tokens.Space.MD),

		Header = text("Heading", "NOCTELLE", 1, palette),

		Subtitle = e(Text.Component, {
			Variant = "Caption",
			Text = "Component Playground / Phase 1A",
			Color = palette.Muted,
			LayoutOrder = 2,
		}),

		DividerTop = e(Divider.Component, {
			Theme = palette,
			LayoutOrder = 3,
		}),

		Title = text("Title", "Music & Dance", 4, palette),

		Body = text("Body", "Choose an animation to begin dancing.", 5, palette),

		UIScale = e("UIScale", {
			Scale = 0.8949152827,
		}),

		Buttons = e("Frame", {
			Name = "Buttons",
			LayoutOrder = 6,
			Size = UDim2.new(1, 0, 0, 112),
			BackgroundTransparency = 1,
		}, {
			Layout = makeLayout(8),

			Primary = e(Button.Component, {
				Name = "Primary",
				Variant = "Primary",
				Text = "Primary Action",
				Theme = palette,
				EffectiveScale = 0.8949152827,
				LayoutOrder = 1,

				OnActivated = function()
					print("[PLAYGROUND] Primary clicked")
				end,
			}),

			Secondary = e(Button.Component, {
				Name = "Secondary",
				Variant = "Secondary",
				Text = "Secondary Action",
				Theme = palette,
				EffectiveScale = 0.8949152827,
				LayoutOrder = 2,

				OnActivated = function()
					print("[PLAYGROUND] Secondary clicked")
				end,
			}),
		}),

		CardPreview = e(Card.Component, {
			Name = "CardPreview",
			Theme = palette,
			LayoutOrder = 7,
			Size = UDim2.new(1, 0, 0, 86),

			Children = {
				Layout = e("UIListLayout", {
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, Tokens.Space.XS),
				}),

				Title = e(Text.Component, {
					Name = "CardTitle",
					Variant = "Title",
					Text = "Current Server",
					Color = palette.Text,
					LayoutOrder = 1,
				}),

				Detail = e(Text.Component, {
					Name = "CardDetail",
					Variant = "Caption",
					Text = "Reusable SAO Minimal card",
					Color = palette.Muted,
					LayoutOrder = 2,
				}),
			},
		}),

		Swatches = makeSwatches(),
	}

	root:render(e(GlassPanel.Component, {
		Name = "PlaygroundPanel",
		Theme = palette,

		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),

		Size = UDim2.fromOffset(340, 450),

		Children = children,
	}))

	print("[PLAYGROUND] React preview mounted")

	return function()
		root:unmount()
		gui:Destroy()
	end
end

return Playground
