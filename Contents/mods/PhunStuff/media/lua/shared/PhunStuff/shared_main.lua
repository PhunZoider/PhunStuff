require "TsarSpawnList"
require "PhunStuff/core"

local PS = PhunStuff

local VehicleZoneDistribution = VehicleZoneDistribution or {};

if PS.settings.ATAChangeDistribution then

    if VehicleZoneDistribution.bigtrailerparkinglot and VehicleZoneDistribution.bigtrailerparkinglot.vehicles then
        VehicleZoneDistribution.bigtrailerparkinglot.vehicles["Base.TrailerTSMega"] = {
            index = -1,
            spawnChance = PS.settings.ATATrailerTSMegaSpawnChance or 1
        };
        VehicleZoneDistribution.bigtrailerparkinglot.vehicles["Base.ATAPetyarbuilt"] = {
            index = -1,
            spawnChance = PS.settings.ATAPetyarbuiltSpawnChance or 1
        };
        VehicleZoneDistribution.bigtrailerparkinglot.vehicles["Base.ATAPetyarbuiltSleeper"] = {
            index = -1,
            spawnChance = PS.settings.ATAPPetyarbuiltSleeperSpawnChance or 1
        };
        VehicleZoneDistribution.bigtrailerparkinglot.vehicles["Base.ATAPetyarbuiltSleeperLong"] = {
            index = -1,
            spawnChance = PS.settings.ATAPPetyarbuiltSleeperLongSpawnChance or 1
        };
    end
end

local oldHordeNightTick = HN_CheckSpawnHordeZombies

-- If using Horde night, do not spawn hordes inside of void/hospital

if oldHordeNightTick ~= nil then
    local OverwrittenHordeNightTick = function()
        local player = getPlayer()

        if player == nil then
            return
        end

        local data = player:getModData()
        if data and data.PhunZones and data.PhunZones.zeds == false then
            return
        end

        oldHordeNightTick()

    end

    if HN_CheckSpawnHordeZombies then
        Events.OnTick.Remove(HN_CheckSpawnHordeZombies);
        Events.OnTick.Add(OverwrittenHordeNightTick);
    end

end

local itemsToReduceFrequencyOf = {}

function PS:refillContainer(player, args)
    local square = getSquare(args.x, args.y, args.z)
    if square then
        local objs = square:getObjects()
        for i = 0, objs:size() - 1 do
            local obj = objs:get(i)
            local data = obj:getModData()
            if data and data.emptied ~= nil then
                data.emptied = 0
                local hasContainers = obj.getContainerCount and obj:getContainerCount() > 0
                local hasItemContainer = obj.getItemContainer and obj:getItemContainer()
                -- if hasItemContainer then
                --     ItemPickerJava.fillContainer(hasItemContainer, player)
                if hasContainers then
                    for i = 0, obj:getContainerCount() - 1 do
                        local container = obj:getContainerByIndex(i)
                        if container then
                            ItemPickerJava.fillContainer(container, player)
                        end
                    end
                elseif hasItemContainer then
                    ItemPickerJava.fillContainer(hasItemContainer, player)
                end

            end
        end
    end

end

function PS:refreshItemsToReduce()

    local itemsStartWith = self.settings.ExtraItemRemoverKeys
    local defaultPercent = self.settings.ExtraItemRemoverPercent
    -- Pokémon 

    local musicAlreadyAdded = {}

    local lookingFor = {
        ["pkmncards."] = 80,
        ["Book"] = 25,
        ["Plushie_"] = 50,
        ["Trolly"] = 90,
        ["Cart"] = 90,
        ["Baseball_Card"] = 80,
        ["Dance Magazine"] = 90,
        ["Vinyl"] = 90,
        ["Portable player"] = 90,
        ["Boombox"] = 90,
        ["Cassette"] = 90,
        ["Game Boy"] = 90,
        ["GameBoy"] = 90,
        ["Atari"] = 90,
        ["GameGear"] = 90,
        ["Genesis"] = 90,
        ["Sega"] = 90,
        ["Nintendo"] = 90
    }

    print("======", "Using: ", self.settings.ExtraItemRemoverKeys, "======")

    for pair in string.gmatch(self.settings.ExtraItemRemoverKeys, "([^;]+)") do
        -- Split each pair by "="
        local key, value = string.match(pair, "([^=]+)=([^=]+)")
        if key and value then
            lookingFor[key] = tonumber(value)
        end
    end

    PS:debug("======", "Looking for: ", lookingFor, "======")

    local items = getScriptManager():getAllItems()
    for i = 0, items:size() - 1 do
        local item = items:get(i)
        if item then
            local name = item.getName and item:getName()
            local shortType = tostring(item:getType())
            -- print(tostring(name), tostring(type), tostring(item:getFullName()), tostring(item:getDisplayName()))
            local fullType = item:getFullName()
            local skip = false

            if fullType then
                -- here we want to de-dupe music so we only have one in vinyl or Cassette
                if luautils.stringStarts(name, "Cassette") then
                    -- add title to musicAlreadyAdded
                    local title = string.sub(name, 9)
                    if not musicAlreadyAdded[title] then
                        musicAlreadyAdded[title] = true
                    else
                        itemsToReduceFrequencyOf[fullType] = 100
                        skip = true
                    end
                elseif luautils.stringStarts(name, "Vinyl") then
                    -- add title to musicAlreadyAdded
                    local title = string.sub(name, 6)
                    if not musicAlreadyAdded[title] then
                        musicAlreadyAdded[title] = true
                    else
                        itemsToReduceFrequencyOf[fullType] = 100
                        skip = true
                    end
                end

                if not skip then
                    -- print("checking ", tostring(fullType), tostring(shortType), tostring(name))
                    for key, value in pairs(lookingFor) do
                        if fullType and luautils.stringStarts(fullType, key) then
                            itemsToReduceFrequencyOf[fullType] = value
                        elseif shortType and luautils.stringStarts(shortType, key) then
                            itemsToReduceFrequencyOf[fullType] = value
                        elseif name and luautils.stringStarts(name, key) then
                            itemsToReduceFrequencyOf[fullType] = value
                        end
                    end
                end
            end
        end
    end

    PS:debug("======", "Items to reduce frequency of: ", itemsToReduceFrequencyOf, "======")

end

function PS:removeItemsFromContainer(container)
    local items = container and container.getItems and container:getItems()
    if items and items:size() > 0 then
        print("-------", "FILLING CONTAINER", "-------")
        for i = items:size() - 1, 0, -1 do
            local item = items:get(i)
            if item then
                print(item:getFullType())
                local chance = itemsToReduceFrequencyOf[item:getFullType()] or 0
                if chance > 0 then
                    local rand = ZombRand(100)
                    print(" - checking " .. item:getFullType() .. " with chance " .. tostring(chance) .. " and got " ..
                              tostring(rand))
                    if rand < chance then
                        container:Remove(item)
                        print(" - removed extra item " .. item:getFullType())
                    end
                end
            end
        end
    end
end

local function checkEmptyContainer(container, parent)

    local md = parent:getModData()
    local hours = PS.settings.MaxGameHoursForEmptyContainer or 0

    if hours > 0 then
        if container:isEmpty() then

            container:setExplored(true)
            container:setHasBeenLooted(true)
            if not md.emptied or md.emptied == 0 then
                md.emptied = getGameTime():getWorldAgeHours()
                parent:transmitModData()
                -- print("CHECK EMPTY CONTAINER", tostring(container.ID))
                -- print(" - empty container was not marked. Set to" .. tostring(md.emptied))
            elseif md.emptied > 0 and md.emptied + hours < getGameTime():getWorldAgeHours() then

                -- ItemPickerJava.fillContainer(container, getPlayer())
                sendClientCommand(PS.name, PS.commands.refillContainer, {
                    x = parent:getX(),
                    y = parent:getY(),
                    z = parent:getZ()
                })
                md.hadItemsRemoved = false
                md.isHasBeenLooted = false
                md.emptied = 0
                parent:transmitModData()
                -- print("CHECK EMPTY CONTAINER", tostring(container.ID))
                -- print(" - empty container expired. Filled")
            end
        elseif md.emptied then
            md.emptied = nil
            parent:transmitModData()
            -- print("CHECK EMPTY CONTAINER", tostring(container.ID))
            -- print(" - empty container was marked but not empty. Cleared")
        end
    end

end

function PS:checkRemoveItems(inventoryPage)

    local containers = {}

    for i, v in ipairs(inventoryPage.backpacks) do

        local container = nil
        local parent = v.inventory:getParent()

        if parent then
            if v.inventory:getVehiclePart() then
                local part = v.inventory:getVehiclePart();
                if part:getItemContainer() then
                    -- checkEmptyContainer(part:getItemContainer(), parent)
                    -- container = part:getItemContainer();
                end
            elseif instanceof(parent, "IsoDeadBody") or not parent.getContainer or not parent.getItemContainer then
                parent = nil
            else
                if parent.getContainerCount then
                    for i = 0, parent:getContainerCount() - 1 do
                        checkEmptyContainer(parent:getContainerByIndex(i), parent)
                    end
                else
                    checkEmptyContainer(parent:getItemContainer(), parent)
                end
            end
        end

    end

end
