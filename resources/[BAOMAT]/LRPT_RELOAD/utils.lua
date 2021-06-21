function CheckIdentifiers(iden, type)
    if iden ~= nil then 
        for i = 1, #rt.banList, 1 do 
            if rt.banList[i][type] ~= nil then 
                if rt.banList[i][type] == iden then 
                    return true
                end
            end
        end
        return false
    else 
        return true
    end
end

