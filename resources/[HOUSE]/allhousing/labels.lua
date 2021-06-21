local labels = {
  ['en'] = {
    ['Entry']       = "<FONT FACE='Montserrat'>Chỗ vào",
    ['Exit']        = "<FONT FACE='Montserrat'>Thoát",
    ['Garage']      = "Garage",
    ['Wardrobe']    = "<FONT FACE='Montserrat'>Tủ quần áo",
    ['Inventory']   = "<FONT FACE='Montserrat'>Kho đồ",
    ['InventoryLocation']   = "<FONT FACE='Montserrat'>Kho đồ",

    ['LeavingHouse']      = "<FONT FACE='Montserrat'>Rời khỏi nhà",

    ['EquipOutfit']       = "Equip Outfit",
    ['DeleteOutfit']      = "Delete Outfit",
    ['LeftHouse']         = "You left the house and aborted the action.",

    ['AccessHouseMenu']   = "Truy cập menu nhà",

    ['InteractDrawText']  = "["..Config.TextColors[Config.MarkerSelection].."E~s~] ",
    ['InteractHelpText']  = "~INPUT_PICKUP~ ",

    ['AcceptDrawText']    = "["..Config.TextColors[Config.MarkerSelection].."G~s~] ",
    ['AcceptHelpText']    = "~INPUT_DETONATE~ ",

    ['FurniDrawText']     = "["..Config.TextColors[Config.MarkerSelection].."F~s~] ",
    ['CancelDrawText']    = "["..Config.TextColors[Config.MarkerSelection].."F~s~] ",

    ['VehicleStored']     = "Phương tiện được lưu trữ",
    ['CantStoreVehicle']  = "Bạn không thể cất chiếc xe này",

    ['HouseNotOwned']     = "Bạn không sở hữu ngôi nhà này",
    ['InvitedInside']     = "Chấp nhận lời mời đến nhà",
    ['MovedTooFar']       = "Bạn đã di chuyển quá xa khỏi cửa",
    ['KnockAtDoor']       = "Ai đó đang gõ cửa nhà bạn",

    ['TrackMessage']      = "Theo dõi tin nhắn",

    ['Unlocked']          = "Nhà đã mở khóa",
    ['Locked']            = "Nhà bị khóa",

    ['WardrobeSet']       = "Cài tủ quần áo",
    ['InventorySet']      = "Cài kho đồ",

    ['ToggleFurni']       = "Chuyển đổi giao diện người dùng đồ nội thất",

    ['GivingKeys']        = "Trao chìa khóa cho người chơi",
    ['TakingKeys']        = "Lấy chìa khóa từ người chơi",

    ['GarageSet']         = "Đặt vị trí nhà để xe",
    ['GarageTooFar']      = "Nhà để xe quá xa",

    ['PurchasedHouse']    = "Bạn đã mua ngôi nhà giá $%d",
    ['CantAffordHouse']   = "Bạn không đủ tiền mua căn nhà này",

    ['MortgagedHouse']    = "Bạn đã thế chấp căn nhà cho $%d",

    ['NoLockpick']        = "Bạn không có phá khóa",
    ['LockpickFailed']    = "Bạn không bẻ khóa được",
    ['LockpickSuccess']   = "Bạn đã bẻ khóa thành công",

    ['NotifyRobbery']     = "Ai đó đang cố gắng cướp một ngôi nhà tại %s",

    ['ProgressLockpicking'] = "Đang phá cửa",

    ['InvalidShell']        = "Invalid house shell: %s, please report to your server owner.",
    ['ShellNotLoaded']      = "Shell would not load: %s, please report to your server owner.",
    ['BrokenOffset']        = "Offset is messed up for house with ID %s, please report to your server owner.",

    ['UpgradeHouse']        = "Nâng cấp nhà lên: %s",
    ['CantAffordUpgrade']   = "Bạn không thể mua bản nâng cấp này",

    ['SetSalePrice']        = "Đặt giá bán",
    ['InvalidAmount']       = "Số tiền đã nhập không hợp lệ",
    ['InvalidSale']         = "Bạn không thể bán một ngôi nhà mà bạn vẫn nợ tiền",
    ['InvalidMoney']        = "Bạn không có đủ tiền",

    ['EvictingTenants']     = "Trục xuất người thuê nhà",

    ['NoOutfits']           = "Bạn không có bất kỳ trang phục nào được lưu trữ",

    ['EnterHouse']          = "Vào nhà",
    ['KnockHouse']          = "Gõ cửa",
    ['RaidHouse']           = "Nhà đột kích",
    ['BreakIn']             = "Break In",
    ['InviteInside']        = "Mời vào trong",
    ['HouseKeys']           = "Chìa khóa nhà",
    ['UpgradeHouse2']       = "Nâng cấp nhà",
    ['UpgradeShell']        = "Nâng cấp Shell",
    ['SellHouse']           = "Bán nhà",
    ['FurniUI']             = "Nội thất",
    ['SetWardrobe']         = "Cài tủ quần áo",
    ['SetInventory']        = "Cài kho đồ",
    ['SetGarage']           = "Set Garage",
    ['LockDoor']            = "Khóa nhà",
    ['UnlockDoor']          = "Mở khóa nhà",
    ['LeaveHouse']          = "Rời nhà",
    ['Mortgage']            = "Thế chấp",
    ['Buy']                 = "Mua",
    ['View']                = "Xem trước",
    ['Upgrades']            = "Nâng cấp",
    ['MoveGarage']          = "Di chuyển garage",

    ['GiveKeys']            = "Give Keys",
    ['TakeKeys']            = "Take Keys",

    ['MyHouse']             = "Nhà của bạn",
    ['PlayerHouse']         = "Nhà đã có chủ",
    ['EmptyHouse']          = "Nhà đang bán",

    ['NoUpgrades']          = "Không có bản nâng cấp nào",
    ['NoVehicles']          = "Không có xe",
    ['NothingToDisplay']    = "Chẳng có gì để trưng bày",

    ['ConfirmSale']         = "Có, bán nhà của tôi",
    ['CancelSale']          = "Không, đừng bán nhà của tôi",
    ['SellingHouse']        = "Bán nhà ($%d)",

    ['MoneyOwed']           = "Chủ nợ: $%s",
    ['LastRepayment']       = "Lần trả nợ cuối cùng: %s",
    ['PayMortgage']         = "Trả tiền thế chấp",
    ['MortgageInfo']        = "Thông tin thế chấp",

    ['SetEntry']            = "Set Entry",
    ['CancelGarage']        = "Cancel Garage",
    ['UseInterior']         = "Use Interior",
    ['UseShell']            = "Use Shell",
    ['InteriorType']        = "Set Interior Type",
    ['SetInterior']         = "Select Current Interior",
    ['SelectDefaultShell']  = "Select default house shell",
    ['ToggleShells']        = "Toggle shells available for this property",
    ['AvailableShells']     = "Available Shells",
    ['Enabled']             = "~g~ENABLED~s~",
    ['Disabled']            = "~r~DISABLED~s~",
    ['NewDoor']             = "Add New Door",
    ['Done']                = "Done",
    ['Doors']               = "Doors",
    ['Interior']            = "Interior",

    ['CreationComplete']    = "House creation complete.",

    ['HousePurchased'] = "Your house was purchased for $%d",
    ['HouseEarning']   = ", you earnt $%d from the sale."
  }
}

Labels = setmetatable({},{
  __index = function(self,k)
    if Config and Config.Locale and labels[Config.Locale] then
      if labels[Config.Locale][k] then
        return labels[Config.Locale][k]
      else
        return string.format("UNKNOWN LABEL: %s",tostring(k))
      end
    elseif labels['en'] then
      if labels[Config.Locale][k] then
        return labels[Config.Locale][k]
      else
        return string.format("UNKNOWN LABEL: %s",tostring(k))
      end
    else
      return string.format("UNKNOWN LABEL: %s",tostring(k))
    end
  end
})

