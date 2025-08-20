-- Bonezz_UC_Blips_v2 / config.lua
-- Jobs that should see Law Enforcement blips
Config = {}

Config.PoliceJobs = { police = true, sheriff = true, fbi = true }
Config.UndercoverJobs = { uc = true, undercover = true }

-- Hide UC blips from the pause-menu "legend" list?
--   'hidden'   -> never added to legend (prevents right-side overlap)
--   'grouped'  -> group under a custom category (reduced clutter)
--   'default'  -> normal behavior
Config.LegendMode = 'hidden'

-- Law Enforcement blips (unchanged)
Config.LawBlips = {
    { title='PD HQ (Mission Row)', colour=29, sprite=60, scale=0.9, x=441.18,  y=-981.14, z=30.69 },
    { title='Sheriff HQ (Sandy Shores)', colour=29, sprite=60, scale=0.9, x=1855.00, y=3683.00, z=34.20 },
    { title='Sheriff Station (Paleto)', colour=29, sprite=60, scale=0.9, x=-447.10, y=6013.10, z=31.70 },
}

-- Undercover safehouses/outposts. Each gets a sequential code & number on blip.
Config.UCBlips = {
    { code='UC-1', title='UC Safehouse – La Mesa',  colour=47, sprite=66, scale=0.9, x=751.0,   y=-320.0,  z=50.7 },
    { code='UC-2', title='UC Ops Base – North Hills', colour=47, sprite=66, scale=0.9, x=-1100.0, y=4940.0, z=218.0 },
    -- add more as needed:
    -- { code='UC-3', title='UC Depot – Docks', colour=47, sprite=66, scale=0.9, x=..., y=..., z=... },
}

-- Only show when on duty?
Config.RequireOnDuty = false
