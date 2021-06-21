_G.clients = {}

function HeartbeatFromClient(request, response)
    print('Heartbeat from client', request.address)
    response.writeHead(200, {["Content-Type"]="text/event-stream"})
    response.write('data: '.. json.encode({players = GetOnlinePlayerList()}) ..'\n\n')
    if clients[request.address] == nil then
        clients[request.address] = response
        request.setCancelHandler(function(...)
            print('Client disconnected')
            clients[request.address] = nil
        end)
        CreateThread(function()
            local add = request.address
            local response = clients[add]
            while clients[add] ~= nil do
                response.write('data: '.. json.encode({players = GetOnlinePlayerList()}) .. '\n\n')
                print('Sent heartbeat to', add)
                Wait(25 * 1000)
            end
        end)
    end
end
