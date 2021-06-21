RegisterServerEvent("nbk_cstyle_killfeed:SyncPlayerDead")
AddEventHandler('nbk_cstyle_killfeed:SyncPlayerDead',function(attackerid, weaponHash,isplayer,bonehash,distance) --victim,attacker,victimDied,weaponHash,isMeleeDamage,vehicleDamageTypeFlag
    local _source = source
    local playername = GetPlayerName(_source)
    local attackername = isplayer and GetPlayerName(attackerid) or tostring(attackerid)
    
    TriggerClientEvent('nbk_cstyle_killfeed:OnPlayerDead',-1,attackername, weaponHash,playername,bonehash,distance,attackerisplayer,attackerid,_source)

   
end )