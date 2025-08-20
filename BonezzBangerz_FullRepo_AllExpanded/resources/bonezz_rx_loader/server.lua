local QBCore = exports['qb-core']:GetCoreObject()

local function info(msg) print(("[bonezz_rx_loader] %s"):format(msg)) end
local function warn(msg) print(("^1[bonezz_rx_loader] %s^7"):format(msg)) end

-- read config
local Overwrite = (Config and Config.Overwrite) or false
local srcRes = (Config and Config.SourceResource) or 'Bonezz_Rx_AllInOne_v3'
local srcFile = (Config and Config.SourceFile) or 'items.lua'

-- Load items.lua text from the source resource
local content = LoadResourceFile(srcRes, srcFile)
if not content or #content == 0 then
    warn(("Could not load %s from %s"):format(srcFile, srcRes))
    return
end

-- sandboxed loader to avoid polluting globals
local env = {
    print = print,
    pairs = pairs,
    ipairs = ipairs,
    tonumber = tonumber,
    tostring = tostring,
    type = type,
    math = math,
    string = string,
    table = table,
    -- allow placing items into this table name:
    BonezzItems = {}
}
local fn, err = load(content, ("@%s/%s"):format(srcRes, srcFile), "t", env)
if not fn then
    warn(("Failed to compile items file: %s"):format(err or "unknown"))
    return
end

local ok, runErr = pcall(fn)
if not ok then
    warn(("Error executing items file: %s"):format(runErr or "unknown"))
    return
end

local srcItems = env.BonezzItems or {}
if type(srcItems) ~= "table" then
    warn("BonezzItems table not found in loaded file")
    return
end

local added, skipped, overwritten = 0, 0, 0
QBCore.Shared = QBCore.Shared or {}
QBCore.Shared.Items = QBCore.Shared.Items or {}

for name, data in pairs(srcItems) do
    if QBCore.Shared.Items[name] ~= nil then
        if Overwrite then
            QBCore.Shared.Items[name] = data
            overwritten = overwritten + 1
        else
            skipped = skipped + 1
        end
    else
        QBCore.Shared.Items[name] = data
        added = added + 1
    end
end

info(("Items merged. added=%d skipped=%d overwritten=%d"):format(added, skipped, overwritten))
