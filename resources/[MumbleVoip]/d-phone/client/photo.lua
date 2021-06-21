local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

phone = false
phoneId = 0

RegisterNetEvent('camera:phone')
AddEventHandler('camera:phone', function()		
	CreateMobilePhone(1)
	CellCamActivate(true, true)
	phone = true
end)

frontCam = false

function CellFrontCamActivate(activate)
	return Citizen.InvokeNative(0x2491A93618B7D838, activate)
end

-- RemoveLoadingPrompt()

TakePhoto = N_0xa67c35c56eb1bd9d
WasPhotoTaken = N_0x0d6ca79eeebd8ca3
SavePhoto = N_0x3dec726c25a11bac
ClearPhoto = N_0xd801cc02177fa3f1

helpText = function(msg)
    BeginTextCommandDisplayHelp('STRING')
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(0, false, true, -1)
end

Citizen.CreateThread(function()
	DestroyMobilePhone()
	while true do
		Citizen.Wait(0)
		
		if IsControlJustPressed(0, 27) and phone == true then -- SELFIE MODE
			frontCam = not frontCam
			CellFrontCamActivate(frontCam)
		end
		
		if phone == true then
			AddTextEntry(GetCurrentResourceName(), _U("cameracontrol"))
			DisplayHelpTextThisFrame(GetCurrentResourceName(), false)
		end

		if IsControlJustPressed(1, 177) and phone == true then -- CLOSE PHONE
			DestroyMobilePhone()
			phone = false
			CellCamActivate(false, false)
			newPhoneProp()
			DoPhoneAnimation('cellphone_text_in')
			TriggerServerEvent("d-phone:server:getphonedata", GetPlayerServerId(PlayerId()))
		end
		
		if IsControlJustPressed(1, 176) and phone == true then -- TAKE.. PIC
			TakePhoto()
			if (WasPhotoTaken() and SavePhoto(-1)) then
				-- SetLoadingPromptTextEntry("CELL_278")
				-- ShowLoadingPrompt(1)
				ClearPhoto()
			end
		end
			
		if phone == true then
			HideHudComponentThisFrame(7)
			HideHudComponentThisFrame(8)
			HideHudComponentThisFrame(9)
			HideHudComponentThisFrame(6)
			HideHudComponentThisFrame(19)
			HideHudAndRadarThisFrame()
		end
			
		-- ren = GetMobilePhoneRenderId()
		-- SetTextRenderId(ren)
		
		-- Everything rendered inside here will appear on your phone.
		
		-- SetTextRenderId(1) -- NOTE: 1 is default
	end
end)