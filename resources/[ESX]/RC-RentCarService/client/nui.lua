


local display = false
local isShopOpen = false
local currentVehicle = ""
local currentPrice = 0
local playerHasBoughtVeh = false




Citizen.CreateThread(function()
	while true do
		local coords = GetEntityCoords(PlayerPedId())

		Citizen.Wait(0)
		local distance2 = GetDistanceBetweenCoords(coords, -253.76750183105, -986.41351318359, 31.220006942749, true)
		


		if distance2 <= 1 then
			if isShopOpen == false then

				SetDisplay(not display)
				isShopOpen = true
			end
			
		end
			
	
	end
end)



--very important cb 
RegisterNUICallback("exit", function(data)
    isShopOpen = false
    SetDisplay(false)
end)

-- this cb is used as the main route to transfer data back 
-- and also where we hanld the data sent from js
RegisterNUICallback("main", function(data)
    chat(data.text, {0,255,0})
    SetDisplay(false)
end)

RegisterNUICallback("error", function(data)
    chat(data.error, {255,0,0})
    SetDisplay(false)
end)

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end




RegisterNetEvent("rc-rentCar:changeStautus")
AddEventHandler("rc-rentCar:changeStautus", function(playerHasBoughtVehNew)
 
    playerHasBoughtVeh = playerHasBoughtVehNew
end)

RegisterNetEvent("rc-rentCar:noMoney")
AddEventHandler("rc-rentCar:noMoney", function()
 
    ESX.ShowNotification("~r~Nicht genügen Geld dabei!")
end)


RegisterNUICallback("askAccept", function(data)
    print(currentVehicle)
    playerHasBoughtVeh = true
    TriggerServerEvent("rc-rentCar:TriggerCarSpawn",currentVehicle, playerHasBoughtVeh, currentPrice)
    isShopOpen = false
    SetDisplay(false)
    PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", 1)
end)








RegisterNUICallback("slot1SportSelected", function(data)
    currentVehicle = Config.Cars.slot1Sport   
    currentPrice = Config.Cars.slot1SportPrice
end)

RegisterNUICallback("slot2SportSelected", function(data)
    currentVehicle = Config.Cars.slot2Sport
    currentPrice = Config.Cars.slot2SportPrice   
end)






RegisterNUICallback("slot1ClassicSelected", function(data)
    currentVehicle = Config.Cars.slot1Classic  
    currentPrice = Config.Cars.slot1ClassicPrice 
end)
RegisterNUICallback("slot2ClassicSelected", function(data)
    currentVehicle = Config.Cars.slot2Classic 
    currentPrice = Config.Cars.slot2ClassicPrice   
end)



RegisterNUICallback("slot1MotorcycleSelected", function(data)
    currentVehicle = Config.Cars.slot1Motorcycle   
    currentPrice = Config.Cars.slot1MotorcyclePrice  
end)
RegisterNUICallback("slot2MotorcycleSelected", function(data)
    currentVehicle = Config.Cars.slot2Motorcycle
    currentPrice = Config.Cars.slot2MotorcyclePrice     
end)













Citizen.CreateThread(function()
    while display do
        Citizen.Wait(0)
        -- https://runtime.fivem.net/doc/natives/#_0xFE99B66D079CF6BC
        --[[ 
            inputGroup -- integer , 
	        control --integer , 
            disable -- boolean 
        ]]
        DisableControlAction(0, 1, display) -- LookLeftRight
        DisableControlAction(0, 2, display) -- LookUpDown
        DisableControlAction(0, 142, display) -- MeleeAttackAlternate
        DisableControlAction(0, 18, display) -- Enter
        DisableControlAction(0, 322, display) -- ESC
        DisableControlAction(0, 106, display) -- VehicleMouseControlOverride
    end
end)

function chat(str, color)
    TriggerEvent(
        'chat:addMessage',
        {
            color = color,
            multiline = true,
            args = {str}
        }
    )
end