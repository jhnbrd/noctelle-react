--!strict
-- NOCTELLE React | Adaptive Component Playground
-- Phase 1C | Responsive without shrinking typography
-- Development place only

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
local Responsive = require(Foundation.Responsive)

local e = React.createElement

local Playground = {}

local function makeText(variant, value, color, order)
	return e(Text.Component, {
		Variant = variant,
		Text = value,
		Color = color,
		LayoutOrder = order,
	})
end

local function makeParagraph(value, color, order)
	-- Wrapped body text that expands vertically as needed.
	return e("TextLabel", {
		Name = "WrappedBody",
		LayoutOrder = order,

		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,

		BackgroundTransparency = 1,
		BorderSizePixel = 0,

		Text = value,
		Font = Tokens.Font.Regular,
		TextSize = Tokens.Type.Body,
		TextColor3 = color,

		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,
	})
end

local function verticalLayout(spacing)
	return e("UIListLayout", {
		SortOrder = Enum.SortOrder.LayoutOrder,
		FillDirection = Enum.FillDirection.Vertical,
		HorizontalAlignment = Enum.HorizontalAlignment.Left,
		Padding = UDim.new(0, spacing),
	})
end

local function themeSwatches(selectedTheme, onSelect)
	local target = Responsive.SwatchSize

	local children = {
		Grid = e("UIGridLayout", {
			SortOrder = Enum.SortOrder.LayoutOrder,
			FillDirection = Enum.FillDirection.Horizontal,
			FillDirectionMaxCells = Responsive.SwatchColumns,

			CellSize = UDim2.fromOffset(target, target),
			CellPadding = UDim2.fromOffset(Responsive.SwatchGap, Responsive.SwatchGap),

			HorizontalAlignment = Enum.HorizontalAlignment.Center,
		}),
	}

	for index, name in ipairs(Theme.Names) do
		local palette = Theme.Get(name)
		local selected = name == selectedTheme

		children[name] = e("TextButton", {
			Name = name,
			LayoutOrder = index,

			Size = UDim2.fromOffset(target, target),

			BackgroundColor3 = palette.Surface,
			BackgroundTransparency = 0.25,
			BorderSizePixel = 0,

			Text = "",
			AutoButtonColor = false,

			[React.Event.Activated] = function()
				onSelect(name)
			end,
		}, {
			Corner = e("UICorner", {
				CornerRadius = UDim.new(0, Tokens.Radius.Control),
			}),

			Selection = e("UIStroke", {
				Color = palette.Accent,
				Thickness = if selected then 2 else 1,
				Transparency = if selected then 0 else 0.8,
			}),

			Swatch = e("Frame", {
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.5),

				Size = UDim2.fromOffset(28, 28),

				BackgroundColor3 = palette.Accent,
				BorderSizePixel = 0,
			}, {
				Corner = e("UICorner", {
					CornerRadius = UDim.new(0, 6),
				}),
			}),
		})
	end

	return e("Frame", {
		Name = "ThemeSwatches",
		LayoutOrder = 10,

		Size = UDim2.new(1, 0, 0, Responsive.GetSwatchHeight()),

		BackgroundTransparency = 1,
	}, children)
end

local function PlaygroundApp()
	local selectedTheme, setSelectedTheme = React.useState("Noctelle")

	local clickCount, setClickCount = React.useState(0)

	local palette = Theme.Get(selectedTheme)

	local function recordClick(name)
		setClickCount(function(previous)
			return previous + 1
		end)

		print("[PLAYGROUND BUTTON]", name)
	end

	local function selectTheme(name)
		setSelectedTheme(name)
		print("[PLAYGROUND THEME]", name)
	end

	local controlHeight = Responsive.GetControlHeight()
	local buttonGap = Tokens.Space.SM

	local buttons = {
		Layout = verticalLayout(buttonGap),

		Primary = e(Button.Component, {
			Name = "Primary",
			Variant = "Primary",
			Text = "Primary Action",
			Theme = palette,
			EffectiveScale = 1,
			LayoutOrder = 1,

			OnActivated = function()
				recordClick("Primary")
			end,
		}),

		Secondary = e(Button.Component, {
			Name = "Secondary",
			Variant = "Secondary",
			Text = "Secondary Action",
			Theme = palette,
			EffectiveScale = 1,
			LayoutOrder = 2,

			OnActivated = function()
				recordClick("Secondary")
			end,
		}),

		Ghost = e(Button.Component, {
			Name = "Ghost",
			Variant = "Ghost",
			Text = "Ghost Action",
			Theme = palette,
			EffectiveScale = 1,
			LayoutOrder = 3,

			OnActivated = function()
				recordClick("Ghost")
			end,
		}),

		Disabled = e(Button.Component, {
			Name = "Disabled",
			Variant = "Secondary",
			Text = "Disabled Action",
			Theme = palette,
			Disabled = true,
			EffectiveScale = 1,
			LayoutOrder = 4,
		}),
	}

	local content = {
		Layout = verticalLayout(Tokens.Space.MD),

		Header = makeText("Heading", "NOCTELLE", palette.Text, 1),

		Subtitle = makeText("Caption", "Component Playground / Phase 1C", palette.Muted, 2),

		DividerTop = e(Divider.Component, {
			Theme = palette,
			LayoutOrder = 3,
		}),

		Title = makeText("Title", "Music & Dance", palette.Text, 4),

		Body = makeParagraph("Choose an animation to begin dancing.", palette.Text, 5),

		Buttons = e("Frame", {
			Name = "Buttons",
			LayoutOrder = 6,

			Size = UDim2.new(1, 0, 0, controlHeight * 4 + buttonGap * 3),

			BackgroundTransparency = 1,
		}, buttons),

		ClickStatus = makeText("Caption", "Button activations: " .. tostring(clickCount), palette.Muted, 7),

		CardPreview = e(Card.Component, {
			Name = "CardPreview",
			Theme = palette,
			LayoutOrder = 8,

			Size = UDim2.new(1, 0, 0, 86),

			Children = {
				Layout = verticalLayout(Tokens.Space.XS),

				Title = makeText("Title", "Current Server", palette.Text, 1),

				Detail = makeText("Caption", "Reusable SAO Minimal card", palette.Muted, 2),
			},
		}),

		ThemeLabel = makeText("Title", "Themes", palette.Text, 9),

		Swatches = themeSwatches(selectedTheme, selectTheme),

		SelectedTheme = makeText("Caption", "Selected: " .. selectedTheme, palette.Muted, 11),
	}

	local scroll = e("ScrollingFrame", {
		Name = "PlaygroundScroll",

		Size = UDim2.fromScale(1, 1),

		BackgroundTransparency = 1,
		BorderSizePixel = 0,

		CanvasSize = UDim2.fromOffset(0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,

		ScrollingDirection = Enum.ScrollingDirection.Y,
		ElasticBehavior = Enum.ElasticBehavior.WhenScrollable,

		ScrollBarThickness = 3,
		ScrollBarImageColor3 = palette.Accent,

		Active = true,
		ClipsDescendants = true,
	}, content)

	return e(GlassPanel.Component, {
		Name = "PlaygroundPanel",
		Theme = palette,

		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),

		-- Fill the safe area minus margins.
		-- UISizeConstraint limits large desktop dimensions.
		Size = UDim2.new(1, -Responsive.Margin * 2, 1, -Responsive.Margin * 2),

		Children = {
			Constraint = e("UISizeConstraint", {
				MaxSize = Vector2.new(Responsive.PanelWidth, Responsive.PanelHeight),
			}),

			Scroll = scroll,
		},
	})
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
	gui.ScreenInsets = Enum.ScreenInsets.CoreUISafeInsets
	gui.DisplayOrder = 1000
	gui.Parent = playerGui

	local root = ReactRoblox.createRoot(gui)

	root:render(e(PlaygroundApp))

	print("[PLAYGROUND] Adaptive React preview mounted")

	return function()
		root:unmount()
		gui:Destroy()
	end
end

return Playground
