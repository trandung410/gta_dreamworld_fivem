-- CREATE BY THANAWUT PROMRAUNGDET
Config = {}

Config.Key = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118, ["Enter"] = 191
}

Config.Discount = 0.9
Config.MaxCount = 300

Config.SellZone = {
	DiamondSell = {
		Text = {
			Title = "Diamond Store",
			SubTitle = "Diamond Store",
			TextHelper = 'Nhấn ~INPUT_DETONATE~ để bán ~p~ kim cương.',
			ProcessText = 'Thương lượng với người mua...',
		},
		Animation = {
			Scenario = true,
			AnimationDirect = nil,
			AnimationScene = "WORLD_HUMAN_HANG_OUT_STREET",
		},
		NPC = {
			Model = "u_f_y_jewelass_01",
			Pos = {
				x = 178.93,   
				y = -968.1,  
				z = 29.58,
				h = 144.54
			},
		},
		Blips = {
			Id = 439,
			Color = 46,
			Size = 1.5,
			Text = "Work : Sell Item"
		},
		Marker = {
			Type = 2,
			Pos = {
				x = 178.93,   
				y = -968.1,  
				z = 29.58,
			},
			Color = {
				r = 0,
				g = 100,
				b = 200,
				a = 0
			},
			DrawDistance = 100,
			Size = {x = 1.5, y = 1.5, z = 1.5}
		},
		Item = {
			{
				Text = "Diamond",
				Text_TH = "Diamond",
				Unit = "viên",
				ItemName = "diamond",
				Text_NotHave = "Bạn không có <strong class='red-text'>kim cương.</strong>",
				Text_NotHave_Desc = "Bạn không có <strong class='red-text'>kim cương.</strong>",
				ListItem = false,
				ItemCount = 1,
				Negotiating = true,
				RandomPrice = true,
				Price = { 1000, 2000},
				Eco_Max = 2000,
				Eco_Price = { 1200, 2000},
			},
			
		}
	},


	GoldSell = {
		Text = {
			Title = "Ore",
			SubTitle = "Ore",
			TextHelper = 'Nhấn ~INPUT_DETONATE~ để bán ~r~đồng ~w~hoặc ~y~vàng.',
			ProcessText = 'Thương lượng với người mua...',
		},
		Animation = {
			Scenario = true,
			AnimationDirect = nil,
			AnimationScene = "WORLD_HUMAN_HANG_OUT_STREET",
		},
		NPC = {
			Model = "u_m_m_bankman",
			Pos = {
				x = 180.19,   
				y = -969.29,  
				z = 29.58,
				h = 139.1
			},
		},
		--[[Blips = {
			Id = 439,
			Color = 56,
			Size = 0.9,
			Text = "Sell Copper Bar or Gold Bar or Iron Bar"
		},]]
		Marker = {
			Type = 25,
			Pos = {
				x = 180.19,   
				y = -969.29,  
				z = 29.58,
			},
			Color = {
				r = 0,
				g = 100,
				b = 200,
				a = 0
			},
			DrawDistance = 100,
			Size = {x = 1.5, y = 1.5, z = 1.5}
		},
		Item = {
			{
				Text = "Thỏi vàng",
				Text_TH = "Thỏi vàng",
				Unit = "thỏi",
				ItemName = "gold",
				Text_NotHave = "Bạn không có <strong class='red-text'>thỏi vàng.</strong>",
				Text_NotHave_Desc = "Bạn không có <strong class='red-text'>thỏi vàng.</strong>",
				ListItem = true,
				ItemCount = 0,
				Negotiating = false,
				RandomPrice = false,
				Price = 200,
				Eco_Max = 300,
				Eco_Price = { 250, 300},
			},
			{
				Text = "Đồng",
				Text_TH = "Đồng",
				Unit = "thỏi",
				ItemName = "copper",
				Text_NotHave = "Bạn không có <strong class='red-text'>Đồng.</strong>",
				Text_NotHave_Desc = "Bạn không có <strong class='red-text'>Đồng.</strong>",
				ListItem = true,
				ItemCount = 0,
				Negotiating = false,
				RandomPrice = false,
				Price = 136,
				Eco_Max = 300,
				Eco_Price = { 136, 146},
			},
			{
				Text = "Sắt",
				Text_TH = "Sắt",
				Unit = "thỏi",
				ItemName = "iron",
				Text_NotHave = "Bạn không có <strong class='red-text'>sắt.</strong>",
				Text_NotHave_Desc = "Bạn không có <strong class='red-text'>sắt.</strong>",
				ListItem = true,
				ItemCount = 0,
				Negotiating = false,
				RandomPrice = false,
				Price = 150,
				Eco_Max = 200,
				Eco_Price = { 150, 200},
			}
		}
	},



	WoodSell = {
		Text = {
			Title = "Wood Store",
			SubTitle = "Gỗ",
			TextHelper = 'Nhấn ~INPUT_DETONATE~ để bán gỗ.',
			ProcessText = 'Thương lượng với người mua...',
		},
		Animation = {
			Scenario = true,
			AnimationDirect = nil,
			AnimationScene = "WORLD_HUMAN_HANG_OUT_STREET",
		},
		NPC = {
			Model = "s_m_y_airworker",
			Pos = {
				x = 181.44,   
				y = -970.91,  
				z = 29.58,
				h = 133.9
			},
		},
		Marker = {
			Type = 25,
			Pos = {
				x = 181.44,   
				y = -970.91,  
				z = 29.58,
			},
			Color = {
				r = 0,
				g = 100,
				b = 200,
				a = 0
			},
			DrawDistance = 100,
			Size = {x = 1.5, y = 1.5, z = 1.5}
		},
		Item = {
			{
				Text = "Gỗ",
				Text_TH = "Gỗ",
				Unit = "cây",
				ItemName = "pro_wood",
				Text_NotHave = "Bạn không có <strong class='red-text'>gỗ.</strong>",
				Text_NotHave_Desc = "Bạn không có <strong class='red-text'>gỗ.</strong>",
				ListItem = true,
				ItemCount = 0,
				Negotiating = false,
				RandomPrice = false,
				Price = 2,
				Eco_Max = 5,
				Eco_Price = { 2, 5},
			}
		}
	},


	BeefSell = {
		Text = {
			Title = "Beef Sell",
			SubTitle = "Cửa hàng thịt bò",
			TextHelper = 'Nhấn ~INPUT_DETONATE~ để bán thịt bò.',
			ProcessText = 'Thương lượng với người mua...',
		},
		Animation = {
			Scenario = true,
			AnimationDirect = nil,
			AnimationScene = "WORLD_HUMAN_HANG_OUT_STREET",
		},
		NPC = {},
		--[[Blips = {
			Id = 366,
			Color = 27,
			Size = 0.9,
			Text = "Orange Sell"
		},]]
		Marker = {
			Type = 2,
			Pos = {
				x = 183.14, 
				y = -972.2, 
				z = 29.59
			},
			Color = {
				r = 50,
				g = 0,
				b = 200,
				a = 100
			},
			DrawDistance = 100,
			Size = {x = 0.8, y = 0.8, z = 0.8}
		},
		Item = {
			{
				Text = "Thịt bò",
				Text_TH = "Thịt bò",
				Unit = "miếng",
				ItemName = "beef_s",
				Text_NotHave = "Bạn không có <strong class='red-text'>Thịt bò.</strong>",
				Text_NotHave_Desc = "Bạn không có <strong class='red-text'>Thịt bò.</strong>",
				ListItem = true,
				ItemCount = 0,
				Negotiating = false,
				RandomPrice = false,
				Price = 80,
				Eco_Max = 120,
				Eco_Price = { 80, 120},
			},
			{
				Text = "Thịt heo",
				Text_TH = "Thịt heo",
				Unit = "miếng",
				ItemName = "beef_p",
				Text_NotHave = "Bạn không có <strong class='red-text'>Thịt heo.</strong>",
				Text_NotHave_Desc = "Bạn không có <strong class='red-text'>Thịt heo.</strong>",
				ListItem = true,
				ItemCount = 0,
				Negotiating = false,
				RandomPrice = false,
				Price = 80,
				Eco_Max = 120,
				Eco_Price = { 80, 120},
			}
		}
	},
	BeeSell = {
		Text = {
			Title = "Honey Selling",
			SubTitle = "Mật ong",
			TextHelper = 'Nhấn ~INPUT_DETONATE~ để bán mật ong.',
			ProcessText = 'Thương lượng với người mua...',
		},
		Animation = {
			Scenario = true,
			AnimationDirect = nil,
			AnimationScene = "WORLD_HUMAN_HANG_OUT_STREET",
		},
		NPC = {},
		Marker = {
			Type = 2,
			Pos = {
				x = 185.37,
				y = -973.84, 
				z = 29.68
			},
			Color = {
				r = 50,
				g = 0,
				b = 200,
				a = 100
			},
			DrawDistance = 100,
			Size = {x = 0.8, y = 0.8, z = 0.8}
		},
		Item = {
			{
				Text = "Mật ong",
				Text_TH = "Mật ong",
				Unit = "Hũ",
				ItemName = "bee",
				Text_NotHave = "Bạn không có <strong class='red-text'>Mật ong.</strong>",
				Text_NotHave_Desc = "Bạn không có <strong class='red-text'>Mật ong.</strong>",
				ListItem = true,
				ItemCount = 0,
				Negotiating = false,
				RandomPrice = false,
				Price = 80,
				Eco_Max = 120,
				Eco_Price = { 80, 120},
			},
		}
	},
}