local HERE = GetCurrentResourceName()
local _print = assert(print)
_G.ready, _G.IN_DEV_MODE = false, (GetResourceMetadata(HERE, 'debug_mode', 0) == 'yes')

function print(...)
    if IN_DEV_MODE then
        _print('['..HERE..':WEB:DEBUG]:', ...)
    end
end

local function Unauthorized(response, request)
    response.writeHead(401, {['Cache-Control']="no-store, must-revalidate", ['WWW-Authenticate']="Basic Realm=\"FiveM 5M ADMIN\""})
    sendFile(request, response, 'unauthorized')
end

MySQL.ready(function()
    ready = true
    print('Database loaded!')
    print('Listening on http://your-server-ip:port/admin')
end)

SetHttpHandler(function(request, response)
    --[[
    request #1:
        - @method setCancelHandler
        - @method setDataHandler
        - @string address
        - @table headers
        - @string method
        - @string path
    response #2:
        - @method write
        - @method send
        - @method writeHead
    ]]

    if ready == false then response.writeHead(403); response.send 'Loading...'; return end

    print('Requested', request.method, request.path, request.address)
    --print('Headers', json.encode((request.headers)))

    if request.headers['Authorization'] == nil then
        return Unauthorized(response, request)
    else
        local user, pass = ParseUserPass(request.headers['Authorization'])
        print('Login credentials', user, pass)
        if not CanLogin(user, pass) then
            print('Unauthorized access from', request.address)
            return Unauthorized(response, request)
        end
    end

    -- MANAGE GET REQUESTS
    if request.method == 'GET' and request.path ~= '/updates' then
        if request.path == '/' then sendFile(request, response, 'index')
        else sendFile(request, response, request.path) end
    -- MANAGE CLIENTS
    elseif request.path == '/updates' then
        HeartbeatFromClient(request, response)
    -- MANAGE POST REQUESTS
    elseif request.method == 'POST' then
        response.send( API(request, response) )
    end

    return -- close the connection
end)