-- NOTE: You can potentially pre-furnish house models using this.
-- If you don't know/cant figure it out, don't ask how.
ShellExtras = {
  HotelV1 = {
    [GetHashKey("v_49_motelmp_winframe")]       = {offset = vector3(1.44,-3.9, 2.419)},
    [GetHashKey("v_49_motelmp_glass")]          = {offset = vector3(1.44,-3.9, 2.419)},
    [GetHashKey("v_49_motelmp_curtains")]       = {offset = vector3(1.44,-3.8, 2.200)},
    [GetHashKey("hei_prop_heist_safedeposit")]  = {offset = vector3(1.0,-4.2, 2.00), rotation = vector3(0.0,0.0,180.0)},
  }
}

ShellPrices = {
  HotelV1       = 10000,
  ApartmentV1   = 20000,

  --NOTE: KAMBI PAYED SHELLS

  

  -- Office1   = 15000, 
  -- Office2   = 15000,
  -- OfficeBig = 25000,

  -- FrankAunt     = 10000,
  -- Medium2       = 10000,
  -- Medium3       = 10000,
  
  -- CokeShell1    = 15000,
  -- CokeShell2    = 15000,
  -- MethShell     = 15000,
  -- WeedShell1    = 15000,
  -- WeedShell2    = 15000,

  -- GarageShell1  = 15000,
  -- GarageShell2  = 15000,
  -- GarageShell3  = 15000,

  -- NewApt1       = 15000,
  -- NewApt2       = 15000,
  -- NewApt3       = 15000,
  
  -- Warehouse1 = 15000, 
  -- Warehouse2 = 15000,
  -- Warehouse3 = 15000, 

  -- Office1   = 15000, 
  -- Office2   = 15000,
  -- OfficeBig = 25000,

  -- Store1    = 25000,
  -- Store2    = 25000,
  -- Store3    = 25000,
  -- Gunstore  = 25000, 
  -- Barbers   = 25000,

  -- Trailer       = 15000,  
  -- Lester        = 15000,
  -- HotelV2       = 15000, 
  -- Trevor        = 20000, 
  -- ApartmentV2   = 25000, 
  -- HighEndV1     = 50000, 
  -- HighEndV2     = 60000, 
  -- Ranch         = 70000,
  -- Michaels      = 70000,
  
}

ShellModels = {  
  HotelV1       = "playerhouse_hotel",
  ApartmentV1   = "playerhouse_tier1",

  -- NOTE: KAMBI PAYED SHELLS
  

  -- Office1   = 'shell_office1',  
  -- Office2   = 'shell_office2',
  -- OfficeBig = 'shell_officebig',

  -- FrankAunt     = "shell_frankaunt",
  -- Medium2       = "shell_medium2",
  -- Medium3       = "shell_medium3",
  
  -- CokeShell1    = 'shell_coke1',
  -- CokeShell2    = 'shell_coke2',
  -- MethShell     = 'shell_meth',
  -- WeedShell1    = 'shell_weed',
  -- WeedShell2    = 'shell_weed2',

  -- GarageShell1  = 'shell_garages',
  -- GarageShell2  = 'shell_garagem',
  -- GarageShell3  = 'shell_garagel',

  -- NewApt1       = 'shell_apartment1',
  -- NewApt2       = 'shell_apartment2',
  -- NewApt3       = 'shell_apartment3',

  -- Warehouse1 = "shell_warehouse1",
  -- Warehouse2 = "shell_warehouse2",
  -- Warehouse3 = "shell_warehouse3",  

  -- Office1   = 'shell_office1',  
  -- Office2   = 'shell_office2',
  -- OfficeBig = 'shell_officebig',

  -- Store1    = 'shell_store1',   
  -- Store2    = 'shell_store2',   
  -- Store3    = 'shell_store3',  
  -- Gunstore  = 'shell_gunstore', 
  -- Barbers   = 'shell_barber',  
  
  -- HotelV2       = "shell_v16low",
  -- Trailer       = "shell_trailer",
  -- Trevor        = "shell_trevor",
  -- ApartmentV2   = "shell_v16mid",
  -- Lester        = "shell_lester",
  -- Ranch         = "shell_ranch",
  -- HighEndV1     = "shell_highend",
  -- HighEndV2     = "shell_highendv2",
  -- Michaels      = "shell_michael",
  
}

ShellOffsets = {  
  HotelV1       = {exit = vector4(1.0,3.5,27.6,1.5)},
  HotelV2       = {exit = vector4(-4.7,6.5,28.9,0.4)},
  Trailer       = {exit = vector4(1.3,2.0,27.1,0.4)},
  Trevor        = {exit = vector4(-0.2,3.5,27.5,0.0)},
  ApartmentV1   = {exit = vector4(-3.6,15.4,27.7,0.0)},
  ApartmentV2   = {exit = vector4(-1.4,13.9,28.85,0.8)},
  Lester        = {exit = vector4(1.5,5.8,28.1,3.1)},
  Ranch         = {exit = vector4(1.0,5.3,27.4,270.0)},
  HighEndV1     = {exit = vector4(22.1,0.4,22.7,271.0)},
  HighEndV2     = {exit = vector4(10.2,-0.9,23.4,270.0)},
  Michaels      = {exit = vector4(9.3,-5.6,20.0,259.0)},

  Office1       = {exit = vector4(-1.211617, -4.987183, 27.95093, 184.172)},
  Office2       = {exit = vector4(-3.488777, 2.018311, 28.73308, 91.23632)},
  OfficeBig     = {exit = vector4(12.6039, -1.839844, 24.69724, 180.4282)},

  Store1        = {exit = vector4(2.775688, 4.565063, 28.91416, 2.809942)},
  Store2        = {exit = vector4(0.7891312, 5.07373, 28.98058, 0.9400941)},
  Store3        = {exit = vector4(0.1036224, 7.573242, 27.99363, 359.8295)},
  Gunstore      = {exit = vector4(1.148056, 5.151367, 28.96727, 0.454677)},
  Barbers       = {exit = vector4(-1.598465, -5.24231, 28.99999, 181.2334)},

  Warehouse1    = {exit = vector4(8.625145, -0.1049805, 28.96388, 270.1945)},
  Warehouse2    = {exit = vector4(12.29147, -5.414795, 28.96133, 270.8702)},
  Warehouse3    = {exit = vector4(-2.386871, 1.656372, 28.99656, 89.92931)},

  CokeShell1    = {exit = vector4(6.284302, -8.289307, 28.99088, 178.625)},
  CokeShell2    = {exit = vector4(6.284302, -8.289307, 28.99088, 178.625)},
  MethShell     = {exit = vector4(6.284302, -8.289307, 28.99088, 178.625)},
  WeedShell1    = {exit = vector4(-17.51855, -11.66284, 28.98102, 98.85722)},
  WeedShell2    = {exit = vector4(-17.51855, -11.66284, 28.98102, 98.85722)},

  GarageShell1  = {exit = vector4(-6.019897, -3.527344, 28.9867, 181.9444)},
  GarageShell2  = {exit = vector4(-13.56653, -1.5979, 29.00004, 93.81283)},
  GarageShell3  = {exit = vector4(-12.04602, 14.29126, 29.00008, 91.64314)},

  NewApt1       = {exit = vector4(2.223267, -8.481567, 21.30548, 186.0575)},
  NewApt2       = {exit = vector4(2.223267, -8.481567, 21.30548, 186.0575)},
  NewApt3       = {exit = vector4(-11.3893, -4.29541, 21.86993, 127.1683)},

  FrankAunt     = {exit = vector4(0.511617,   5.607183, 28.15093, 355.93)},
  Medium2       = {exit = vector4(-5.688777, -0.358311, 28.73308, 91.23632)},
  Medium3       = {exit = vector4(-5.65039,   1.839844, 23.29724, 86.2782)},
}

Houses = {
  {
    Entry   = vector4(54.250, -1873.34, 23.00, 200.00),
    Garage  = vector4( 58.77, -1881.73, 22.50,  45.00),
    Shell   = "HotelV1",
    Price   = 25000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
    }
  },
  {
    Entry   = vector4(45.73, -1864.50, 23.50, 200.00),
    Garage  = vector4( 42.15, -1852.82,   22.83, 135.0),
    Shell   = "HotelV1",
    Price   = 25000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
    }
  },
  {
    Entry   = vector4(29.85, -1854.45, 24.20, 200.00),
    Shell   = "HotelV1",
    Price   = 25000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
    }
  },
  {
    Entry   = vector4(21.15, -1844.32, 25.00, 200.00),
    Garage  = vector4( 10.07, -1845.35,   24.30, 135.0),
    Shell   = "HotelV1",
    Price   = 25000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
    }
  },
  {
    Entry   = vector4( 5.09, -1884.23, 24.00, 200.0),
    Garage  = vector4(15.19, -1883.37, 23.15, 319.0),
    Shell   = "HotelV1",
    Price   = 25000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
    }
  },
  {
    Entry   = vector4(-34.13, -1847.20, 26.50, 200.0),
    Shell   = "HotelV1",
    Price   = 25000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
    }
  },
  {
    Entry   = vector4(-20.51, -1858.72, 25.60, 200.00),
    Garage  = vector4(-22.98, -1852.43, 25.09,  25.09),
    Shell   = "HotelV1",
    Price   = 25000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
    }
  },
  {
    Entry   = vector4(-5.02, -1872.19, 24.50, 200.00),
    Garage  = vector4(-4.87, -1883.29, 23.65, 315.50),
    Shell   = "HotelV1",
    Price   = 25000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
    }
  },
  {
    Entry   = vector4(23.24, -1896.55, 23.30, 200.00),
    Garage  = vector4(18.02, -1885.35, 22.17, 316.65),
    Shell   = "HotelV1",
    Price   = 25000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
    }
  },
  {
    Entry   = vector4(39.11, -1911.59, 22.30, 200.00),
    Garage  = vector4(39.27, -1924.11, 21.67, 316.65),
    Shell   = "HotelV1",
    Price   = 25000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
    }
  },
  {
    Entry   = vector4(56.51, -1922.66, 21.91, 200.00),
    Garage  = vector4(68.00, -1921.86, 21.33, 319.95),
    Shell   = "HotelV1",
    Price   = 25000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
    }
  },
  {
    Entry   = vector4(72.18, -1939.09, 21.37, 200.00),
    Shell   = "HotelV1",
    Price   = 25000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
    }
  },
  {
    Entry   = vector4(76.21, -1948.14, 21.17, 200.00),
    Shell   = "HotelV1",
    Price   = 25000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
    }
  },
  {
    Entry   = vector4(85.89, -1959.68, 21.12, 200.00),
    Garage  = vector4(85.61, -1971.30, 20.75, 316.65),
    Shell   = "HotelV1",
    Price   = 25000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
    }
  },
  {
    Entry   = vector4(114.19, -1961.11, 21.33, 200.00),
    Garage  = vector4(103.76, -1957.29, 20.75,   0.95),
    Shell   = "HotelV1",
    Price   = 25000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
    }
  },
  {
    Entry   = vector4(126.68, -1930.06, 21.38, 200.00),
    Garage  = vector4(127.59, -1939.43, 20.66, 111.96),
    Shell   = "HotelV1",
    Price   = 25000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
    }
  },
  {
    Entry   = vector4(118.42, -1921.12, 21.32, 200.00),
    Shell   = "HotelV1",
    Price   = 25000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
    }
  },
  {
    Entry   = vector4(100.90, -1912.19, 21.41, 200.00),
    Shell   = "HotelV1",
    Price   = 25000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
    }
  },

  -- Heights
  {
    Entry   = vector4(1301.09, -574.56, 71.73, 160.63),
    Garage  = vector4(1291.09, -583.01, 71.74, 343.00),
    Shell   = "ApartmentV1",
    Price   = 55000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
    }
  },
  {
    Entry   = vector4(1323.39, -582.96, 73.24, 0.15),
    Garage  = vector4(1312.97, -588.86, 72.93, 340.00),
    Shell   = "ApartmentV1",
    Price   = 55000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
    }
  },
  {
    Entry   = vector4(1341.37, -597.19, 74.70, 220.30),
    Garage  = vector4(1346.86, -606.70, 74.35, 323.00),
    Shell   = "ApartmentV1",
    Price   = 55000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
    }
  },
  {
    Entry   = vector4(1367.22, -606.48, 74.71, 0.76),
    Garage  = vector4(1360.21, -615.84, 74.33, 360.00),
    Shell   = "ApartmentV1",
    Price   = 55000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
    }
  },
  {
    Entry   = vector4(1386.05, -593.41, 74.48, 75.66),
    Garage  = vector4(1389.99, -605.32, 74.33, 55.21),
    Shell   = "ApartmentV1",
    Price   = 55000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
    }
  },
  {
    Entry   = vector4(1388.96, -569.61, 74.49, 135.98),
    Garage  = vector4(1400.97, -572.20, 74.33, 115.20),
    Shell   = "ApartmentV1",
    Price   = 55000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
    }
  },
  {
    Entry   = vector4(1373.26, -555.84, 74.68, 90.43),
    Garage  = vector4(1365.39, -547.80, 74.33, 155.95),
    Shell   = "ApartmentV1",
    Price   = 55000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
    }
  },
  {
    Entry   = vector4(1348.34, -546.90, 73.89, 170.16),
    Garage  = vector4(1358.33, -541.36, 73.77, 160.61),
    Shell   = "ApartmentV1",
    Price   = 55000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
    }
  },
  {
    Entry   = vector4(1328.50, -536.00, 72.44, 90.21),
    Garage  = vector4(1320.41, -528.33, 72.12, 159.91),
    Shell   = "ApartmentV1",
    Price   = 55000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
    }
  },
  {
    Entry   = vector4(1303.20, -527.46, 71.46, 180.56),
    Garage  = vector4(1312.66, -521.69, 71.31, 162.44),
    Shell   = "ApartmentV1",
    Price   = 55000,
    Shells  = {
      HotelV1       = true,
      ApartmentV1   = true,
    }
  },
}

if IsDuplicityVersion() then
  Citizen.CreateThread(function()
    Wait(1500)

    local check_coords = {}  
    for _,house in ipairs(Houses) do
      if check_coords[house.Entry] then
        print("Duplicate entry location in houses.lua","Entry: "..tostring(house.Entry))
        return
      else
        check_coords[house.Entry] = true
      end
    end
    if not error_out then
      print("Completed house table check successfully.")
    end
  end)
end

