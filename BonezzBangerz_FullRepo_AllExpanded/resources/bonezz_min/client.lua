-- bonezz_min / client.lua
local QBCore = exports['qb-core']:GetCoreObject()
local activeBlips = {}
local lastMeet = 0

local function clearBlips()
    for _, b in ipairs(activeBlips) do
        if b and DoesBlipExist(b) then RemoveBlip(b) end
    end
    activeBlips = {}
end

local function applyLegendMode(blip)
    if Config.LegendMode == 'hidden' then
        return
    elseif Config.LegendMode == 'grouped' then
        SetBlipCategory(blip, 7)
    end
end

local function createBlip(info, number)
    local blip = AddBlipForCoord(info.x + 0.0, info.y + 0.0, info.z + 0.0)
    SetBlipSprite(blip, info.sprite or 66)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, info.scale or 0.9)
    SetBlipColour(blip, info.colour or 47)
    SetBlipAsShortRange(blip, true)
    SetBlipPriority(blip, 5)
    if number then ShowNumberOnBlip(blip, number) end
    BeginTextCommandSetBlipName("STRING"); AddTextComponentString(info.title or info.code or "UC"); EndTextCommandSetBlipName(blip)
    applyLegendMode(blip)
    table.insert(activeBlips, blip)
end

local function jobAllows(job, onDuty)
    if Config.RequireOnDuty and not onDuty then return false, false end
    return Config.PoliceJobs[job]==true, Config.UndercoverJobs[job]==true
end

local function refreshBlips()
    clearBlips()
    local pd = QBCore.Functions.GetPlayerData()
    if not pd or not pd.job then return end
    local job = pd.job.name; local onDuty = pd.job.onduty==true
    local isLEO, isUC = jobAllows(job, onDuty)
    if isLEO then for _, v in ipairs(Config.LawBlips) do createBlip(v, nil) end end
    if isUC then for i, v in ipairs(Config.UCPoints) do createBlip(v, i) end end
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function() Wait(400); refreshBlips() end)
RegisterNetEvent('QBCore:Client:OnPlayerUnload', function() clearBlips() end)
RegisterNetEvent('QBCore:Client:OnJobUpdate', function() refreshBlips() end)
CreateThread(function() Wait(1200); refreshBlips(); end)

-- Simple safehouse marker & enter action
CreateThread(function()
    while true do
        Wait(0)
        local ped = PlayerPedId()
        local pcoords = GetEntityCoords(ped)
        for i, m in ipairs(Config.SafehouseMarkers) do
            local dist = #(pcoords - vector3(m.x+0.0, m.y+0.0, m.z+0.0))
            if dist < 20.0 then
                DrawMarker(1, m.x, m.y, m.z-1.0, 0,0,0, 0,0,0, 1.2,1.2,0.6, 255,255,255,120, false,true,2,false,nil,nil,false)
            end
            if dist < (Config.MarkerDist or 2.0) then
                SetTextComponentFormat("STRING"); AddTextComponentString("~INPUT_CONTEXT~ Enter Safehouse"); DisplayHelpTextFromStringLabel(0,0,1,-1)
                if IsControlJustPressed(0, 38) then -- E
                    -- Teleport a couple meters forward as a placeholder interior
                    local forward = GetEntityForwardVector(ped)
                    SetEntityCoords(ped, m.x + forward.x*2.0, m.y + forward.y*2.0, m.z + 0.0, false,false,false,true)
                end
            end
        end
    end
end)

-- UC Meet client stub
RegisterNetEvent("bonezz_min:client:doMeetResult", function(result)
    if result == "clean" then
        QBCore.Functions.Notify("Briefing clean. Collect the package.", "success")
    elseif result == "sting" then
        QBCore.Functions.Notify("It was a sting! Lay low.", "error")
    elseif result == "intervention" then
        QBCore.Functions.Notify("Hostiles nearby — stay sharp.", "primary")
    end
end)

-- Trigger meet (client)
RegisterCommand("ucbrief", function()
    local now = GetGameTimer()
    if now - lastMeet < (Config.UCMeetCooldown or 180)*1000 then
        QBCore.Functions.Notify("Briefing cooldown...", "error")
        return
    end
    lastMeet = now
    TriggerServerEvent("bonezz_min:server:requestMeet")
end, false)
