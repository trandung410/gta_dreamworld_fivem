RS.ExplosionsMasterSwitch = true
RS.ExplosionsDetection = true -- Detects if a player creates a blacklisted explosion (Due to FiveM's sync that option may not work correctly on all servers)

RS.ExplosionsAntiNuke = true -- Detects if a players creates multiple explosions (BLACKLISTED OR NOT, READ ME!!!) HELLO BANANA BUNGA UNGA, READ THIS <-- BEFORE OPENING A TICKET.!!11111!!1111!
    RS.ExplosionsAntiNukeWarningCount = 7 -- After 7 explosions the player gets warned
    RS.ExplosionsAntiNukeBanCount = 15 -- After 15 explosions the player gets banned
    RS.ExplosionsAntiNukeResetTime = 8000 -- After 8 seconds the AntiNuke gets reseted

LynxBlacklistedExplosions = {
    [0] = { name = "Grenade", detect = true},
    [1] = { name = "GrenadeLauncher", detect = true},
    [3] = { name = "Molotov", detect = true},
    [4] = { name = "Rocket", detect = true},
    [5] = { name = "TankShell", detect = false},
    [6] = { name = "Hi_Octane", detect = false},
    [7] = { name = "Car", detect = false},
    [8] = { name = "Plance", detect = false},
    [9] = { name = "PetrolPump", detect = false},
    [10] = { name = "Bike", detect = false},
    [11] = { name = "Dir_Steam", detect = false},
    [12] = { name = "Dir_Flame", detect = false},
    [13] = { name = "Dir_Water_Hydrant", detect = false},
    [14] = { name = "Dir_Gas_Canister", detect = false},
    [15] = { name = "Boat", detect = false},
    [16] = { name = "Ship_Destroy", detect = false},
    [17] = { name = "Truck", detect = false},
    [18] = { name = "Bullet", detect = false},
    [19] = { name = "SmokeGrenadeLauncher", detect = true},
    [20] = { name = "SmokeGrenade", detect = false},
    [21] = { name = "BZGAS", detect = false},
    [22] = { name = "Flare", detect = false},
    [23] = { name = "Gas_Canister", detect = false},
    [24] = { name = "Extinguisher", detect = false},
    [25] = { name = "Programmablear",detect = false},
    [26] = { name = "Train", detect = false},
    [27] = { name = "Barrel", detect = false},
    [28] = { name = "PROPANE", detect = false},
    [29] = { name = "Blimp", detect = false},
    [30] = { name = "Dir_Flame_Explode", detect = false},
    [31] = { name = "Tanker", detect = false},
    [32] = { name = "PlaneRocket", detect = false},
    [33] = { name = "VehicleBullet", detect = true},
    [34] = { name = "Gas_Tank", detect = false},
    [35] = { name = "FireWork", detect = false},
    [36] = { name = "SnowBall", detect = false},
    [37] = { name = "ProxMine", detect = false},
    [38] = { name = "Valkyrie_Cannon", detect = true}
}
