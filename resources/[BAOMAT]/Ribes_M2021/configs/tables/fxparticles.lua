

            --- BEFORE STARTING PLEASE READ THIS MESSAGE
            --[[This file is the FXParticles config, Here you can block or whitelist the Effects you need, The default config uses a Whitelist method... You can switch to Blacklisted and setup the table if you need.]]


RS.FXParticlesMasterSwitch = true
RS.FXParticlesBLOCKALL = false -- ENABLE THIS ONLY IF YOU WANT TO BAN ALL KIND OF FX PARTICLE
RS.FXParticlesMethod = 2 -- 1 FOR BLACKLISTED , 2 FOR WHITELISTED

RS.FXParticlesKick = true
RS.FXParticlesBan = true

FXParticlesEffects = { -- You can get effects from here : https://vespura.com/fivem/particle-list/
    [GetHashKey("scr_indep_firework_starburst")] = { name = "scr_indep_firework_starburst" },
    [GetHashKey("scr_indep_firework_shotburst")] = { name = "scr_indep_firework_shotburst" },
    [GetHashKey("scr_indep_firework_fountain")] = { name = "scr_indep_firework_fountain" },
    [GetHashKey("scr_indep_firework_trailburst")] = { name = "scr_indep_firework_trailburst" },
    [GetHashKey("exp_air_molotov")] = { name = "exp_air_molotov" },
}

