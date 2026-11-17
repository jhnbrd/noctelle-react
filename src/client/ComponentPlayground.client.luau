--!strict
-- NOCTELLE React | Development Playground Launcher
-- Runs only in the isolated NOCTELLE DEV place.

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local TweenService = game:GetService("TweenService")

local DEV_PLACE_ID = 119625856408570

-- Do not activate in production or non-client contexts.
if not RunService:IsClient() or game.PlaceId ~= DEV_PLACE_ID then
	return
end

local player = Players.LocalPlayer
if not player then
	return
end

local playerGui = player:WaitForChild("PlayerGui")

local dev = ReplicatedStorage:WaitForChild("NoctelleReactDev")
local playgroundFolder = dev:WaitForChild("Playground")

local success, result = pcall(function()
	local Playground = require(playgroundFolder:WaitForChild("ComponentPlayground"))

	return Playground.Mount(playerGui)
end)


if success then
    print("[NOCTELLE REACT] Component playground launched")

    -- Animation is owned by the client launcher,
    -- never by React's render function.
    task.spawn(function()
        local gui = playerGui:WaitForChild(
            "NoctelleComponentPlayground", 10
        )
        if not gui then return end

        local panel = gui:WaitForChild("PlaygroundPanel", 10)
        if not panel then
            warn("[NOCTELLE] Glass panel not found")
            return
        end

        local stroke = panel:WaitForChild(
            "AnimatedBorderStroke", 10
        )
        if not stroke then
            warn("[NOCTELLE] Animated stroke not found")
            return
        end

        local gradient = stroke:WaitForChild(
            "OrbitGradient", 10
        )
        if not gradient then
            warn("[NOCTELLE] Orbit gradient not found")
            return
        end

        local tween = TweenService:Create(
            gradient,
            TweenInfo.new(
                5,
                Enum.EasingStyle.Linear,
                Enum.EasingDirection.InOut,
                -1,
                false
            ),
            { Rotation = 360 }
        )

        local destroyedConnection
        destroyedConnection = gradient.Destroying:Connect(function()
            tween:Cancel()
            destroyedConnection:Disconnect()
        end)

        tween:Play()
        print("[NOCTELLE] Animated glass border started")
    end)
else
    warn("[NOCTELLE REACT] Playground failed:", result)
end

