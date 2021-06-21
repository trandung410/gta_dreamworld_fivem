local speakers = {}

local coords = {}

RegisterServerEvent('esx_kepo_speaker:loadSpeaker')
AddEventHandler('esx_kepo_speaker:loadSpeaker', function(speaker)
    speakers[speaker.speaker] = speaker
    speakers[speaker.speaker].switch = false
    speakers[speaker.speaker].volchange = false
    speakers[speaker.speaker].volval = 100
    speaker.switch = false
    speaker.volchange = false
    speaker.volval = 100
    TriggerClientEvent('esx_kepo_speaker:loadSpeakerClient', -1, speaker)
end)

local id = 0

RegisterServerEvent('esx_kepo_speaker:removeSpeaker')
AddEventHandler('esx_kepo_speaker:removeSpeaker', function(speaker)
    id = id - 1
    TriggerClientEvent("esx_kepo_speaker:removeClient", -1, speaker)
end)


RegisterServerEvent('esx_kepo_speaker:placedSpeaker')
AddEventHandler('esx_kepo_speaker:placedSpeaker', function(spawncoords, speakerid)
    id = id + 1
    local speaker = {}
    speaker.speakerid = speakerid
    speaker.coords = spawncoords
    speaker.speaker = id
    table.insert(speakers, speaker)
    TriggerClientEvent('esx_kepo_speaker:loadSpeakerClient', -1, speaker)
end)

RegisterServerEvent('esx_kepo_speaker:joined')
AddEventHandler('esx_kepo_speaker:joined', function()
    local src = source
    for i=1, #speakers do
        print(speakers[i].coords)
        print(speakers[i].speaker)
        print(speakers[i].volchange)
        print(speakers[i].videoStatus)
        print(speakers[i].time)
    end
    TriggerClientEvent("esx_kepo_speaker:joined", src, speakers)
end)



RegisterServerEvent('esx_kepo_speaker:switchVideo')
AddEventHandler('esx_kepo_speaker:switchVideo', function(id, videoStatus, time)
    local src = source
    TriggerClientEvent("esx_kepo_speaker:switchVideoClient", -1, id, videoStatus, time)
    speakers[id].switch = true
    speakers[id].videoStatus = videoStatus
    speakers[id].time = time - speakers[id].time
end)



RegisterServerEvent('esx_kepo_speaker:changeVol')
AddEventHandler('esx_kepo_speaker:changeVol', function(id, vol)
    local src = source
    speakers[id].volval = vol
    TriggerClientEvent("esx_kepo_speaker:changeVolClient", -1, id, vol)
end)