-----------------------------

-- Youtube : Sam อะไรgunnnee --

-----------------------------
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local communityname = "GLX LOGS"
local communtiylogo = "https://i.imgur.com/9NRAzos.png" --Must end with .png or .jpg

--Send the message to your discord server
function sendToDiscord (name,message,color)
  local DiscordWebHook = Config.webhook
  -- Modify here your discordWebHook username = name, content = message,embeds = embeds

local embeds = {
    {
        ["title"]=message,
        ["type"]="rich",
        ["color"] =color,
        ["footer"]=  {
            --["text"]= "ESX-discord_bot_alert",
       },
    }
}

  if message == nil or message == '' then return FALSE end
  PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function sendToDiscord_all (name,message,description,color,DiscordWebHook)
  --local DiscordWebHook = Config.webhook
  -- Modify here your discordWebHook username = name, content = message,embeds = embeds

local embeds = {
    {
        ["title"]=message,
        ["type"]="rich",
		["color"] =color,
		["description"] = description,
		["footer"] = {
			["text"] = communityname,
			["icon_url"] = communtiylogo,
       },
    }
}

  if message == nil or message == "Player Log #1" then return FALSE end
  PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

-- Send the first notification
sendToDiscord(_U('server'),_U('server_start'),Config.green)

RegisterServerEvent("new_GTX:removemoney")
AddEventHandler("new_GTX:removemoney", function(name, itemName, itemCount, type)
	local date = os.date('*t')

	if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
	if date.min < 10 then date.min = '0' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end

	if type == 'item_money' then

		sendToDiscord_all("Drop Log 🌐 "," Drop Money ", "Người chơi: **" ..name .. "** đã vứt tiền   \nChi tiết \n Loại tiền: " .. itemName .. " \nSố lượng: " .. itemCount .. "\n Thời gian : "..date.hour..":"..date.min..":"..date.sec.."", Config.green, Config.webhook_re_money)

		--sendToDiscord_all("ทิ้งเงิน", name .. " ทิ้งเงิน " .. itemName .. " Số lượng " .. itemCount, Config.green, Config.webhook_re_money)
	elseif type == 'item_account' then

		sendToDiscord_all("Drop Log 🌐 "," Drop Black Money ", "Người chơi: **" ..name .. "** đã vứt tiền   \nChi tiết \n Loại tiền: " .. itemName .. " \nSố lượng: " .. itemCount .. "\n Thời gian : "..date.hour..":"..date.min..":"..date.sec.."", Config.red, Config.webhook_re_money)

		--sendToDiscord_all("ทิ้งเงิน", name .. " ทิ้งเงิน " .. itemName .. " Số lượng " .. itemCount, Config.red, Config.webhook_re_money)
	end
end)

RegisterServerEvent("new_GTX:removeitem")
AddEventHandler("new_GTX:removeitem", function(name, itemName, itemCount, type)
	local date = os.date('*t')

	if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
	if date.min < 10 then date.min = '0' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end

	if type == 'item_weapon' then

		sendToDiscord_all("Drop Log 🌐 "," Drop Weapon ", "Người chơi: **" ..name .. "** đã vứt weapon   \nChi tiết \nTên weapon: " .. itemName .. " \nSố lượng: " .. itemCount .. "\n Thời gian : "..date.hour..":"..date.min..":"..date.sec.."", Config.red, Config.webhook_gi_weapon)

		--sendToDiscord_all("ทิ้งอาวุธ", name .. " ทิ้งอาวุธ " .. itemName .. " Số lượng " .. itemCount, Config.orange, Config.webhook_re_item)
	elseif type == 'item_standard' then

		sendToDiscord_all("Drop Log 🌐 "," Drop Item ", "Người chơi: **" ..name .. "** đã vứt item   \nChi tiết \nTên item: " .. itemName .. " \nSố lượng: " .. itemCount .. "\n Thời gian : "..date.hour..":"..date.min..":"..date.sec.."", Config.red, Config.webhook_re_item)

		--sendToDiscord_all("ทิ้งไอเทม", name .. " ทิ้งไอเทม " .. itemName .. " Số lượng " .. itemCount, Config.blue, Config.webhook_re_item)
	end
end)

RegisterServerEvent("new_GTX:Pickup")
AddEventHandler("new_GTX:Pickup", function(name, itemName, itemCount, type)
	local date = os.date('*t')

	if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
	if date.min < 10 then date.min = '0' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end

	if type == 'item_standard' then

		sendToDiscord_all("Pick Up Log 🌐 "," PickUp Item ", "Người chơi: **" ..name .. "** đã nhặt   \nChi tiết \n Tên item: " .. itemName .. " \nSố lượng: " .. itemCount .. "\n Thời gian : "..date.hour..":"..date.min..":"..date.sec.."", Config.blue, Config.webhook_Pickup)

		--sendToDiscord_all("เก็บไอเทมจากพื้น", name .. " เก็บไอเทม " .. itemName .. " Số lượng " .. itemCount, Config.blue, Config.webhook_Pickup)
	elseif type == 'item_money' then

		sendToDiscord_all("Getitem Log 🌐 "," PickUp Money ", "Người chơi: **" ..name .. "** đã nhặt   \nChi tiết \n Loại tiền: " .. itemName .. " \nSố lượng: " .. itemCount .. "\n Thời gian : "..date.hour..":"..date.min..":"..date.sec.."", Config.green, Config.webhook_Pickup)

		--sendToDiscord_all("เก็บเงินจากพื้น", name .. " เก็บเงิน " .. itemName .. " Số lượng " .. itemCount, Config.green, Config.webhook_Pickup)
	elseif type == 'item_account' then

		sendToDiscord_all("Getitem Log 🌐 "," PickUp Black Money ", "Người chơi: **" ..name .. "** đã nhặt   \nChi tiết \n Loại tiền: " .. itemName .. " \nSố lượng: " .. itemCount .. "\n Thời gian : "..date.hour..":"..date.min..":"..date.sec.."", Config.red, Config.webhook_Pickup)

		--sendToDiscord_all("เก็บเงินแดงจากพื้น", name .. " เก็บเงินแดง " .. itemName .. " Số lượng " .. itemCount, Config.red, Config.webhook_Pickup)
	end
end)

RegisterServerEvent("discordbot:add2cars_sv")
AddEventHandler("discordbot:add2cars_sv", function(name, itemName, itemCount, type)
	--print('Show Discord')
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(itemName)
	local steamhex = GetPlayerIdentifier(source)
	local date = os.date('*t')

	if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
	if date.min < 10 then date.min = '0' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end

	if type == 'item_standard' then

		sendToDiscord_all("Recar Log 🌐 "," ข้อมูลการเก็บไอเท็มเข้ารถ ", "Người chơi **" ..xPlayer.name .. "** เก็บไอเท็มเข้ารถ   \nChi tiết \nรถทะเบียน : " .. name .. " \nไอเท็ม : " .. itemName .. " \nSố lượng : " .. itemCount .. " ชิ้น \n Steam Hex : "..steamhex.."\n Thời gian : "..date.hour..":"..date.min..":"..date.sec.."", Config.blue, Config.webhook_add2caritem)


	elseif type == 'item_weapon' then

		sendToDiscord_all("Recar Log 🌐 "," ข้อมูลการเก็บอาวุธเข้ารถ ", "Người chơi: **" ..xPlayer.name .. "** เก็บอาวุธเข้ารถ   \nChi tiết \nรถทะเบียน: " .. name .. " \nอาวุธ: " .. itemName .. " \nSố lượng: " .. itemCount .. " ชิ้น \n Steam Hex: "..steamhex.."\n Thời gian : "..date.hour..":"..date.min..":"..date.sec.."", Config.orange, Config.webhook_addweapon2car)


	elseif type == 'item_account' then

		sendToDiscord_all("Recar Log 🌐 "," ข้อมูลการนำเงินแดงเข้ารถ ", "Người chơi: **" ..xPlayer.name .. "** นำเงินแดงเข้ารถ   \nChi tiết \nรถทะเบียน: " .. name .. " \n Loại tiền: " .. itemName .. " \nSố lượng: " .. itemCount .. " 💲 \n Steam Hex: "..steamhex.."\n Thời gian : "..date.hour..":"..date.min..":"..date.sec.."", Config.red, Config.webhook_add2carmoney)

	else

		sendToDiscord_all("Recar Log 🌐 "," ข้อมูลการนำเงินเขียวเข้ารถ ", "Người chơi: **" ..xPlayer.name .. "** นำเงินเขียวเข้ารถ   \nChi tiết \nรถทะเบียน: " .. name .. " \n Loại tiền: " .. itemName .. " \nSố lượng: " .. itemCount .. " 💲 \n Steam Hex: "..steamhex.."\n Thời gian : "..date.hour..":"..date.min..":"..date.sec.."", Config.green, Config.webhook_add2carmoney)
	end
end)

RegisterServerEvent("discordbot:re2cars_sv")
AddEventHandler("discordbot:re2cars_sv", function(name, itemName, itemCount, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(itemName)
	local steamhex = GetPlayerIdentifier(source)
	local date = os.date('*t')

	if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
	if date.min < 10 then date.min = '0' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end
	
	if type == 'item_standard' then
		sendToDiscord_all("Addcar Log 🌐 "," ข้อมูลการนำไอเท็มออกจากรถ ", "Người chơi: **" ..xPlayer.name .. "** นำไอเท็มออกจากรถ   \nChi tiết \nรถทะเบียน: " .. name .. " \nไอเท็ม: " .. itemName .. " \nSố lượng: " .. itemCount .. " ชิ้น \n Steam Hex: "..steamhex.."\n Thời gian : "..date.hour..":"..date.min..":"..date.sec.."", Config.blue, Config.webhook_re2caritem)
	elseif type == 'item_weapon' then
		sendToDiscord_all("Addcar Log 🌐 "," ข้อมูลการนำอาวุธออกจากรถ ", "Người chơi: **" ..xPlayer.name .. "** นำอาวุธออกจากรถ   \nChi tiết \nรถทะเบียน: " .. name .. " \nอาวุธ: " .. itemName .. " \nSố lượng: " .. itemCount .. " ชิ้น \n Steam Hex: "..steamhex.."\n Thời gian : "..date.hour..":"..date.min..":"..date.sec.."", Config.orange, Config.webhook_reweapon2car)
	elseif type == 'item_account' then
		sendToDiscord_all("Addcar Log 🌐 "," ข้อมูลการนำเงินแดงออกจากรถ ", "Người chơi: **" ..xPlayer.name .. "** นำเงินแดงออกจากรถ   \nChi tiết \nรถทะเบียน: " .. name .. " \n Loại tiền: " .. itemName .. " \nSố lượng: " .. itemCount .. " 💲 \n Steam Hex: "..steamhex.."\n Thời gian : "..date.hour..":"..date.min..":"..date.sec.."", Config.red, Config.webhook_re2carmoney)
	else
		sendToDiscord_all("Addcar Log 🌐 "," ข้อมูลการนำเงินเขียวออกจากรถ ", "Người chơi: **" ..xPlayer.name .. "** นำเงินเขียวออกจากรถ   \nChi tiết \nรถทะเบียน: " .. name .. " \n Loại tiền: " .. itemName .. " \nSố lượng: " .. itemCount .. " 💲 \n Steam Hex: "..steamhex.."\n Thời gian : "..date.hour..":"..date.min..":"..date.sec.."", Config.green, Config.webhook_re2carmoney)
	end
end)

-- Add event when a player give an item

RegisterServerEvent("esx:giveitemalert")
AddEventHandler("esx:giveitemalert", function(name,nametarget,itemname,amount)
	local date = os.date('*t')

	if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
	if date.min < 10 then date.min = '0' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end

   if(settings.LogItemTransfer)then

	sendToDiscord_all("Giveitem Log 🌐 "," Transfer item", "Người chơi: **" ..name .. "** đã đưa item   \nChi tiết \n Người nhận: " .. nametarget .. " \nTên item: " .. itemname .. " \nSố lượng: " .. amount .. "\n Thời gian : "..date.hour..":"..date.min..":"..date.sec.."", Config.orange, Config.webhook_gi_item)

    --sendToDiscord_all(_U('server_item_transfer'), name.._('user_gives_to')..nametarget.." "..amount .." "..itemname, Config.orange, Config.webhook_gi_item)
   end
end)
RegisterServerEvent("esx:TichThuItem")
AddEventHandler("esx:TichThuItem", function(name,nametarget,itemname,amount)
	local date = os.date('*t')

	if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
	if date.min < 10 then date.min = '0' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end

   if(settings.LogItemTransfer)then

	sendToDiscord_all("Police Log 🌐 ","ITEM", "Cảnh sát: **" ..name .. "** đã tịch thu   \nChi tiết \n Mục tiêu: " .. nametarget .. " \nTên item: " .. itemname .. " \nSố lượng: " .. amount .. "\n Thời gian : "..date.hour..":"..date.min..":"..date.sec.."", Config.orange, Config.webhook_CS)
   end
end)
RegisterServerEvent("esx:TichThuTien")
AddEventHandler("esx:TichThuTien", function(name,nametarget,itemname,amount)
	local date = os.date('*t')

	if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
	if date.min < 10 then date.min = '0' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end

   if(settings.LogItemTransfer)then

	sendToDiscord_all("Police Log 🌐 ","💷 TIỀN BẨN:", "Cảnh sát: **" ..name .. "** đã tịch thu   \nChi tiết \n Mục tiêu: " .. nametarget .. " \nTiền: " .. itemname .. " \nSố lượng: " .. amount .. "\n Thời gian : "..date.hour..":"..date.min..":"..date.sec.."", Config.orange, Config.webhook_CS)
   end
end)
RegisterServerEvent("esx:TichThuVK")
AddEventHandler("esx:TichThuVK", function(name,nametarget,itemname,amount)
	local date = os.date('*t')

	if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
	if date.min < 10 then date.min = '0' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end

   if(settings.LogItemTransfer)then

	sendToDiscord_all("Police Log 🌐 ","🔫 VŨ KHÍ:", "Cảnh sát: **" ..name .. "** đã tịch thu   \nChi tiết \n Mục tiêu: " .. nametarget .. " \n Tên: " .. itemname .. "\n Thời gian : "..date.hour..":"..date.min..":"..date.sec.."", Config.orange, Config.webhook_CS)
   end
end)
-- Add event when a player give money

RegisterServerEvent("esx:givemoneyalert")
AddEventHandler("esx:givemoneyalert", function(name,nametarget,amount)
	local date = os.date('*t')

	if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
	if date.min < 10 then date.min = '0' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end

  if(settings.LogMoneyTransfer)then

	sendToDiscord_all("Money Log 🌐 "," Transfer Money", "Người chơi: **" ..name .. "** chuyển tiền   \nChi tiết \nNgười nhận tiền: " .. nametarget .. " \nSố lượng: " .. amount .. "\n Thời gian : "..date.hour..":"..date.min..":"..date.sec.."", Config.orange, Config.webhook_gi_money)

    --sendToDiscord_all(_U('server_money_transfer'), name.." ".._('user_gives_to').." "..nametarget.." "..amount .." dollars", Config.orange, Config.webhook_gi_money)
  end

end)

-- Add event when a player give money

RegisterServerEvent("esx:givemoneybankalert")
AddEventHandler("esx:givemoneybankalert", function(name,nametarget,amount)
	local date = os.date('*t')

	if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
	if date.min < 10 then date.min = '0' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end

  if(settings.LogMoneyBankTransfert)then

	sendToDiscord_all("Money Log 🌐 "," Transfer Black Money ", "Người chơi: **" ..name .. "** chuyển tiền   \nChi tiết \nNgười nhận tiền: " .. nametarget .. " \nSố lượng: " .. amount .. "\n Thời gian : "..date.hour..":"..date.min..":"..date.sec.."", Config.orange, Config.webhook_gi_money)


   --sendToDiscord_all(_U('server_moneybank_transfer'), name.." ".. _('user_gives_to') .." "..nametarget.." "..amount .." dollars", Config.orange, Config.webhook_gi_money)
  end

end)


-- Add event when a player give weapon

RegisterServerEvent("esx:giveweaponalert")
AddEventHandler("esx:giveweaponalert", function(name,nametarget,weaponlabel)
	local date = os.date('*t')

	if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
	if date.min < 10 then date.min = '0' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end

  if(settings.LogWeaponTransfer)then

	sendToDiscord_all("Give Log 🌐 "," Thông tin chuyển súng ", "Người chơi: **" ..name .. "** đã chuyển vũ khí    \nChi tiết \nNgười nhận: " ..nametarget.. " \nSúng: " ..weaponlabel .. "\n Thời gian : "..date.hour..":"..date.min..":"..date.sec.."", Config.orange, Config.webhook_gi_weapon)

    --sendToDiscord_all(_U('server_weapon_transfer'), name.." ".._('user_gives_to').." "..nametarget.." "..weaponlabel, Config.orange, Config.webhook_gi_item)
  end

end)

RegisterServerEvent("discordbot:buycar_sv")
AddEventHandler("discordbot:buycar_sv", function(name, price, player)
	local xPlayer = ESX.GetPlayerFromId(source)
	local steamhex = GetPlayerIdentifier(source)
	local date = os.date('*t')

	if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
	if date.min < 10 then date.min = '0' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end

	sendToDiscord_all("Buycar Log 🌐 "," Thông tin mua xe ", "Người chơi: **" ..xPlayer.name .. "** Mua xe   \nChi tiết \nMô hình xe hơi: " .. name .. " \ngiá bán: " .. price .. " $ \n Steam Hex: "..steamhex.."\n Thời gian : "..date.hour..":"..date.min..":"..date.sec.."", Config.green, Config.webhook_buycar)

end)

RegisterServerEvent("discordbot:selldrugs_sv")
AddEventHandler("discordbot:selldrugs_sv", function(drugType, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local steamhex = GetPlayerIdentifier(source)
	local date = os.date('*t')

	if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
	if date.min < 10 then date.min = '0' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end

	sendToDiscord_all("Selldrung Log 🌐 "," Dữ liệu bán hàng bất hợp pháp ", "Người chơi: **" ..xPlayer.name .. "** Bán hàng bất hợp pháp   \nChi tiết \nĐịnh dạng mặt hàng: " .. drugType .. " \nSố lượng: " .. count .. " cái \n Steam Hex: "..steamhex.."\n Thời gian : "..date.hour..":"..date.min..":"..date.sec.."", Config.orange, Config.webhook_selldrugs)

--		sendToDiscord_all("ผู้เล่นชื่อ ", xPlayer.name .. " ทำการขายยา " .. drugType .. " ให้กับ NPC Số lượng " .. count .. " ชิ้น", Config.orange, Config.webhook_selldrugs)
end)

RegisterServerEvent("discordbot:transfermoney_sv")
AddEventHandler("discordbot:transfermoney_sv", function(redmoney, greenmoney)
	local xPlayer = ESX.GetPlayerFromId(source)
	local steamhex = GetPlayerIdentifier(source)
	local date = os.date('*t')

	if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
	if date.min < 10 then date.min = '0' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end

	--local xItem = xPlayer.getInventoryItem(itemName)
	sendToDiscord_all("Log Server 🌐 "," ข้อมูลการแลกเปลี่ยนเงินแดง ", "Người chơi: **" ..xPlayer.name .. "** Đổi tiền đỏ   \nChi tiết: " .. redmoney .. " 🔜 " .. greenmoney .. "💵  \n Steam Hex: "..steamhex.."\n Thời gian : "..date.hour..":"..date.min..":"..date.sec.."", Config.green, Config.webhook_transfer_money)

end)

RegisterServerEvent("discordbot:crafting_sv")
AddEventHandler("discordbot:crafting_sv", function(item, amount, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	local steamhex = GetPlayerIdentifier(source)
	local date = os.date('*t')

	if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
	if date.min < 10 then date.min = '0' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end

	--local xItem = xPlayer.getInventoryItem(itemName)
	if type then
		sendToDiscord_all("Crafting log 🌐 ","✅ Soạn thảo thông tin ", "Người chơi: **" ..xPlayer.name .. "** Nhấn một mục vào ✅  \nTên mục: " .. item .. " Số lượng ( " .. amount .. " ) \n Steam Hex: "..steamhex.."\n Thời gian : "..date.hour..":"..date.min..":"..date.sec.."", Config.green, Config.webhook_crafting)
	else
		sendToDiscord_all("Crafting log 🌐 ","❌ Thông tin chế tạo vật phẩm bị hỏng. ", "Người chơi: **" ..xPlayer.name .. "** Đánh một mục ❌  \nTên mặt hàng: " .. item .. " Số lượng ( " .. amount .. " ) \n Steam Hex: "..steamhex.."\n Thời gian : "..date.hour..":"..date.min..":"..date.sec.."", Config.red, Config.webhook_crafting)
	end
end)

----------------------------------------------      Yoz Add ons     ------------------------------------------------


RegisterServerEvent("discordbot:delcargarage_sv")
AddEventHandler("discordbot:delcargarage_sv", function(plate)
	local xPlayer = ESX.GetPlayerFromId(source)
	local steamhex = GetPlayerIdentifier(source)
	local date = os.date('*t')

	if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
	if date.min < 10 then date.min = '0' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end

	sendToDiscord_all("Garage Log 🌐 "," ข้อมูลการเก็บรถ ", "Người chơi: **" ..xPlayer.name .. "** Giữ xe   \nChi tiết \nBiển số xe: " .. plate .. " \ntrạng thái : Vào nhà để xe \n Steam Hex: "..steamhex.."\n Thời gian : "..date.hour..":"..date.min..":"..date.sec.."", Config.red, Config.webhook_delcar_garage)


end)

RegisterServerEvent("discordbot:addcargarage_sv")
AddEventHandler("discordbot:addcargarage_sv", function(plate)
	local xPlayer = ESX.GetPlayerFromId(source)
	local steamhex = GetPlayerIdentifier(source)
	local date = os.date('*t')

	if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
	if date.min < 10 then date.min = '0' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end

	sendToDiscord_all("Garage Log 🌐 "," Thông tin về chuyến đi ", "Người chơi: **" ..xPlayer.name .. "** Yêu cầu   \nChi tiết \nBiển số xe: " .. plate .. " \ntrạng thái : Ra khỏi nhà để xe \n Steam Hex: "..steamhex.."\n Thời gian : "..date.hour..":"..date.min..":"..date.sec.."", Config.blue, Config.webhook_addcar_garage)

end)

RegisterServerEvent("discordbot:poundcargarage_sv")
AddEventHandler("discordbot:poundcargarage_sv", function(plate)
	local xPlayer = ESX.GetPlayerFromId(source)
	local steamhex = GetPlayerIdentifier(source)
	local date = os.date('*t')

	if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
	if date.min < 10 then date.min = '0' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end

	sendToDiscord_all("Garage Log 🌐 "," ข้อมูลการกู้คืนรถ ", "Người chơi: **" ..xPlayer.name .. "** ทำการกู้คืนรถ   \nChi tiết \nป้ายทะเบียน: " .. plate .. "\nสถานะ : พาวท์ \n Steam Hex: "..steamhex.."\n Thời gian : "..date.hour..":"..date.min..":"..date.sec.."", Config.orange, Config.webhook_addcar_pound)

end)

-- Event when a player is writing
AddEventHandler('chatMessage', function(author, color, message)
  	if(settings.LogChatServer)then
	  local player = ESX.GetPlayerFromId(author)
	  local date = os.date('*t')

	  if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
	  if date.min < 10 then date.min = '0' .. tostring(date.min) end
	  if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end
	  --local steamhex = ESX.GetPlayerIdentifier(source)

	  sendToDiscord_all("Chat Log 🌐 "," Thông tin chat ", "Người chơi: **" ..player.name .. "** đã chat  \nChi tiết \nNội dung: " .. message .. " \n Thời gian : "..date.hour..":"..date.min..":"..date.sec.."", Config.grey, Config.webhook_chat)

  end
end)

-- Event when a player is connecting
RegisterServerEvent("esx:playerconnected")
AddEventHandler('esx:playerconnected', function()
  if(settings.LogLoginServer)then
    sendToDiscord_all(_U('server_connecting'), GetPlayerName(source) .." đã kết nối vào servẻ ",Config.grey, Config.webhook_player_join)
  end
end)

-- Event when a player is disconnecting
AddEventHandler('playerDropped', function(reason)
  if(settings.LogLoginServer)then
    sendToDiscord_all(_U('server_disconnecting'), GetPlayerName(source) .." đã thoát khỏi servẻr : ("..reason..")",Config.grey, Config.webhook_player_join)
  end
end)
  

-- Shops --


RegisterServerEvent("discordbot:buyitem_sv")
AddEventHandler("discordbot:buyitem_sv", function(item, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local steamhex = GetPlayerIdentifier(source)
	local date = os.date('*t')

	if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
	if date.min < 10 then date.min = '0' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end
	--local xItem = xPlayer.getInventoryItem(itemName)

	sendToDiscord_all("Buy Log 🌐 "," Thông tin mua hàng ", "Người chơi: **" ..xPlayer.name .. "** Mua đồ vật   \nTên mục: " .. item .. " Số lượng ( " .. count .. " ) \n Steam Hex: "..steamhex.."\n Thời gian : "..date.hour..":"..date.min..":"..date.sec.."", Config.blue, Config.webhook_buyitem)

end)

-- vault --

RegisterServerEvent("discordbot:addvault_sv")
AddEventHandler("discordbot:addvault_sv", function(name, item, count, type)
	--print('Show Discord')
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(item)
	local steamhex = GetPlayerIdentifier(source)
	local date = os.date('*t')

	if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
	if date.min < 10 then date.min = '0' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end

	sendToDiscord_all("Vault Log 🌐 "," Thông tin sử dụng tủ ", "Người chơi: **" ..xPlayer.name .. "** Mang theo đồ  \nChi tiết \nTên mục: " .. type .. " \nSố lượng: " .. item .. "  \n Steam Hex: "..steamhex.."\n Thời gian : "..date.hour..":"..date.min..":"..date.sec.."", Config.green, Config.webhook_addvault)

end)

RegisterServerEvent("discordbot:revault_sv")
AddEventHandler("discordbot:revault_sv", function(name, item, count, type)
	--print('Show Discord')
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(item)
	local steamhex = GetPlayerIdentifier(source)
	local date = os.date('*t')

	if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
	if date.min < 10 then date.min = '0' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end

	sendToDiscord_all("Vault Log 🌐 "," Thông tin lưu trữ ", "Người chơi: **" ..xPlayer.name .. "** Mang theo đồ  \nChi tiết \nTên mục: " .. type .. " \nSố lượng: " .. item .. "  \n Steam Hex: "..steamhex.."\n Thời gian : "..date.hour..":"..date.min..":"..date.sec.."", Config.red, Config.webhook_revault)

end)

-- Homes --


RegisterServerEvent("discordbot:putitemhome_sv")
AddEventHandler("discordbot:putitemhome_sv", function(count, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local steamhex = GetPlayerIdentifier(source)
	local date = os.date('*t')

	if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
	if date.min < 10 then date.min = '0' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end

	sendToDiscord_all("House Log 🌐 "," Thông tin thu thập mặt hàng ", "Người chơi: **" ..xPlayer.name .. "** Giữ các vật dụng vào nhà.   \nChi tiết \nMục: " .. item .. " \nSố lượng: " .. count .. " ชิ้น \n Steam Hex: "..steamhex.."\n Thời gian : "..date.hour..":"..date.min..":"..date.sec.."", Config.blue, Config.webhook_putiteminhome)

	--local xItem = xPlayer.getInventoryItem(itemName)
		--sendToDiscord_all("ผู้เล่นชื่อ ", xPlayer.name .. " เก็บไอเท็ม " .. item .. " เข้าบ้าน Số lượng " .. count .. " ชิ้น", Config.blue, Config.webhook_putiteminhome)
end)

RegisterServerEvent("discordbot:putmoneyhome_sv")
AddEventHandler("discordbot:putmoneyhome_sv", function(count, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local steamhex = GetPlayerIdentifier(source)
	local date = os.date('*t')

	if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
	if date.min < 10 then date.min = '0' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end

	sendToDiscord_all("House Log 🌐 "," Thông tin thanh toán tại nhà ", "Người chơi: **" ..xPlayer.name .. "** Tiết kiệm tiền vào nhà   \nChi tiết \n Loại tiền: " .. item .. " \nSố lượng: " .. count .. " 💲 \n Steam Hex: "..steamhex.."\n Thời gian : "..date.hour..":"..date.min..":"..date.sec.."", Config.green, Config.webhook_putmoneyinhome)

	--local xItem = xPlayer.getInventoryItem(itemName)

	
		--sendToDiscord_all("ผู้เล่นชื่อ ", xPlayer.name .. " เก็บเงิน " .. item .. " เข้าบ้าน Số lượng " .. count .. "$", Config.green, Config.webhook_putiteminhome)
end)

RegisterServerEvent("discordbot:putweaponhome_sv")
AddEventHandler("discordbot:putweaponhome_sv", function(count, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local steamhex = GetPlayerIdentifier(source)
	local date = os.date('*t')

	if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
	if date.min < 10 then date.min = '0' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end

	sendToDiscord_all("House Log 🌐 "," Thông tin thu thập vũ khí vào nhà ", "Người chơi: **" ..xPlayer.name .. "** Đưa vũ khí vào nhà   \nChi tiết \nvũ khí: " .. item .. " \nSố lượngกระสุน: " .. count .. " แม็ก \n Steam Hex: "..steamhex.."\n Thời gian : "..date.hour..":"..date.min..":"..date.sec.."", Config.green, Config.webhook_addweapon2home)

		--sendToDiscord_all("ผู้เล่นชื่อ ", xPlayer.name .. " เก็บอาวุธ " .. item .. " เข้าบ้าน 1 และกระสุน Số lượng " .. count .. " แม็ก", Config.orange, Config.webhook_putiteminhome)
end)

RegisterServerEvent("discordbot:getitemhome_sv")
AddEventHandler("discordbot:getitemhome_sv", function(count, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local steamhex = GetPlayerIdentifier(source)
	local date = os.date('*t')

	if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
	if date.min < 10 then date.min = '0' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end

	sendToDiscord_all("House Log 🌐 "," Thông tin xóa nhà ", "Người chơi: **" ..xPlayer.name .. "** Mang đồ vật ra khỏi nhà.   \nChi tiết \nMục: " .. item .. " \nSố lượng: " .. count .. " ชิ้น \n Steam Hex: "..steamhex.."\n Thời gian : "..date.hour..":"..date.min..":"..date.sec.."", Config.blue, Config.webhook_getiteminhome)

		--sendToDiscord_all("ผู้เล่นชื่อ ", xPlayer.name .. " เอาไอเท็ม " .. item .. " ออกจากบ้าน Số lượng " .. count .. " ชิ้น", Config.blue, Config.webhook_getiteminhome)
end)

RegisterServerEvent("discordbot:getmoneyhome_sv")
AddEventHandler("discordbot:getmoneyhome_sv", function(count, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local steamhex = GetPlayerIdentifier(source)
	local date = os.date('*t')

	if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
	if date.min < 10 then date.min = '0' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end

	sendToDiscord_all("House Log 🌐 "," Thông tin rút tiền ra khỏi nhà ", "Người chơi: **" ..xPlayer.name .. "** Mang tiền ra khỏi nhà   \nChi tiết \n Loại tiền: " .. item .. " \nSố lượng: " .. count .. " 💲 \n Steam Hex: "..steamhex.."\n Thời gian : "..date.hour..":"..date.min..":"..date.sec.."", Config.red, Config.webhook_outmoneyinhome)

		--sendToDiscord_all("ผู้เล่นชื่อ ", xPlayer.name .. " เอาเงิน " .. item .. " ออกจากบ้าน Số lượng " .. count .. " $", Config.red, Config.webhook_getiteminhome)
end)

RegisterServerEvent("discordbot:getweaponhome_sv")
AddEventHandler("discordbot:getweaponhome_sv", function(count, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local steamhex = GetPlayerIdentifier(source)
	local date = os.date('*t')

	if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
	if date.min < 10 then date.min = '0' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end

	sendToDiscord_all("House Log 🌐 "," Thông tin loại bỏ vũ khí ", "Người chơi: **" ..xPlayer.name .. "** Lấy vũ khí ra khỏi nhà   \nChi tiết \nอาวุธ: " .. item .. " \nSố lượngกระสุน: " .. count .. " Max \n Steam Hex: "..steamhex.."\n Thời gian : "..date.hour..":"..date.min..":"..date.sec.."", Config.red, Config.webhook_reweapon2home)

		--sendToDiscord_all("ผู้เล่นชื่อ ", xPlayer.name .. " เอาอาวุธ " .. item .. " ออกจากบ้าน 1 และกระสุน Số lượng " .. count .. " แม็ก", Config.orange, Config.webhook_getiteminhome)
end)






-- Event when a player is killing an other one

RegisterServerEvent('esx:killerlog')
AddEventHandler('esx:killerlog', function(t,killer, kilerT) -- t : 0 = NPC, 1 = player
  local xPlayer = ESX.GetPlayerFromId(source)
  if(t == 1) then
     local xPlayer = ESX.GetPlayerFromId(source)
     local xPlayerKiller = ESX.GetPlayerFromId(killer)

     if(xPlayerKiller.name ~= nil and xPlayer.name ~= nil)then

       if(kilerT.killerinveh) then
         local model = kilerT.killervehname

            sendToDiscord("Tên người chơi ", xPlayer.name .." Giết người "..xPlayerKiller.name.." ".._('with').." "..model,Config.red, Config.webhook_kill)
			
       else
            sendToDiscord("Tên người chơi ", xPlayer.name .." Giết người "..xPlayerKiller.name,Config.red, Config.webhook_kill)

       end
    end
  else
     sendToDiscord(_U('server_kill'), xPlayer.name .." Bị giết vô cớ",Config.red, Config.webhook_kill)

  end

end)