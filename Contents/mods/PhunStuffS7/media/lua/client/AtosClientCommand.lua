if not isClient() then
    return
end

if AtosRadiatedZones then

    Events.OnGameStart.Add(function()

        local AtosClient = AtosRadiatedZones.Client

        local originalSetZones = AtosRadiatedZones.Client.setZones
        function AtosClient:setZones(paramZones)
            originalSetZones(self, {{{8490, 8672}, {12373, 12550}}})
        end

        AtosClient:setZones({{{8490, 8672}, {12373, 12550}}})
    end)
end
