-- bonezz_min / server.lua
local QBCore = exports['qb-core']:GetCoreObject()

local function rollOutcome()
    local r = math.random()
    if r < (Config.StingChance or 0.25) then return "sting" end
    if r < ((Config.StingChance or 0.25) + (Config.InterventionChance or 0.15)) then return "intervention" end
    return "clean"
end

RegisterNetEvent("bonezz_min:server:requestMeet", function()
    local src = source
    local outcome = rollOutcome()
    TriggerClientEvent("bonezz_min:client:doMeetResult", src, outcome)
end)
