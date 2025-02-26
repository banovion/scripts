--[[
works best if used on awp or wave
nukes pending hubs to ratelimit and ruin events
put in autoexec
DO NOT USE IF UR ON CODEX
--]]

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local PlaceId = game.PlaceId
local JobId = game.JobId

while true do
    local g = Players:GetChildren()
    if #g >= 1 then
        Players.LocalPlayer:Kick("v64")
        wait(1/10)
        TeleportService:Teleport(PlaceId, player)
    else
        TeleportService:TeleportToPlaceInstance(PlaceId, JobId, player)
    end
    
    wait(1) -- any lower and pending hubs wont send your info to the reserve server before you can rejoin
end
