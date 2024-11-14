Events.OnPreFillWorldObjectContextMenu.Add(function(playerObj, context, worldobjects, test)

    local player = getSpecificPlayer(playerObj);
    if player and isAdmin() then
        context:addOption("PhunStuff: Log Memory", player, function()
            sendClientCommand(player, "PhunStuff", "mem", {})
            PhunStuff:logMemoryStuff()
        end)
    end

end);
