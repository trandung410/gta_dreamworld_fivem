Config_xZC_Shop = {}

-- Base Extended
Config_xZC_Shop.Base = {
    getSharedObject = 'esx:getSharedObject',
    setJob = 'esx:setJob'
}

------------------------------ Config Settings
Config_xZC_Shop.URL_Images = "nui://esx_inventoryhud/html/img/items/" 
Config_xZC_Shop.ESX_CheckWeight = false 

------------------------------- Default
Config_xZC_Shop.Default = {
    limit = 10,
    item_type = "item_standard",
    price_account_name = "money",

    -- Blip
    Blip = {
        Sprite = 52,
        Colour = 2,
        Scale = 1.2
    },
    -- Marker
    Marker = {
        Distance = 30,
        Type = 1,
        Size = { x = 1.5, y = 1.5, z = 1.5 },
        Color = { r = 0, g = 128, b = 255 }
    }
}

-------------------------------- Zones 
Config_xZC_Shop.Zones = {
    {
        Name = "Weapons", 
        Label = "Vũ khí", 
        Job = { }, 
        ItemsRequire = {
        },
        Items = {  
            {
                name = "WEAPON_APPISTOL", -- 
                item_type = "item_standard",
                ammo = 100, -- 
                price_account_name = "money", -- 
                price = 35000, -- ราคา
            },
            {
                name = "WEAPON_MICROSMG", -- 
                item_type = "item_standard",
                ammo = 100, -- 
                price_account_name = "money", -- 
                price = 25000, -- ราคา
            },
            {
                name = "WEAPON_PUMPSHOTGUN", -- 
                item_type = "item_standard",
                ammo = 100, -- 
                price_account_name = "money", -- 
                price = 50000, -- ราคา
            },
            {
                name = "WEAPON_MACHETE", -- 
                item_type = "item_standard",
                ammo = 0, -- 
                price_account_name = "money", -- 
                price = 10000, -- ราคา
            },
            {
                name = "dan_luc",
                price = 500
                       
            },
            {
                name = "dan_uzi",
                price = 500
                       
            },
            {
                name = "dan_m4",
                price = 500
                       
            },
            {
                name = "dan_ak",
                price = 500
                       
            },
            {
                name = "dan_compac",
                price = 500
                       
            }
        },
        ItemsInclude = { }, --
        Blip = { -- Blip Map
            Show = true, -- true 
            Name = "<FONT FACE = 'Bariol'>Cửa hàng súng", 
            Sprite = 110, --
            Colour = 1, -- 
            Scale = 1.0 --
        },
        Marker = { -- Marker
            Show = true, -- 
            Type = 29, 
            Size = { x = 1.5, y = 1.5, z = 1.5 }, 
            Color = { r = 255, g = 0, b = 0 }, 
            Pos_Z_up = 0, -- 
            Pos_Z_down = 0 -- 
        },
        Pos = { --
            {x = 21.64, y = -1106.79, z = 29.8},
            {x = 1693.5908203125,y = 3759.119140625,z = 34.705345153809},
            {x = -330.33660888672,y = 6083.1513671875,z = 31.454772949219}

        }
    },
    {
        Name = "WeaponsCS", 
        Label = "Vũ khí CS", 
        Job = { 
            "police"
        }, 
        ItemsRequire = {
        },
        Items = {  
            
            {
                name = "WEAPON_ADVANCEDRIFLE",
                item_type = "item_weapon",
                ammo = 100, -- 
                price_account_name = "money",
                price = 0, -- ราคา
            },
            {
                name = "weapon_sawnoffshotgun",
                item_type = "item_weapon",
                ammo = 100, -- 
                price_account_name = "money",
                price = 0, -- ราคา
            },
            {
                name = "WEAPON_NIGHTSTICK",
                item_type = "item_weapon",
                ammo = 100, -- 
                price_account_name = "money",
                price = 0, -- ราคา
            },
            {
                name = "WEAPON_STUNGUN",
                item_type = "item_weapon",
                ammo = 100, -- 
                price_account_name = "money",
                price = 0, -- ราคา
            },
            {
                name = "WEAPON_FLASHLIGHT",
                item_type = "item_weapon",
                ammo = 100,
                price_account_name = "money", 
                price = 0,
            },
            {
                name = "WEAPON_PISTOL", -- 
                item_type = "item_weapon",
                ammo = 100, -- 
                price_account_name = "money", -- 
                price = 0, -- ราคา
            },
            {
                name = "armor",
                price = 5000
                       
            },
            {
                name = "dan_luc",
                price = 500
                       
            },
            {
                name = "dan_m4",
                price = 500
                       
            },
            {
                name = "dan_compac",
                price = 500
                       
            }
        },
        ItemsInclude = { }, --
        Blip = { -- Blip Map
            Show = false, -- true 
            Name = "Shop - Weapons", 
            Sprite = 110, --
            Colour = 1, -- 
            Scale = 1.0 --
        },
        Marker = { -- Marker
            Show = true, -- 
            Type = 29, 
            Size = { x = 1.5, y = 1.5, z = 1.5 }, 
            Color = { r = 255, g = 0, b = 0 }, 
            Pos_Z_up = 0, -- 
            Pos_Z_down = 0 -- 
        },
        Pos = { --
            {x = 461.97085571289, y = -980.861328125, z = 30.689674377441}

        }
    }

}

------------------------ ItemsInclude 
Config_xZC_Shop.ItemsInclude = {
    
    ["SET_WEAPON_01"] = {
        {
            name = "weapon_doubleaction",
            item_type = "item_weapon",
            ammo = 100,
            price_account_name = "black_money",
            price = 1000
        },
        {
            name = "weapon_assaultsmg",
            item_type = "item_weapon",
            ammo = 100,
            price_account_name = "black_money",
            price = 5000
        },
        {
            name = "weapon_heavyshotgun",
            item_type = "item_weapon",
            price_account_name = "black_money",
            ammo = 100,
            price = 5000
        }
    }
}
