local RegisteredUsers = {}

function ParseUserPass(basic)
    local authorizationCode = basic:sub(string.len('Basic ')+1)
    return table.unpack( table.build( Base64.decode(authorizationCode):split(":") ) )
end

function AddUser(username, password)
    RegisteredUsers[username] = password
end

function user(username)
    return {
        password = function(_, password)
            AddUser(username, password)
        end
    }
end

function CanLogin(user, password)
    if RegisteredUsers[user] == password then
        return true
    end
    return false
end
