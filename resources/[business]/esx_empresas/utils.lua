RegisterNetEvent("Notify")
AddEventHandler("Notify", function(type,msg)
    -- Você pode mudar a notificação como desejar
	if type == "negado" then
		prefix = "~r~"
    elseif type == "importante" then
		prefix = "~y~"
    elseif type == "sucesso" then
        prefix = "~g~"
    end
	SetNotificationTextEntry("STRING")
	AddTextComponentString(prefix..msg)
	DrawNotification(false, false)
end)

function DrawText3D2(x, y, z, text, scale)
	if text then
		local onScreen, _x, _y = World3dToScreen2d(x, y, z)
		local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
		SetTextScale(scale, scale) SetTextFont(4)
		SetTextProportional(1)
		SetTextEntry("STRING")
		SetTextCentre(true)
		SetTextColour(255, 255, 255, 215) AddTextComponentString(text)
		DrawText(_x, _y)
		local factor = (string.len(text)) / 700
		DrawRect(_x, _y + 0.0150, 0.095 + factor, 0.03, 41, 11, 41, 100)
	end
end