--!strict
-- NOCTELLE | Acrylic Blur Controller
-- Phase 1D.8 - React Playground Integration
-- Development only: press B after loading.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")

local DEV_PLACE_ID = 119625856408570

if game.PlaceId ~= DEV_PLACE_ID then
    return
end

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local Acrylic = require(
    ReplicatedStorage:WaitForChild("Acrylic")
)

local GUI_NAME = "NoctelleComponentPlayground"
local PANEL_NAME = "PlaygroundPanel"

local gui = playerGui:WaitForChild(GUI_NAME, 20)

if not gui then
    warn("[NOCTELLE ACRYLIC] Playground GUI missing")
    return
end

local panel = gui:WaitForChild(PANEL_NAME, 20)

if not panel or not panel:IsA("GuiObject") then
    warn("[NOCTELLE ACRYLIC] Playground panel missing")
    return
end

-- Do not start the blur while the loading
-- sequence and cinematic camera are active.
local enabled = false
local initialized = false

local blur = nil
local dof: DepthOfFieldEffect? = nil

local function initialize()
    if initialized then
        return
    end

    -- Use only the blur geometry from Acrylic+.
    -- Do NOT use AcrylicPaint's overlapping UI.
    blur = Acrylic.AcrylicBlur()

    -- This invisible frame tracks our existing
    -- React panel's screen position and size.
    blur.Frame.Name = "NoctelleBlurTracker"
    blur.Frame.BackgroundTransparency = 1
    blur.Frame.BorderSizePixel = 0
    blur.Frame.Size = UDim2.fromScale(1, 1)
    blur.Frame.Position = UDim2.fromScale(0, 0)
    blur.Frame.Active = false

    blur.Frame.Parent = panel

    blur.AddParent(panel)

    -- Start with the 3D glass surface hidden.
    blur.SetVisibility(false)

    -- Create our own effect instead of calling
    -- Acrylic.init(), so we can cleanly manage
    -- the effect without changing other effects.
    local effect = Instance.new("DepthOfFieldEffect")
    effect.Name = "NoctelleAcrylicDOF"
    
    -- Confirmed working acrylic blur configuration
    effect.FocusDistance = 0.5
    effect.InFocusRadius = 0.05
    effect.NearIntensity = 1
    effect.FarIntensity = 0

    effect.Enabled = false
    effect.Parent = Lighting


    dof = effect
    initialized = true

    -- Trigger an initial geometry update after
    -- the tracker has entered the GUI tree.
    task.defer(function()
        if blur and blur.Frame.Parent then
            blur.Frame.Size = UDim2.new(1, -1, 1, -1)
            blur.Frame.Size = UDim2.fromScale(1, 1)
        end
    end)

    print("[NOCTELLE ACRYLIC] Initialized")
end


-- A panel is visible only if every GUI ancestor
-- is also visible/enabled.

local function isPanelActuallyVisible(): boolean
    if not panel:IsDescendantOf(playerGui) then
        return false
    end

    if panel.AbsoluteSize.X <= 0
        or panel.AbsoluteSize.Y <= 0 then
        return false
    end

    local current: Instance? = panel

    while current and current ~= playerGui do
        if current:IsA("GuiObject") then
            if not current.Visible then
                return false
            end
        elseif current:IsA("ScreenGui") then
            if not current.Enabled then
                return false
            end
        end

        current = current.Parent
    end

    return current == playerGui
end


local function setEnabled(value: boolean)
    enabled = value

    if enabled and not initialized then
        initialize()
    end

    if initialized and blur then
        local visible = enabled and isPanelActuallyVisible()

        blur.SetVisibility(visible)

        if dof then
            dof.Enabled = visible
        end
    end

    print("[NOCTELLE ACRYLIC] Blur:", enabled)
end

-- NOCTELLE | Automatic Acrylic activation
-- Listen to the real cinematic completion signal.


-- NOCTELLE | Graphics Quality
-- High: Acrylic enabled
-- Balanced: Acrylic enabled (single-panel prototype)
-- Performance: Acrylic disabled

local VALID_QUALITIES = {
    High = true,
    Balanced = true,
    Performance = true,
}

local function getGraphicsQuality(): string
    local quality = playerGui:GetAttribute(
        "NoctelleGraphicsQuality"
    )

    if type(quality) == "string"
        and VALID_QUALITIES[quality] then
        return quality
    end

    return "Balanced"
end

local function updateIntroState()
    local introComplete =
        playerGui:GetAttribute(
            "NoctelleIntroComplete"
        ) == true

    local quality = getGraphicsQuality()

    local shouldEnable =
        introComplete
        and quality ~= "Performance"

    setEnabled(shouldEnable)
end


local introConnection =
    playerGui:GetAttributeChangedSignal(
        "NoctelleIntroComplete"
    ):Connect(updateIntroState)


local qualityConnection =
    playerGui:GetAttributeChangedSignal(
        "NoctelleGraphicsQuality"
    ):Connect(updateIntroState)


-- Handles both cases:
-- 1. Controller starts before loading finishes.
-- 2. Controller starts after loading finishes.
updateIntroState()



-- Monitor visibility from the panel up to PlayerGui.
local visibilityConnections: {RBXScriptConnection} = {}

local function refreshBlur()
    if initialized then
        setEnabled(enabled)
    end
end

local current: Instance? = panel

while current and current ~= playerGui do
    if current:IsA("GuiObject") then
        table.insert(
            visibilityConnections,
            current:GetPropertyChangedSignal("Visible")
                :Connect(refreshBlur)
        )
    elseif current:IsA("ScreenGui") then
        table.insert(
            visibilityConnections,
            current:GetPropertyChangedSignal("Enabled")
                :Connect(refreshBlur)
        )
    end

    current = current.Parent
end


local cleaned = false

local function cleanup()
    if cleaned then
        return
    end

    cleaned = true
    enabled = false

    qualityConnection:Disconnect()
    introConnection:Disconnect()
    for _, connection in ipairs(visibilityConnections) do
        connection:Disconnect()
    end

    table.clear(visibilityConnections)

    if blur then
        blur.Destroy()
        blur = nil
    end

    if dof then
        dof:Destroy()
    end

    print("[NOCTELLE ACRYLIC] Cleaned up")
end

panel.Destroying:Connect(cleanup)

print("[NOCTELLE ACRYLIC] Ready - press B after loading")