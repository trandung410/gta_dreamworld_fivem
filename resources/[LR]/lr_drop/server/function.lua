toaDo = nil
daLoot = true
posX = nil
posY = nil
function GuiToaDo()
	Citizen.Wait(3000)
	math.randomseed(GetGameTimer())
	local modX = math.random(-2800, 2800)

	Citizen.Wait(100)

	math.randomseed(GetGameTimer())
	local modY = math.random(-2800, 2800)
	posX = -236.16 - modX
	posY = -977.74 - modY
	TriggerClientEvent('lr_drop:toaDo', -1, posX, posY)
	--toaDo = coords
	daLoot = false
	deleteTimeout = ESX.SetTimeout(300000, deleteDrop)
	--TriggerClientEvent('lorraxsnotify:thongbao', -1, {type = 'error', text = 'Người đàn ông nọ đã tìm thấy chiếc hòm ở tọa độ x = '..posX..' y = '..posY})
	print('lr_drop: Has been Dropped')
end

function getRandom()
	local rD = math.random(1, #Config.DropLocation)
	return(Config.DropLocation[rD])
end

function getRandomPhanthuong()
	local r1 = math.random(1, 10)
	if r1 >= 6 then
		local r2 = math.random(1, 100)
		if r2 > 101 then
			local r3 = math.random(1,10)
			if r3 > 9 then
				local ketQua = {
					type = 'weapon',
					phanthuong = Config.PhanThuong.sung[2]
				}
				return(ketQua)
			else
				local ketQua = {
					type = 'weapon',
					phanthuong = Config.PhanThuong.sung[1]
				}
				return(ketQua)
			end
		elseif r2 <= 99 and r2 > 90 then
			local r4 = math.random(1,10)
			if r4 > 5 then 
				local ketQua = {
						type = 'item',
						phanthuong = Config.PhanThuong.item[1]
					}
				return(ketQua)
			else
				local ketQua = {
						type = 'item',
						phanthuong = Config.PhanThuong.item[2]
					}
				return(ketQua)
			end
		else
			local ketQua = {
					type = 'money',
					phanthuong = Config.PhanThuong.tien
				}
			return(ketQua)
		end
	else
		local ketQua = {
			type = 'error',
			msg = 'Hòm này không có gì cả'
		}
		return(ketQua)
	end
end

function deleteDrop()
	if daLoot == false then
		TriggerClientEvent('lr_drop:deleteDrop', -1)
		daLoot = true
		isLooting = false
		SetTimeout(10000, GuiToaDo)
		print('lr_drop: Has been deleteDrop')
	end
end