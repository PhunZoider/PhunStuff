if not isServer() then
    return
end

local PhunStuff = PhunStuff

PhunTools:RunOnceWhenServerEmpties("PhunStuff", function()
    PhunStuff:logMemoryStuff()
end)
Events.OnClientCommand.Add(function(module, command, playerObj, arguments)
    if module == "PhunStuff" then
        if command == "mem" then
            PhunStuff:logMemoryStuff()
        end
    end
end)
