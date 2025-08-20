-- bonezz_min / config.lua
Config = {}

-- Jobs
Config.PoliceJobs = { police=true, sheriff=true, fbi=true }
Config.UndercoverJobs = { uc=true, undercover=true }

-- Show only when on duty?
Config.RequireOnDuty = false

-- Pause-menu legend handling for UC blips: 'hidden' | 'grouped' | 'default'
Config.LegendMode = 'hidden'

-- Law blips
Config.LawBlips = {
    { title='PD HQ (Mission Row)',     colour=29, sprite=60, scale=0.9, x=441.18,  y=-981.14, z=30.69 },
    { title='Sheriff HQ (Sandy)',      colour=29, sprite=60, scale=0.9, x=1855.00, y=3683.00, z=34.20 },
    { title='Sheriff Station (Paleto)',colour=29, sprite=60, scale=0.9, x=-447.10, y=6013.10, z=31.70 },
}

-- UC points (safehouses/outposts)
Config.UCPoints = {
    { code='UC-1', title='UC Safehouse – La Mesa',   colour=47, sprite=66, scale=0.9, x=751.0,   y=-320.0,  z=50.7 },
    { code='UC-2', title='UC Ops Base – North Hills',colour=47, sprite=66, scale=0.9, x=-1100.0, y=4940.0, z=218.0 },
}

-- Safehouse interior markers (same coords by default; set interior coords if different)
Config.SafehouseMarkers = {
    { x=751.0, y=-320.0, z=50.7,   heading=0.0 },
    { x=-1100.0, y=4940.0, z=218.0, heading=0.0 },
}

-- Corrupt Cops Lite
Config.StingChance = 0.25           -- 25% UC meet becomes a sting
Config.InterventionChance = 0.15     -- 15% chance hostile faction intervenes
Config.UCMeetCooldown = 180          -- seconds

-- Interaction distances
Config.MarkerDist = 2.0

-- Target model hash list for interiors (doors/props); optional
Config.SafehouseTargets = {}
