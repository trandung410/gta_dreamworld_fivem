function ParseUserPass(basic)
    local authorizationCode = basic:sub(string.len('Basic ')+1)
    return table.unpack( table.build( Base64.decode(authorizationCode):split(":") ) )
end

function CanLogin(user, password)
    -- database check user and pass
    if user == "admin" and password == "admin" then
        return true
    end
    return false
end
