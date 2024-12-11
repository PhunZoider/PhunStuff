if not isClient() then
    return
end

-- local function showWelcome(playerIndex, playerObj)

--     local settings = ModData.getOrCreate("PhunStuff")
--     if settings.skipExitConfirmation ~= true then
--         PhunStuffUIWelcome.OnOpenPanel(playerIndex, playerObj)
--     end

-- end

-- Events.OnCreatePlayer.Add(showWelcome)

Events[PhunZones.events.OnPhunZoneWidgetClicked].Add(function(player)
    PhunStuffUIWelcome.OnOpenPanel(player:getPlayerNum(), player)
end)

