local QBCore = exports['qb-core']:GetCoreObject()
local lastMeet = 0
RegisterNetEvent("corrupt:client:doMeetResult", function(r)
  if r=="clean" then QBCore.Functions.Notify("Briefing clean.", "success")
  elseif r=="sting" then QBCore.Functions.Notify("Sting operation! IA heat rising.", "error")
  else QBCore.Functions.Notify("Hostiles intervened.", "primary") end
end)
RegisterCommand("ucbrief", function()
  local now = GetGameTimer()
  if now - lastMeet < (Config.UCMeetCooldown or 180)*1000 then
    QBCore.Functions.Notify("Briefing cooldown...", "error"); return
  end
  lastMeet = now
  TriggerServerEvent("corrupt:server:requestMeet")
end, false)
