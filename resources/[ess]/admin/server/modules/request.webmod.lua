local encode = assert(json.encode)
local decode = assert(json.decode)
_G.request = {}

function request.get(url, body, headers)
    assert(type(url) == 'string', 'invalid argument #1')
    assert(type(body or {}) == 'table', 'invalid argument #2')
    assert(type(headers or {}) == 'table', 'invalid argument #3')

    local result = promise.new()
    url = url:trim()
    headers = headers or {}
    headers['Content-Type'] = 'application/json;charset=utf8'

    PerformHttpRequest(url, function(status, response, head)
        result:resolve({status, response, head})
    end, 'GET', encode(body), headers)

    return table.unpack(Citizen.Await(result))
end

function request.post(url, body, headers)
    assert(type(url) == 'string', 'invalid argument #1')
    assert(type(body or {}) == 'table', 'invalid argument #2')
    assert(type(headers or {}) == 'table', 'invalid argument #3')

    local result = promise.new()
    url = url:trim()
    headers = headers or {}
    headers['Content-Type'] = 'application/json;charset=utf8'

    PerformHttpRequest(url, function(status, response, head)
        result:resolve({status, response, head})
    end, 'POST', encode(body), headers)

    return table.unpack(Citizen.Await(result))
end