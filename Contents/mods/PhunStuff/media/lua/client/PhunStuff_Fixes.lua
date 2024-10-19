Events.OnGameStart.Add(function()

    if RadioWavs and SandboxVars.PhunStuff.FixCedarHillRadioText then

        -- remove original
        Events.OnDeviceText.Remove(RadioWavs.OnDeviceText)
        function RadioWavs.OnDeviceText(_guid, _interactCodes, _x, _y, _z, _line)
            local radio = nil;

            -- HOTFIX: Check game version
            --      > If using a version prior to 41.69, then use the old function parameters
            --      > This prevents errors when using stable versus beta branch
            local gameVersion = tonumber(tostring(getCore():getGameVersion()))
            local minVersion = 41.69
            if gameVersion <= minVersion then
                local swap1 = _guid
                local swap2 = _interactCodes
                local swap3 = _x
                local swap4 = _y
                local swap5 = _z
                local swap6 = _line
                _interactCodes = swap1
                _x = swap2
                _y = swap3
                _z = swap4
                _line = swap5
                radio = swap6
            end

            local codes = RadioWavs.split(_interactCodes, ",")

            -- Radio Device: Walkie Talkie
            if radio == nil then
                if (_x == -1 and _y == -1 and _z == -1) then
                    local player = getSpecificPlayer(0)
                    if player and player:isDead() then
                        player = nil
                    end
                    if player ~= nil then
                        local items = player:getInventory():getItems();
                        for i = 0, items:size() - 1 do
                            local item = items:get(i);
                            if instanceof(item, "Radio") and item:getDeviceData() ~= nil then
                                radio = item
                            end
                        end
                    end
                end
            end

            -- Radio Device: Portable/HAM radio, television, or vehicle radio
            if radio == nil then
                local sq = getCell():getGridSquare(_x, _y, _z);
                if sq then
                    for i = 0, sq:getObjects():size() - 1 do
                        local item = sq:getObjects():get(i);
                        -- Portable/HAM radio or television
                        if instanceof(item, "IsoRadio") or instanceof(item, "IsoTelevision") and item:getDeviceData() ~=
                            nil then
                            radio = item
                            break
                        end

                        -- Vehicle radio
                        if instanceof(item, "IsoObject") then
                            local vehicle = sq:getVehicleContainer()
                            if vehicle then
                                local part = vehicle:getPartById("Radio");
                                if part and part:getDeviceData() then
                                    radio = part
                                    break
                                end
                            end
                        end
                    end
                end
            end

            -- If device not found (hopefully this never happens) exit out with error notice
            if radio == nil then
                print("RadioWavs mod ERROR: OnDeviceText() could not find radio device")
                return
            end

            for _, _v in ipairs(codes) do
                if _v:len() > 4 then
                    local code = string.sub(_v, 1, 3)
                    local op = string.sub(_v, 4, 4)
                    local amount = tonumber(string.sub(_v, 5, _v:len()))
                    if op == "-" then
                        amount = -amount
                    end
                    if amount ~= nil and amount > 0 and code == "DRU" then
                        RadioWavs.PlaySound(amount, radio)
                    end
                end
            end
        end
        -- add fixed
        Events.OnDeviceText.Add(RadioWavs.OnDeviceText)

    end

end)

