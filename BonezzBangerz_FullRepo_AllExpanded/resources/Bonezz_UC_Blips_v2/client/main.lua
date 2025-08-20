-- Bonezz_UC_Blips_v2 / client/main.lua
local QBCore = exports['qb-core']:GetCoreObject()

local activeBlips = {}

local function clearBlips()
    for _, b in ipairs(activeBlips) do
        if b and DoesBlipExist(b) then RemoveBlip(b) end
    end
    activeBlips = {}
end

-- Optional legend/group handling
local function applyLegendMode(blip)
    if Config.LegendMode == 'hidden' then
        -- Do NOT set a category; short-range map/minimap only
        return
    elseif Config.LegendMode == 'grouped' then
        -- Group under a custom category; fewer items in right-side list
        -- 7 is a generic category; using native SetBlipCategory
        SetBlipCategory(blip, 7)
    else
        -- default: do nothing
    end
end

local function createBlip(info, number)
    local blip = AddBlipForCoord(info.x + 0.0, info.y + 0.0, info.z + 0.0)
    SetBlipSprite(blip, info.sprite or 66)
    SetBlipDisplay(blip, 4)           -- map & minimap
    SetBlipScale(blip, info.scale or 0.9)
    SetBlipColour(blip, info.colour or 47)
    SetBlipAsShortRange(blip, true)    -- prevents global clutter
    SetBlipPriority(blip, 5)           -- draw above generic POIs

    -- Show numeric label on the blip pin
    if number then
        ShowNumberOnBlip(blip, number) -- 1..99
    end

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(info.title or (info.code or "UC"))
    EndTextCommandSetBlipName(blip)

    applyLegendMode(blip)
    table.insert(activeBlips, blip)
end

local function jobAllowsBlips(jobName, onDuty)
    if Config.RequireOnDuty and not onDuty then
        return false, false
    end
    local isLEO = Config.PoliceJobs[jobName] == true
    local isUC  = Config.UndercoverJobs[jobName] == true
    return isLEO, isUC
end

local function refreshBlips()
    clearBlips()
    local pdata = QBCore.Functions.GetPlayerData()
    if not pdata or not pdata.job then return end
    local jobName = pdata.job.name
    local onDuty = pdata.job.onduty == true

    local isLEO, isUC = jobAllowsBlips(jobName, onDuty)
    if isLEO then
        for _, info in ipairs(Config.LawBlips) do
            createBlip(info, nil)
        end
    end
    if isUC then
        for i, info in ipairs(Config.UCBlips) do
            -- If a code like "UC-5" exists, we still number sequentially on the pin
            createBlip(info, i)
        end
    end
end

-- Events
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function() Wait(400); refreshBlips() end)
RegisterNetEvent('QBCore:Client:OnPlayerUnload', function() clearBlips() end)
RegisterNetEvent('QBCore:Client:OnJobUpdate', function() refreshBlips() end)

-- Fallback
CreateThread(function()
    Wait(1200)
    refreshBlips()
end)
