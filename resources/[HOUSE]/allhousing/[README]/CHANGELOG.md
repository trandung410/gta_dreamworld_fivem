# 22/03/2020
- Fix for Config.PoliceCanRaid option not effecting anything.

# 23/02/2020
- Fix for some vehicles with odd plates not being stored correctly.
  ## CHANGED FILES: 
    - src/client/functions.lua
      - function GetVehicleProperties

- Releasing of anim dicts that where staying loaded.
  ## CHANGED FILES:
    - src/client/menus/menus.lua
      - function KnockOnDoor
      - function BreakInHouse

- Fix for people with keys unable to access wardrobe.
  ## CHANGED FILES:
    - src/client/menus/menus_esx.lua
      - function ESXMenuHandler
    - src/client/menus/menus_native.lua
      - function NativeUIHandler

- Fix for non player vehicles being deleted when stored at garage.
  ## CHANGED FILES:
    - src/client/main.lua
      - function RenderExterior

- Added config option to store other players vehicles (stolen) at your house.
  ## CHANGED FILES:
    - src/server/main.lua
      - function GetVehicleOwner
    - src/client/main.lua
      - function RenderExterior

- Fix for items with -1 limit unable to be removed from inventory.
  ## CHANGED FILES:
    - src/server/framework/framework_functions.lua
      - function CanPlayerCarry


# 27/03/2020
- Sql query efficiency updates.
  ## CHANGED FILES:
    - src/server/main.lua
      - function GetInventory
      - function GetVehicles

- Exposed purchase house function (for all of you using weird currency systems).
  ## CHANGED FILES:
    - src/server/main.lua
      - function PurchaseHouse

- Added GetCharacterName function
  ## CHANGED FILES:
    - src/server/framework/framework_functions.lua
      - function GetCharacterName

- Added "Id", "ResaleJob" and "OwnerName" keys to house tables.
  ## CHANGED FILES:
    - none.

- Added config options for society accounts for realestate jobs (any creation job, actually).
  ## CHANGED FILES:
    - src/config.lua

- Added function to add money to society account.
  ## CHANGED FILES:
    - src/server/framework/framework_functions.lua
      - function AddSocietyMoney

- Added columns to allhousing database table.
  ## CHANGED FILES:
    - allhousing.sql
      - ownername varchar
      - resalejob varchar

- Changed storedhouse database value type from longtext to int(11) NOT NULL in owned_vehicles.
  ## CHANGED FILES:
    - none.

- Changed storing of vehicle passing house Id instead of garage location.
  ## CHANGED FILES:
    - src/client/main.lua
      - function RenderExterior

- Maybe some other things I've forgot to log. Good luck.

# 27/03/2020
- Forgot to remove auto incriment and key value from database table, column `id`.
- Make sure you also do this among other database table changes.

# 29/03/2020
- Fix for players stuck at door if they don't have a lockpick.
  ## CHANGED FILES:
    - src/client/functions.lua
      - function GoToDoor

- Added menu for sale confirmation.
  ## CHANGED FILES:
    - src/client/menus/menus.lua
      - function SellHouse
    - src/client/menus/menus_esx.lua
      - function ESXConfirmSaleMenu
    - src/client/menus/menus_native.lua
      - function NativeConfirmSaleMenu

- Added unlock door option (must be triggered by server owner, reset every server restart).
  ## CHANGED FILES:
    - src/client/menus/menus.lua
      - function UnlockDoor
      - function LockDoor
    - src/client/menus/menus_esx.lua
      - Many changes. Use beyond compare or some other text comparer to check this one out.
    - src/client/menus/menus_native.lua
      - Many changes. Use beyond compare or some other text comparer to check this one out.

- Added support for KAMBI new shells
  ## CHANGED FILES:
    - src/houses.lua

- Changed ipairs to pairs (incase a key is missing from database).
  ## CHANGED FILES:
    - src/client/main.lua
      - function Sync
    - src/client/functions.lua
      - function RefreshBlips

- Changed GetVehicleProperties function to call ESX.Game.GetVehicleProperties if using ESX.
  ## CHANGED FILES
    - src/client/functions.lua
      - function GetVehicleProperties

- Added police tracking for lockpicking fail alert.
  ## CHANGED FILES
    - src/client/framework/framework_functions.lua
      - function NotifyJob
    -src/server/framework/framework_functions.lua
      - function NotifyJobs

- Added config option for people wanting interactsound alarm on lockpick fail back in their life.
  ## CHANGED FILES
    - src/config.lua
    - src/client/menus/menus.lua
      - function BreakInHouse

- Added notifications for receiving/losing house keys
  ## CHANGED FILES
    - none

- Players who are inside a house during selling/upgrading process are dealt with correctly.
  ## CHANGED FILES
    - src/client/main.lua
      - function Boot
    - src/client/menus/menus.lua
      - function UpgradeHouse

- Vehicle props saved on storage.
  ## CHANGED FILES
    - src/server/main.lua
      - function VehicleStored

- Better syncing of houses.
  ## CHANGED FILES
    - src/client/main.lua
      - function SyncHouse

- Some other efficiency updates that I lost track of changes made to.
- Mostly made in src/client/main.lua, src/client/menus/menu.lua, src/client/functions.lua

# 29/03/2020 #2
- Fix for houses that have just been created where not showing up immediately as a result of the new syncing function.
  ## CHANGED FILES
    - src/client/main.lua
      - function SyncHouse

# 5/04/2020
- Cleaned up distance checking, cutting MS usage.
  ## CHANGED FILES
    - src/client/main.lua
      - function RenderExterior
      - function RenderInterior

- Added config option to sleep after distance check.
  ## CHANGED FILES
    - config.lua

- Fix for error on upgrading house.
  ## CHANGED FILES
    - src/client/menus/menus.lua
      - function UpgradeHouse

# 15/04/2020
- Added InventoryRaiding config option.
  ## CHANGED FILES
    - config.lua
    - src/client/menus/menus.lua
      - function RaidHouse

- Fix for pearlescent colors messing up on garage withdrawal.
  ## CHANGED FILES
    - src/client/functions.lua
      - function SetVehicleProperties

- ADDITIONAL NOTE:
Old-style disc inventoryhud functions have been added just incase somebody might want to use them.
This inventory hud is not supported in any way, and bugs found while using this inventory must be dealt with yourself.
As it is not supported as standard, config options must be added in order for it to be used.
Add the following in the config.lua file, inside the Config table:
  UsingDiscInventory = true,
  DiscInventorySlots = 20,

# 18/04/2020
- Added config option to disable selling houses for players.
  ## CHANGED FILES
    - config.lua
    - src/client/menus/menus_esx.lua
      - ESXEntryOwnerMenu
      - ESXExitOwnerMenu
    - src/client/menus/menus_native.lua
      - NativeEntryOwnerMenu
      - NativeExitOwnerMenu

- Added ability for police to unlock houses once inside (to allow lower ranking police inside).
  ## CHANGED FILES
    - src/client/menus/menus_esx.lua
      - NativeExitEmptyMenu
    - src/client/menus/menus_native.lua
      - ESXExitEmptyMenu 

# 25/04/2020
- Fix for DrawText3D dissapearing randomly?
  ## CHANGED FILES
    - src/client/functions.lua
      - DrawText3D

# 3/05/2020
- Fix for HouseTheft config var not having effect in-game.
  ## CHANGED FILES
    - src/client/menus/menus_esx.lua
      - ESXEntryOwnedMenu
- Added global shell spawn location offset modifier to config.
  ## CHANGED FILES
    - src/config.lua
    - src/client/menus/menus.lua
      - TeleportInside
      - SpawnHouse
      - SetInventory
      - SetWardrobe
    - src/client/main.lua
      - RenderInterior
- Added "Allhousing:Relog" event.
  ## CHANGED FILES
    - src/client/main.lua
- Added config option for vSync users.
  ## CHANGED FILES
    - src/config.lua
    - src/client/functions.lua
      - SetWeatherAndTime    
- Added SOME_EXTRA_INFO file.

# 4/05/2020
- Freeze player position when interacting with ESX menu.
  ## CHANGED FILES
    - src/client/menus/menus_esx.lua
      - ESXMenuHandler
      - ESXEntryOwnerMenu
      - ESXEntryOwnedMenu
      - ESXEntryEmptyMenu
      - ESXGarageOwnerMenu
      - ESXGarageOwnedMenu

- Fix for 3d text dissapearing again...
  ## CHANGED FILES
    - src/client/functions.lua
      - DrawText3D

- Added debug notification when players might get stuck loading into a house.
  ## CHANGED FILES
    - src/client/menus/menus.lua
      - TeleportInside
      - SpawnHouse

- Force recalculation of nearest house after purchase/sale.
  ## CHANGED FILES
    - src/client/main.lua
      - SyncHouse

# 11/05/2020
- Fix for NativeUI not opening garage with owned keys.
  ## CHANGED FILES
    - src/client/menus/menus_native.lua

- Surrendered to 3D text oddities, added old DrawText3D function.
  ## CHANGED FILES
    - src/client/functions.lua
      - DrawText3D


# 2/06/2020
- Added more offsets for KAMBI's shells.
  ## CHANGED FILES
    - src/houses.lua

# 10/07/2020
- Added more offsets for KAMBI's shells.
  ## CHANGED FILES
    - src/houses.lua

- Fix for input mod not calling back correctly.

# 13/07/2020
- Fix for input mod not calling back correct data.

# 17/07/2020
- Update to auth/credentials system.

# 22/07/2020
- Added basic mortgage.
  * Requires new SQL columns. Observe SQL file provided.
  * Check config for options. Search "mortgage" in config.lua.

  NOTE: House can only be mortgaged if a realtor/one of the "creation jobs" from the config.lua created the house.
  The realtor will be responsible for checking up on the tenants payment status by approaching the front door and selecting the "mortgage info" option from the menu.
  If the realtor deems the player has gone too long without making a repayment, they can evict the tenant from the house.
  Players can make repayments to their mortgage from the mortgage menu, accessed at the front door menu inside the house.

- Added ability for house owners to move the garage position.

# 23/07/2020
- Fix for all the changes not working.
- Forgot to include new server.lua file.

# 26/07/2020
- Fix for societies not receiving money.
- Fix for offline players not receiving money.

# 5/08/2020
- Add missing "Break In" option in menu.
- Fixed HOW_TO_DELETE_HOUSES.md guide.

# 24/08/2020
- Added MLO & doors support.
- Added string labels/translation file.
- Added "Controls" table in config.lua.
- NOTE: Added sql columns:
  `interior` varchar(50) NOT NULL,
  `doors` longtext DEFAULT NULL,
  All longtext values have been changed to default NULL, you will have to do the same.
  
# 27/08/2020
- Added commenting to config.lua regarding mlo/doors.
- Removed props from vehicle update query during vehicle storage.
- Removed exit menu marker/3d text while using interior/mlo.

# 30/08/2020
- Added kash ID to callback.

# 31/08/2020
- Refactor client/main.lua, fixing several bugs added since MLO/doors support.

# 31/08/2020
- Fix for storing vehicles freezing the player.
- Fix for entering interior/MLO changing weather/time.
- Fix for Config.TextDistance3D not effecting draw distance.

# 3/09/2020
- Change inventory and furniture syncing methods, reducing memory comsumption across all clients.
- Fix for players with keys to a house not able to store vehicles in the garage.
- Fix for PoliceCanRaid and InventoryRaiding Config vars having no effect.

# 10/09/2020
- Fix for players being able to store vehicles in the garage of houses they don't have access to.
- Fix for invite inside prompt displaying wrong hotkey on notification.

# 10/09/2020 #2
- Fix brought/bought...
- Fix for vehicle native using incorrect ped var.

# 12/09/2020
- Change Labels table to metatable with index error fallback.

# 23/09/2020
- Fix for creating houses with NativeUI.
- Fix for created MLO houses not allowing menu access.
- Add config option for max number of player houses.
- Add ability to remove outfits from wardrobe.
- Error check for setting wardrobe and inventory if player leaves house.

# 26/09/2020
- Fix ESX outfit menu being broken last update...

# 1/10/2020
- Added config option to use MLO/interior name hashes instead of interior ID, hopefully solving the issue of MLO houses unable to be interacted with after server restart.

# 20/12/2020
- Fix for incorrect xPlayer call.