if Config.CreateHouses then
  RegisterCommand("createhouse", function(...)
    local plyPed  = GetPlayerPed(-1)
    local plyJob  = GetPlayerJobName()
    local jobRank = GetPlayerJobRank()

    if not Config.CreationJobs[plyJob] then 
      return
    elseif Config.CreationJobs[plyJob].minRank then
      if not jobRank then
        return
      elseif Config.CreationJobs[plyJob].minRank > jobRank then
        return
      end
    end

    ShowNotification(Labels["AcceptDrawText"]..Labels["SetEntry"])

    while not IsControlJustPressed(0,Config.Controls.Accept)  do Wait(0); end
    while     IsControlPressed(0,Config.Controls.Accept)      do Wait(0); end

    local entryPos = GetEntityCoords(plyPed)
    local entryHead = GetEntityHeading(plyPed)
    local entryLocation = vector4(entryPos.x,entryPos.y,entryPos.z,entryHead)

    ShowNotification(Labels["AcceptDrawText"]..Labels["SetGarage"].."\n"..Labels["CancelDrawText"]..Labels["CancelGarage"])

    while not IsControlJustPressed(0,Config.Controls.Accept) and not IsControlJustPressed(0,Config.Controls.Cancel) do Wait(0); end    
    while     IsControlPressed(0,Config.Controls.Accept)          or IsControlPressed(0,Config.Controls.Cancel)     do Wait(0); end

    local garageLocation = false
    if IsControlJustReleased(0,Config.Controls.Accept) then
      local garagePos = GetEntityCoords(plyPed)
      local garageHead = GetEntityHeading(plyPed)
      garageLocation = vector4(garagePos.x,garagePos.y,garagePos.z,garageHead)
    end

    ShowNotification(Labels["SetSalePrice"])
    exports["input"]:Open("Set Sale Price",(Config.UsingESX and Config.UsingESXMenu and "ESX" or "Native"),function(data)
      local salePrice = math.max(1,(tonumber(data) and tonumber(data) > 0 and tonumber(data) or 0))
      local is_interior,is_shell = false,false
      if Config.UseMLO then
        if Config.UsingESX and Config.UsingESXMenu then
          local elements = {
            [1] = {label = Labels["UseInterior"],value="interior"},
            [2] = {label = Labels["UseShell"],value="shell"}
          }
          ESX.UI.Menu.Open('default', GetCurrentResourceName(), "select_int_type",{
              title    = Labels["InteriorType"],
              align    = 'center',
              elements = elements,
            }, 
            function(data,menu)
              menu.close()
              if data.current.value == "interior" then
                ShowNotification(Labels['AcceptDrawText']..Labels['SetInterior'])
                while true do
                  local ped = GetPlayerPed(-1)
                  local pos = GetEntityCoords(ped)
                  local int = GetInteriorAtCoords(pos.x,pos.y,pos.z)
                  local _pos,_hash = GetInteriorInfo(int)
                  ShowHelpNotification(Labels['Interior']..": ".._hash)
                  if IsControlJustReleased(0,Config.Controls.Accept) then
                    if _hash and _hash ~= 0 then
                      is_interior = _hash
                      ShowNotification(Labels['Interior']..": ".._hash)
                      return
                    end
                  end
                  Wait(0)
                end
              elseif data.current.value == "shell" then            
                ShowNotification(Labels["SelectDefaultShell"])
                  local elements = {}
                  for k,v in pairs(ShellModels) do
                    table.insert(elements,{label = k})
                  end
                  ESX.UI.Menu.Open('default', GetCurrentResourceName(), "create_house_shell",{
                      title    = Labels["SelectDefaultShell"],
                      align    = 'center',
                      elements = elements,
                    }, 
                    function(submitData,submitMenu)
                      is_shell = submitData.current.label
                      submitMenu.close()
                    end,
                    function(data,menu)
                      menu.close()
                    end
                  )
              end
            end
          )
        else
          local get_int = CreateNativeUIMenu(Labels["InteriorType"],"")
          local interior = NativeUI.CreateItem(Labels["UseInterior"],"")
          interior.Activated = function(...)
            _Pool:CloseAllMenus()
            ShowNotification(Labels['AcceptDrawText']..Labels['UseInterior'])
            while true do
              local ped = GetPlayerPed(-1)
              local pos = GetEntityCoords(ped)
              local int = GetInteriorAtCoords(pos.x,pos.y,pos.z)
              local _pos,_hash = GetInteriorInfo(int)
              ShowHelpNotification(Labels['Interior']..": ".._hash)
              if IsControlPressed(0,Config.Controls.Accept) then
                if _hash and _hash ~= 0 then
                  is_interior = _hash
                  ShowNotification(Labels['Interior']..": ".._hash)
                  return
                end
              end              
              Wait(0)
            end
          end

          local shells = NativeUI.CreateItem(Labels["UseShell"],"")
          shells.Activated = function(...)
            _Pool:CloseAllMenus()
            Wait(250)

            local shell = CreateNativeUIMenu(Labels["SelectDefaultShell"],"")
            for key,price in pairs(ShellModels) do
              local _item = NativeUI.CreateItem(key,"")
              _item.Activated = function(...) 
                is_shell = key
                _Pool:CloseAllMenus()
              end
              shell:AddItem(_item)
            end    
            shell:RefreshIndex()
            shell:Visible(true)  
          end

          get_int:AddItem(interior)
          get_int:AddItem(shells)

          get_int:RefreshIndex()
          get_int:Visible(true)
        end
      else
        ShowNotification(Labels["SelectDefaultShell"])
        if Config.UsingESX and Config.UsingESXMenu then
          local elements = {}
          for k,v in pairs(ShellModels) do
            table.insert(elements,{label = k})
          end
          ESX.UI.Menu.Open('default', GetCurrentResourceName(), "create_house_shell",{
              title    = Labels["SelectDefaultShell"],
              align    = 'center',
              elements = elements,
            }, 
            function(submitData,submitMenu)
              is_shell = submitData.current.label
              submitMenu.close()
            end,
            function(data,menu)
              menu.close()
            end
          )
        else
          local shell = CreateNativeUIMenu(Labels["SelectDefaultShell"],"")
          for key,price in pairs(ShellModels) do
            local _item = NativeUI.CreateItem(key,"")
            _item.Activated = function(...) 
              is_shell = key
              _Pool:CloseAllMenus()
            end
            shell:AddItem(_item)
          end    
          shell:RefreshIndex()
          shell:Visible(true)  
        end
      end

      while not is_interior and not is_shell do Wait(0); end    

      local shells,doors = {},{}
      if is_shell then
        ShowNotification(Labels['ToggleShells'])
        if Config.UsingESX and Config.UsingESXMenu then
          local elements = {}
          for k,v in pairs(ShellModels) do
            table.insert(elements,{label = k})
          end
          table.insert(elements,{label = "Done"})
          ESX.UI.Menu.Open('default', GetCurrentResourceName(), "create_house_shell",{
              title    = Labels['SetDefaultShell'],
              align    = 'center',
              elements = elements,
            }, 
            function(submitData,submitMenu)
              if submitData.current.label == "Done" then
                ShowNotification(Labels['CreationComplete'])
                submitMenu.close()
                TriggerServerEvent("Allhousing:CreateHouse",{Price = salePrice,Entry = entryLocation,Garage = garageLocation,Shell = is_shell,Interior = is_interior,Shells = shells,Doors = doors})
              else
                shells[submitData.current.label] = (not shells[submitData.current.label])
                ShowNotification(submitData.current.label..": "..(shells[submitData.current.label] == true and Labels['Enabled'] or Labels['Disabled']))
              end
            end,
            function(data,menu)
              menu.close()
            end
          )
        else
          local shell = CreateNativeUIMenu(Labels['AvailableShells'],"")
          for k,v in pairs(ShellModels) do
            shells[k] = false
            local _item = NativeUI.CreateCheckboxItem(k,false,"")
            _item.CheckboxEvent = function(a,b,checked) 
              shells[k] = checked
            end
            shell:AddItem(_item)  
          end 
          local _item = NativeUI.CreateItem(Labels['Done'],"")
          _item.Activated = function(...) 
            ShowNotification(Labels['CreationComplete'])
            _Pool:CloseAllMenus()
            TriggerServerEvent("Allhousing:CreateHouse",{Price = salePrice,Entry = entryLocation,Garage = garageLocation,Shell = is_shell,Interior = is_interior,Shells = shells,Doors = doors})
          end
          shell:AddItem(_item)
          shell:RefreshIndex()
          shell:Visible(true)     
        end
      else
        if Config.UseDoors then
          Wait(500)
          CreateDoors({Price = salePrice,Entry = entryLocation,Garage = garageLocation,Shell = is_shell,Interior = is_interior,Shells = shells,Doors = doors})
        else
          TriggerServerEvent("Allhousing:CreateHouse",{Price = salePrice,Entry = entryLocation,Garage = garageLocation,Shell = is_shell,Interior = is_interior,Shells = shells,Doors = doors})
        end
      end
    end)
  end)
end

CreateDoors = function(house)
  local elements = {
    [1] = {label = Labels['NewDoor'],value = "new"},
    [2] = {label = Labels["Done"],value="done"}
  }
  ESX.UI.Menu.Open('default', GetCurrentResourceName(), "create_house_doors",{
      title    = Labels['Doors'],
      align    = 'center',
      elements = elements,
    }, 
    function(data,menu)
      menu.close()
      if data.current.value == "done" then
        TriggerServerEvent("Allhousing:CreateHouse",house)
      else
        Wait(500)
        TriggerEvent("Doors:CreateDoors",function(creation)
          table.insert(house.Doors,creation)
          CreateDoors(house)
        end)        
      end
    end
  )
end