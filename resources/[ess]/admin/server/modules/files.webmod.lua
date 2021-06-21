local HERE = GetCurrentResourceName()
local cachedFiles = {
    ['error'] = LoadResourceFile(HERE, 'html/error.html')
}

local function getFile(fileName)
    print('Get file', fileName)
    if cachedFiles[fileName] ~= nil then
        return cachedFiles[fileName]
    else
        local fileString = LoadResourceFile(HERE, 'html/'..fileName)
        if not fileString then
            return cachedFiles['error'], 404
        end
        if not IN_DEV_MODE then cachedFiles[fileName] = fileString end
        return fileString
    end
    return '', 404
end

local function ensureFileName(rawName)
    rawName = rawName:trim(); rawName = rawName:lower();
    if rawName:startsWith('/') then rawName = rawName:sub(2) end
    local splitted = table.build( rawName:split('%.') )
    local fileName = tostring(splitted[1]); table.remove(splitted, 1);
    local fileExt = (#splitted == 0 and 'html' or table.concat(splitted, '.'))
    return fileName, fileExt
end

local function getMIMEtype(fileExt)
    if fileExt:endsWith "html" then return "text/html"
    elseif fileExt:endsWith "css" then return "text/css"
    elseif fileExt:endsWith "js" then return "application/javascript"
    elseif fileExt:endsWith "json" then return "application/json"
    elseif fileExt:endsWith "ico" then return "image/x-icon"
    end
    return "text/plain"
end

function sendFile(req, res, file)
    local fileName, fileExt = ensureFileName(file)
    local fileString, status = getFile(fileName .. '.' .. (fileExt or 'html'))
    res.writeHead(status or 200,
        {["Content-Type"]=getMIMEtype(fileExt)})
    res.send(fileString)
end