_G.APIcalls = {}

local function ensureCall(path)
    path = path:trim()
    if path:startsWith('/') then path = path:sub(2) end
    return path
end

local function getBody(request)
    local p = promise.new()
    request.setDataHandler(function(body)
        local data = json.decode(body)
        p:resolve(data)
    end)
    return Citizen.Await(p)
end

function API(request, response)
    local call = ensureCall(request.path)
    print('Request API', call)
    if APIcalls[call] then
        return json.encode( APIcalls[call](getBody(request)) )
    end
    return '{}'
end