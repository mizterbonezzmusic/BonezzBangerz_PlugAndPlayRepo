local QBCore = exports['qb-core']:GetCoreObject()
local function roll()
  local r = math.random()
  if r < (Config.StingChance or 0.25) then return "sting" end
  if r < ((Config.StingChance or 0.25) + (Config.InterventionChance or 0.15)) then return "intervention" end
  return "clean"
end
RegisterNetEvent("corrupt:server:requestMeet", function()
  local src = source
  TriggerClientEvent("corrupt:client:doMeetResult", src, roll())
end)
