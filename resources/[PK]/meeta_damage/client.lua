local knockedOut = false
local wait = 15
local count = 60

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local ped = GetPlayerPed(-1)
        for k, v in pairs(Config.Weapon) do
            if GetSelectedPedWeapon(PlayerPedId()) == GetHashKey(v.WeaponName) then

                -- local IsStealth = GetPedStealthMovement(PlayerPedId())
                -- local KillStealth = WasPedKilledByStealth(PlayerPedId())
                -- local PercentKnock = v.Percent_Knockdown

                

                -- if IsStealth then
                --     --N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), 0.0) 
                --     PercentKnock = 100
                    
                -- else
                    
                -- end

                N_0x4757f00bc6323cfe(GetHashKey(v.WeaponName), v.WeaponDamage) 
                -- PercentKnock = v.Percent_Knockdown

                -- local Random = math.random(1, 100)

                -- if Random <= PercentKnock then
                --     if IsPedInMeleeCombat(ped) then
                --         if GetEntityHealth(ped) < 115 then
                --             SetPlayerInvincible(PlayerId(), true)
                --             SetPedToRagdoll(ped, 1000, 1000, 0, 0, 0, 0)
                --             ShowNotification("~r~You were knocked out!")
                --             wait = 15
                --             knockedOut = true
                --             SetEntityHealth(ped, 116)
                --         end
                --     end
                --     if knockedOut == true then
                --         SetPlayerInvincible(PlayerId(), true)
                --         DisablePlayerFiring(PlayerId(), true)
                --         SetPedToRagdoll(ped, 1000, 1000, 0, 0, 0, 0)
                --         ResetPedRagdollTimer(ped)
                        
                --         if wait >= 0 then
                --             count = count - 1
                --             if count == 0 then
                --                 count = 60
                --                 wait = wait - 1
                --             end
                --         else
                --             SetPlayerInvincible(PlayerId(), false)
                --             knockedOut = false
                --         end
                --     end
                -- end

            end
		end
    end
end)

Citizen.CreateThread(function()
	while true do
        Wait(0)
        local ped = GetPlayerPed(-1)
        SetPedStealthMovement(ped, false)
        SetCanAttackFriendly(GetPlayerPed(-1), true, false)
		NetworkSetFriendlyFireOption(true)
        -- if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
        --    DisableControlAction(0, 60, false)
        --else
        --    DisableControlAction(0, 60, true)
        --end

	end
end)

function ShowNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end