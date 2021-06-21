local warnList, ready = {}, false

local function ReloadWarnings()
    local rows = MySQL.Sync.fetchAll('SELECT * FROM `esx_manager_warns`')
    for _, row in pairs(rows) do
        warnList[tostring(row.id)] = row
    end
    ready = true
end

local function InsertWarning(identifier, name, reason)
    local insertData = MySQL.Sync.fetchAll('INSERT INTO `esx_manager_warns` (`warned`, `reason`, `date`) VALUES(@w, @r, @d)',{
        ['@w'] = identifier,
        ['@n'] = name,
        ['@r'] = reason,
        ['@d'] = os.date("!%Y-%m-%dT%H:%M:%SZ")
    })
    ReloadWarnings()
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

function WarnPlayer(source, reason)
    if GetPlayerPing(source) ~= nil then
        return true, InsertWarning(GetIdentifier(source), GetPlayerName(source), reason)
    end
    return false
end

function RemoveWarning(warningId)
    if warnList[tostring(warningId)] then
        MySQL.Sync.execute('DELETE FROM `esx_manager_warns` WHERE `id` = @id', {
            ['@id'] = tonumber(warningId)
        })
        warnList[tostring(warningId)] = nil
        collectgarbage "collect"
        return true
    end
    return false
end

function GetWarnList(source)
    if not source then
        return warnList
    else
        local warns = {}
        local identifier = GetIdentifier(source)
        for _, warn in pairs(warnList) do
            if warn.identifier == identifier then
                table.insert(warns, warn)
            end
        end
        return warns
    end
end