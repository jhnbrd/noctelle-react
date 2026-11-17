--!strict
-- NOCTELLE React | Development Playground Launcher
-- Runs only in the isolated NOCTELLE DEV place.

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

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
else
	warn("[NOCTELLE REACT] Playground failed:", result)
end
