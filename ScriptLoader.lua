-- Script Loader

local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

local gameid = game.GameId
local maingameid = 13770948093

if gameid ~= maingameid then
    local player = Players.LocalPlayer

    local success, err = pcall(function()
        TeleportService:TeleportAsync(maingameid, { player })
    end)

    if not success then
        warn("Teleport failed: " .. tostring(err))
    end
end