local MySQL = assert(MySQL, 'no MySQL imported')
local banList, ready = {}, false

local function LoadBannedPlayers()
    local rows = MySQL.Sync.fetchAll('SELECT * FROM `esx_manager_bans`')
    if #rows then
        for _, row in pairs(rows) do
            banList[row.identifier] = {name=row.name, reason=row.reason}
        end
    end
    ready = true
end

local function InsertBan(identifier, name, reason)
    MySQL.Sync.execute('INSERT INTO `esx_manager_bans` (`identifier`, `name`, `reason`) VALUES(@identifier, @name, @reason)', {
        ['@identifier'] = identifier,
        ['@name'] = name,
        ['@reason'] = reason
    })
    banList[identifier] = {name = name, reason = reason}
end

local function DeleteBan(identifier)
    MySQL.Sync.execute('DELETE FROM `esx_manager_bans` WHERE `identifier` = @identifier)', {
        ['@identifier'] = identifier
    })
    banList[identifier] = nil
    collectgarbage "collect"
end

local function GetIdentifier(source)
    source = tostring(source)
    for i=0, GetNumPlayerIdentifiers(source), 1 do
        local identifier = GetPlayerIdentifier(source, i)
        if identifier ~= nil and identifier:startsWith("license") then
            return identifier
        end
    end
    print('Fail GetIdentifier', source, type(source))
end

function IsPlayerBanned(source)
    if not ready then LoadBannedPlayers() end
    return banList[GetIdentifier(source)]
end

function IsIdentifierBanned(identifier)
    if not ready then LoadBannedPlayers() end
    return banList[identifier]
end

function BanPlayerById(source, reason)
    if GetPlayerPing(source) ~= nil and not IsPlayerBanned(source) then
        InsertBan(GetIdentifier(source), GetPlayerName(source), reason)
        return true
    end
    return false
end

function UnbanPlayerById(source)
    if GetPlayerPing(source) ~= nil and IsPlayerBanned(source) then
        DeleteBan(GetIdentifier(source))
        return true
    end
    return false
end

function GetBanList()
    if not ready then LoadBannedPlayers() end
    return banList
end