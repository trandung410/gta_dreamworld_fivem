Config = {}

Config.webhook = "SEU_WEBHOOK"				-- Webhook to send logs to discord
Config.lang = "en"							-- Set the file language [en/br]
Config.ESXSHAREDOBJECT = "esx:getSharedObject" -- Change your getshared object event here, in case you are using anti-cheat.

Config.max_owners = 9999						-- Maximum number of people who can buy the same company
Config.multiplicador_lossantos = 450 		-- Sales value of each product in Los Santos
Config.multiplicador_blaine = 600 			-- Sales value of each product in Blaine Country
Config.multiplicador_paleto = 800 			-- Sales value of each product in Paleto
Config.tempo_suprimentos = 240 				-- Time (in seconds) for purchased supplies to arrive
Config.tempo_processamento_suprimentos = 10	-- Time (in minutes) for 2 supplies to become a research or product point (15 min = 192 products generated per day)
Config.probabilidade_ser_saqueado = 0.01	-- Likelihood of the company being plundered if they have not upgraded security
Config.NPC = true							-- Enables / disables NPCs while stealing supplies
Config.itemC4 = "c4"						-- Item needed to break into the vehicle


Config.empresas = {
	-- ["galaxy"] = {
		-- ['nome'] = "Boate Galaxy", 											-- Company's name
		-- ['logo'] = "https://media.discordapp.net/attachments/533398980428693550/776882252142739456/Sem_titulo.png?width=555&height=555", -- Company image (must be in square format. Ideal size: 555x555)
		-- ['coordenada'] = {-1618.2924804688,-3011.9091796875,-75.205078125}, 	-- Location to open the menu
		-- ['coordenada_garagem'] = {-23.88,213.38,106.57,241.8}, 				-- Place where stolen vehicles must be delivered

		-- ['max_estoque_produtos'] = 400, 			-- Product storage capacity
		-- ['max_estoque_pesquisa'] = 400, 			-- Research storage capacity
		-- ['max_estoque_suprimentos'] = 250, 		-- Supply storage capacity
		-- ['valor_compra'] = 500000, 				-- Company purchase value
		-- ['valor_evoluir_equipamentos'] = 60000, 	-- Value to upgrade equipment
		-- ['valor_evoluir_funcionarios'] = 90000, 	-- Value to upgrade employees
		-- ['valor_evoluir_seguranca'] = 40000, 	-- Value to upgrade security
		-- ['valor_comprar_suprimentos'] = 40000, 	-- Value to buy supplies
		-- ['quantidade_compra_suprimentos'] = 100,	-- Amount of supplies you receive when purchasing
		-- ['quantidade_roubo_suprimentos'] = 40, 	-- Amount of supplies you receive when stealing
		-- ['estoque_evoluir_equipamentos'] = 150	-- Amount of supply inventory you gain when upgrading equipment
	-- },

	["split_sides"] = {
		['nome'] = "Split Sides West",
		['logo'] = "https://media.discordapp.net/attachments/533398980428693550/776883717398462464/Sem_titulo.png",
		['coordenada'] = {-449.96432495117,284.10794067383,78.521469116211},
		['coordenada_garagem'] = {-420.11,292.97,83.24,263.09},

		['max_estoque_produtos'] = 200,
		['max_estoque_pesquisa'] = 400,
		['max_estoque_suprimentos'] = 150,
		['valor_compra'] = 160000,
		['valor_evoluir_equipamentos'] = 30000,
		['valor_evoluir_funcionarios'] = 50000,
		['valor_evoluir_seguranca'] = 20000,
		['valor_comprar_suprimentos'] = 20000,
		['quantidade_compra_suprimentos'] = 50,
		['quantidade_roubo_suprimentos'] = 25,
		['estoque_evoluir_equipamentos'] = 50
	},

	["motoclube_1"] = {
		['nome'] = "Moto Clube Principal",
		['logo'] = "https://media.discordapp.net/attachments/533398980428693550/776886363810693150/Sem_titulo.png?width=555&height=555",
		['coordenada'] = {977.77209472656,-94.102691650391,74.868125915527},
		['coordenada_garagem'] = {981.84,-112.3,74.18,119.19},

		['max_estoque_produtos'] = 300,
		['max_estoque_pesquisa'] = 400,
		['max_estoque_suprimentos'] = 200,
		['valor_compra'] = 400000,
		['valor_evoluir_equipamentos'] = 40000,
		['valor_evoluir_funcionarios'] = 70000,
		['valor_evoluir_seguranca'] = 30000,
		['valor_comprar_suprimentos'] = 40000,
		['quantidade_compra_suprimentos'] = 100,
		['quantidade_roubo_suprimentos'] = 40,
		['estoque_evoluir_equipamentos'] = 100
	},

	["motoclube_2"] = {
		['nome'] = "Moto Clube Secundário",
		['logo'] = "https://media.discordapp.net/attachments/533398980428693550/776886646330490921/Sem_titulo.png?width=555&height=555",
		['coordenada'] = {1112.4240722656,-3145.216796875,-37.062732696533},
		['coordenada_garagem'] = {974.32,-131.42,74.14,63.87},

		['max_estoque_produtos'] = 200,
		['max_estoque_pesquisa'] = 400,
		['max_estoque_suprimentos'] = 150,
		['valor_compra'] = 150000,
		['valor_evoluir_equipamentos'] = 30000,
		['valor_evoluir_funcionarios'] = 50000,
		['valor_evoluir_seguranca'] = 20000,
		['valor_comprar_suprimentos'] = 20000,
		['quantidade_compra_suprimentos'] = 50,
		['quantidade_roubo_suprimentos'] = 25,
		['estoque_evoluir_equipamentos'] = 50
	},
	
	["arcadius"] = {
		['nome'] = "Arcadius Center",
		['logo'] = "https://media.discordapp.net/attachments/533398980428693550/776918037865300008/Sem_titulo.png",
		['coordenada'] = {-125.81478118896,-641.68774414062,168.84034729004},
		['coordenada_garagem'] = {-104.74,-608.98,36.08,157.59},

		['max_estoque_produtos'] = 800,
		['max_estoque_pesquisa'] = 400,
		['max_estoque_suprimentos'] = 400,
		['valor_compra'] = 1200000,
		['valor_evoluir_equipamentos'] = 120000,
		['valor_evoluir_funcionarios'] = 150000,
		['valor_evoluir_seguranca'] = 70000,
		['valor_comprar_suprimentos'] = 80000,
		['quantidade_compra_suprimentos'] = 200,
		['quantidade_roubo_suprimentos'] = 80,
		['estoque_evoluir_equipamentos'] = 200
	},

	["maze_bank_1"] = {
		['nome'] = "Maze Bank",
		['logo'] = "https://media.discordapp.net/attachments/533398980428693550/776922023351418934/latest.png?width=555&height=555",
		['coordenada'] = {-81.126991271973,-801.71881103516,243.40077209473},
		['coordenada_garagem'] = {-84.16,-766.42,41.23,18.66},

		['max_estoque_produtos'] = 800,
		['max_estoque_pesquisa'] = 400,
		['max_estoque_suprimentos'] = 400,
		['valor_compra'] = 1200000,
		['valor_evoluir_equipamentos'] = 120000,
		['valor_evoluir_funcionarios'] = 150000,
		['valor_evoluir_seguranca'] = 70000,
		['valor_comprar_suprimentos'] = 80000,
		['quantidade_compra_suprimentos'] = 200,
		['quantidade_roubo_suprimentos'] = 80,
		['estoque_evoluir_equipamentos'] = 200
	},

	["maze_bank_2"] = {
		['nome'] = "Maze Bank Filial",
		['logo'] = "https://media.discordapp.net/attachments/533398980428693550/776927356743974922/Sem_titulo.png",
		['coordenada'] = {-1372.4666748047,-464.24627685547,72.043998718262},
		['coordenada_garagem'] = {-1379.36,-474.87,31.6,98.61},

		['max_estoque_produtos'] = 500,
		['max_estoque_pesquisa'] = 400,
		['max_estoque_suprimentos'] = 300,
		['valor_compra'] = 850000,
		['valor_evoluir_equipamentos'] = 80000,
		['valor_evoluir_funcionarios'] = 100000,
		['valor_evoluir_seguranca'] = 60000,
		['valor_comprar_suprimentos'] = 60000,
		['quantidade_compra_suprimentos'] = 150,
		['quantidade_roubo_suprimentos'] = 50,
		['estoque_evoluir_equipamentos'] = 150
	},

	["lom_bank"] = {
		['nome'] = "Lom Bank",
		['logo'] = "https://media.discordapp.net/attachments/533398980428693550/776926125640646656/latest.png?width=555&height=555",
		['coordenada'] = {-1555.88671875,-575.01599121094,108.53781890869},
		['coordenada_garagem'] = {-1548.22,-547.15,34.38,35.88},

		['max_estoque_produtos'] = 500,
		['max_estoque_pesquisa'] = 400,
		['max_estoque_suprimentos'] = 300,
		['valor_compra'] = 850000,
		['valor_evoluir_equipamentos'] = 80000,
		['valor_evoluir_funcionarios'] = 100000,
		['valor_evoluir_seguranca'] = 60000,
		['valor_comprar_suprimentos'] = 60000,
		['quantidade_compra_suprimentos'] = 150,
		['quantidade_roubo_suprimentos'] = 50,
		['estoque_evoluir_equipamentos'] = 150
	},
	
	["escritorio_1"] = {
		['nome'] = "Escritório básico",
		['logo'] = "https://media.discordapp.net/attachments/533398980428693550/776920405348581405/Screenshot_8.png?width=555&height=555",
		['coordenada'] = {1161.5322265625,-3198.5952148438,-39.00798034668},
		['coordenada_garagem'] = {308.84,-762.24,29.26,156.14},

		['max_estoque_produtos'] = 150,
		['max_estoque_pesquisa'] = 400,
		['max_estoque_suprimentos'] = 100,
		['valor_compra'] = 100000,
		['valor_evoluir_equipamentos'] = 30000,
		['valor_evoluir_funcionarios'] = 50000,
		['valor_evoluir_seguranca'] = 20000,
		['valor_comprar_suprimentos'] = 20000,
		['quantidade_compra_suprimentos'] = 50,
		['quantidade_roubo_suprimentos'] = 25,
		['estoque_evoluir_equipamentos'] = 50
	},
	
	["escritorio_2"] = {
		['nome'] = "Escritório médio",
		['logo'] = "https://media.discordapp.net/attachments/533398980428693550/776921775858122812/Screenshot_9.png?width=555&height=555",
		['coordenada'] = {-1007.4771728516,-477.30615234375,50.02819442749},
		['coordenada_garagem'] = {-1029.72,-495.48,36.78,110.78},

		['max_estoque_produtos'] = 200,
		['max_estoque_pesquisa'] = 400,
		['max_estoque_suprimentos'] = 150,
		['valor_compra'] = 150000,
		['valor_evoluir_equipamentos'] = 30000,
		['valor_evoluir_funcionarios'] = 50000,
		['valor_evoluir_seguranca'] = 20000,
		['valor_comprar_suprimentos'] = 20000,
		['quantidade_compra_suprimentos'] = 50,
		['quantidade_roubo_suprimentos'] = 25,
		['estoque_evoluir_equipamentos'] = 50
	},

	["escritorio_3"] = {
		['nome'] = "Escritório de luxo",
		['logo'] = "https://media.discordapp.net/attachments/533398980428693550/776922762701832232/Screenshot_10.png?width=555&height=555",
		['coordenada'] = {-1911.4484863281,-572.99914550781,19.097234725952},
		['coordenada_garagem'] = {-1896.43,-557.48,11.73,224.83},

		['max_estoque_produtos'] = 200,
		['max_estoque_pesquisa'] = 400,
		['max_estoque_suprimentos'] = 150,
		['valor_compra'] = 170000,
		['valor_evoluir_equipamentos'] = 30000,
		['valor_evoluir_funcionarios'] = 50000,
		['valor_evoluir_seguranca'] = 20000,
		['valor_comprar_suprimentos'] = 20000,
		['quantidade_compra_suprimentos'] = 50,
		['quantidade_roubo_suprimentos'] = 30,
		['estoque_evoluir_equipamentos'] = 50
	},
	
	["clubhouse_2"] = {
		['nome'] = "Hawick Clubhouse",
		['logo'] = "https://media.discordapp.net/attachments/533398980428693550/776929977488769054/Sem_titulo.png?width=555&height=555",
		['coordenada'] = {1008.3001708984,-3169.8244628906,-38.894165039062},
		['coordenada_garagem'] = {-27.41,-196.33,52.37,66.42},

		['max_estoque_produtos'] = 300,
		['max_estoque_pesquisa'] = 400,
		['max_estoque_suprimentos'] = 200,
		['valor_compra'] = 400000,
		['valor_evoluir_equipamentos'] = 40000,
		['valor_evoluir_funcionarios'] = 70000,
		['valor_evoluir_seguranca'] = 30000,
		['valor_comprar_suprimentos'] = 40000,
		['quantidade_compra_suprimentos'] = 100,
		['quantidade_roubo_suprimentos'] = 40,
		['estoque_evoluir_equipamentos'] = 100
	}
}

Config.locais_roubo = {
	{-252.72, 6347.42, 31.45, 229.67}, -- Paletobay Care Center
	{3596.74, 3661.80, 32.85, 75.36 }, -- Humane Lab Garage 1
	{324.64, -1474.52, 29.76, 232.44}, -- Center Hospital
	{3597.74, 3669.79, 33.0, 232.44}, -- Humane Lab Garage 2
	{1356.89, 3617.91, 34.0, 289.05}, -- Trevor Lab
	{165.68, 2284.27, 93.51, 251.22}, -- Online Meth Lab
	{-575.85, -279.66, 35.15, 211.72}, -- Vangelico
	{-3158.51, 1129.05, 20.0, 340.76}, -- Chumhas-Barbareno Rd., some store
	{1075.92, -1949.32, 31.10, 143.46}, -- Gem Factory
	{-3166.73, 1032.56, 20.0, 155.60}, -- Chumhas-Barbareno Rd., some electronics store
	{369.55, -818.93, 28.70, 181.19}, -- Digital Den back alley
	{304.85, -904.96, 29.29, 71.09 }, -- Los Santos Theatre
	{2489.48, 4962.31, 44.0, 135.06}, -- Grapeseed Farm
	{3333.35, 5159.93, 17.70, 154.27}, -- Lighthouse
	{2702.14, 3453.09, 55.73, 149.64}, -- You Tool
	{-3051.47, 596.57, 6.60, 287.22}, -- Ineseno Rd, supermarket
	{-866.31, -1123.15, 7.20, 118.30}, -- Liquor Hole
	{1995.38, 3035.81, 47.03, 148.03}, -- Yellow Jack Inn
	{1244.2, -3289.29, 5.0, 272.84}, -- Some warehose at the port
	{1259.60, -2568.98, 42.0, 292.40}, -- El Burro Heights ruined warehouse
	{1564.63, -2162.92, 77.60, 356.89}, -- El Burro Heights another warehouse
	{1686.03, 6436.29, 32.45, 150.64}, -- Highway Gas Station
	{-676.49, 5776.40, 17.33, 64.76 }, -- Bayview Lodge
	{-105.52, 6489.80, 31.32, 234.07}, -- Blaine County Savings Bank
	{130.33, 6662.76, 31.71, 133.51}, -- Blaine County Big Gas Station
	{82.73, 3750.16, 39.90, 172.25}, -- Stab City
	{-1131.74, 2694.28, 18.8, 136.75}, -- The Paint Shop
	{-2571.25, 2338.04, 33.06, 157.13}, -- Route 68 Gas Station
	{350.09, 4450.57, 62.84, 6.37}, -- North Calafia Way near logs
	{1715.32, 4808.84, 41.84, 90.00}, -- Grapeseed Supermarket
	{1947.86, 3823.04, 32.06, 28.05}, -- Sandy Shores Liquor store
	{1063.07, 2656.37, 39.55, 2.39}, -- Route 68 old cafe
	{584.01, 2788.04, 42.19, 359.81}, -- Dollar Pills back
	{185.26, 2775.94, 45.80, 282.55}, -- Some place in Harmony
	{-53.31, 1949.29, 190.10, 32.89}, -- Great Chaparral Settlement
	{-1821.21, 809.29, 138.81, 303.20}-- Limited LTD Gas Station
}

Config.veiculos_roubo = {
	"BISON2",
	"BISON3",
	"BURRITO",
	"BURRITO2",
	"BURRITO3",
	"BURRITO4",
	"PARADISE",
	"RUMBO2",
	"SPEEDO",
	"SPEEDO4",
	"SURFER",
	"YOUGA",
	"YOUGA2"
}

-- Locais de venda para menos que 200 produtos
Config.qtd_venda_pouco = 200
Config.locais_venda_pouco = {
	{-3055.994140625,608.00018310547,7.214213848114, car = "MULE"},
	{-2298.99609375,433.00012207031,174.46208190918, car = "MULE"},
	{-1822.146484375,782.27368164062,137.8946685791, car = "MULE"},
	{-441.99371337891,6144.0,31.473825454712, car = "MULE"},
	{2454.0,-369.99993896484,92.996788024902, car = "MULE"},
	{675.09783935547,672.14166259766,128.91091918945, car = "MULE"},
	{476.24179077148,-3352.9270019531,6.0699110031128, car = "MULE"},
	{788.92993164062,1292.560546875,360.29684448242, car = "MULE"},
	{-529.01824951172,-2873.2250976562,6.0004472732544, car = "MULE"},
	{978.00823974609,-2243.0405273438,30.557525634766, car = "MULE"},
	{1733.4989013672,-1536.8664550781,112.71224975586, car = "MULE"},
	{-880.37023925781,-1486.4353027344,5.0242247581482, car = "MULE"},
}

-- Locais de venda para menos que 400 produtos
Config.qtd_venda_medio = 400
Config.locais_venda_medio = {
	{3480.0036621094,3668.0,33.883232116699, car = "POUNDER2"},
	{2772.0056152344,1404.0001220703,24.520608901978, car = "POUNDER2"},
	{194.22888183594,2786.26171875,45.655143737793, car = "POUNDER2"},
	{1027.0089111328,2657.0,39.547283172607, car = "POUNDER2"},
	{-266.01760864258,2191.9619140625,129.83721923828, car = "POUNDER2"},
	{-2530.6875,2345.4724121094,33.059875488281, car = "POUNDER2"},
	{-1600.3500976562,3094.4912109375,32.566062927246, car = "POUNDER2"},
	{1373.0598144531,3615.724609375,34.892364501953, car = "POUNDER2"},
	{2109.9853515625,4769.4921875,41.205924987793, car = "POUNDER2"},
	{2533.61328125,2578.6286621094,37.944828033447, car = "POUNDER2"},
	{236.97872924805,3107.8271484375,42.381690979004, car = "POUNDER2"},
	{2682.7961425781,3457.5024414062,55.757781982422, car = "POUNDER2"},
	{1731.9577636719,3311.5471191406,41.219108581543, car = "POUNDER2"},
}

-- Locais de venda para mais que 400 produtos
Config.locais_venda_muito = {
	{2007.0180664062,4987.0083007812,41.381526947021, car = "TERBYTE"},
	{-600.99267578125,5301.0,70.209480285645, car = "TERBYTE"},
	{3809.0034179688,4471.0,4.1231598854065, car = "TERBYTE"},
	{205.00708007812,6384.0009765625,31.412057876587, car = "TERBYTE"},
	{-1580.45703125,5160.8852539062,19.689855575562, car = "TERBYTE"},
	{1719.2686767578,6423.533203125,33.340286254883, car = "TERBYTE"},
	{1540.8021240234,6335.7373046875,24.074880599976, car = "TERBYTE"},
	{720.35955810547,4176.5986328125,40.709197998047, car = "TERBYTE"},
	{1640.4138183594,4840.5712890625,42.025737762451, car = "TERBYTE"},
	{-96.453804016113,6395.6201171875,31.452417373657, car = "TERBYTE"},
}

Config.blips = {
	-- { 397.06420898438,-712.62371826172,29.073789596558,475,4,"Company",0.5 }, 	-- Boate Galaxy
	{ -430.09323120117,261.73965454102,83.004585266113,475,4,"Company",0.5 }, 	-- Split Sides West
	{ 977.77209472656,-94.102691650391,74.868125915527,475,4,"Company",0.5 }, 	-- Moto Clube Primario
	{ 987.27813720703,-144.57054138184,74.271415710449,475,4,"Company",0.5 },	-- Moto Clube Secundário
	{ -116.4582901001,-604.75909423828,36.276329040527,475,4,"Company",0.5 }, 	-- Arcadius Center
	{ -70.92317199707,-801.04693603516,44.222755432129,475,4,"Company",0.5 }, 	-- Maze bank
	{ -1371.0145263672,-503.27758789062,33.153045654297,475,4,"Company",0.5 }, 	-- Maze Bank Filial
	{ -1581.1868896484,-558.27209472656,34.948238372803,475,4,"Company",0.5 }, 	-- Lom Bank
	{ 299.64303588867,-759.25268554688,29.338165283203,475,4,"Company",0.5 }, 	-- Escritório básico
	{ -1007.1130981445,-486.66296386719,39.965377807617,475,4,"Company",0.5 }, 	-- Escritório médio
	{ -1913.4766845703,-574.10241699219,11.430200576782,475,4,"Company",0.5 }, 	-- Escritório de luxo
	{ -22.449825286865,-192.71127319336,52.359741210938,475,4,"Company",0.5 }, 	-- Hawick Clubhouse
}

Config.teleports = {
	["ESCRITORIO"] = { -- Maze Bank
		positionFrom = { ['x'] = -70.93, ['y'] = -801.04, ['z'] = 44.22 },
		positionTo = { ['x'] = -75.64, ['y'] = -827.15, ['z'] = 243.39 }
	},
	["ESCRITORIO2"] = {
		positionFrom = { ['x'] = 299.63607788086, ['y'] = -759.25988769531, ['z'] = 29.342977523804 },
		positionTo = { ['x'] = 1173.55, ['y'] = -3196.68, ['z'] = -39.00 }
	},
	["ESCRITORIO3"] = {
		positionFrom = { ['x'] = -1007.12, ['y'] = -486.67, ['z'] = 39.97 },
		positionTo = { ['x'] = -1003.05, ['y'] = -477.92, ['z'] = 50.02 }
	},
	["ESCRITORIO4"] = {
		positionFrom = { ['x'] = -1913.48, ['y'] = -574.11, ['z'] = 11.43 },
		positionTo = { ['x'] = -1902.05, ['y'] = -572.42, ['z'] = 19.09 }
	},
	["ESCRITORIO5"] = {
		positionFrom = { ['x'] = -141.12, ['y'] = -620.74, ['z'] = 168.83 },
		positionTo = { ['x'] = -116.46, ['y'] = -604.75, ['z'] = 36.29 }
	},
	["ESCRITORIO6"] = {
		positionFrom = { ['x'] = -1579.12, ['y'] = -564.56, ['z'] = 108.53 },
		positionTo = { ['x'] = -1581.19, ['y'] = -558.28, ['z'] = 34.96 }
	},
	["ESCRITORIO7"] = {
		positionFrom = { ['x'] = -1392.69, ['y'] = -479.99, ['z'] = 72.05 },
		positionTo = { ['x'] = -1371.01, ['y'] = -503.27, ['z'] = 33.16 }
	},
	["HAWICKCLUBHOUSE"] = {
		positionFrom = { ['x'] = -22.44, ['y'] = -192.71, ['z'] = 52.37 },
		positionTo = { ['x'] = 998.13, ['y'] = -3157.79, ['z'] = -38.9 }
	},
}