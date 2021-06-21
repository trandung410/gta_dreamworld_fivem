Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
			SetWeaponDamageModifier(`weapon_unarmed`, 0.17)
			SetWeaponDamageModifier(`WEAPON_BAT`, 0.17)
			SetWeaponDamageModifier(`WEAPON_MACHETE`, 0.17)
			SetWeaponDamageModifier(`weapon_nightstick`, 0.17)
    end
end)