if isClient() then
    return
end

local PS = PhunStuff

Events.OnFillContainer.Add(function(roomtype, containertype, container)
    PS:removeItemsFromContainer(container)
end);

Events.OnGameBoot.Add(function()
    PS:tweakItems()
end)
Events.OnServerStarted.Add(function()
    PS:tweakRecipees()
    PS:refreshItemsToReduce()
    PS:calculateDawnDusk()
end)

local climateManager
local gt
local duskTime
local dawnTime
local lastTime = 0
local isNight = nil
Events.EveryHours.Add(function()
    PS:calculateDawnDusk()
end)

Events.OnServerStarted.Add(function()
    PS:calculateDawnDusk()
end)
Events.EveryDays.Add(function()
    print("EveryDays")
    PS:calculateDawnDusk()
end)

Events.EveryOneMinute.Add(function()
    PS:setIsNight()
end)

Events.OnClientCommand.Add(function(module, command, playerObj, arguments)
    if module == "PhunStuff" then
        if command == "mem" then
            PS:logMemoryStuff()
        elseif command == PS.commands.onStart then
            if isNight == true then
                sendServerCommand(playerObj, PS.name, PS.commands.nightTimeStart, {})
            elseif isNight == false then
                sendServerCommand(playerObj, PS.name, PS.commands.daytimeStart, {})
            end
        elseif command == PS.commands.refillContainer then
            PS:refillContainer(playerObj, arguments)
        elseif command == "empty" then
            local data = ModData.getOrCreate("PhunStuffEmpties")
            if not data[arguments.id] then
                data[arguments.id] = {
                    when = getGameTime():getWorldAgeHours()
                }
            end
            if data[arguments.id].when + 24 < getGameTime():getWorldAgeHours() then
                data[arguments.id] = nil
                sendServerCommand(playerObj, "PhunStuff", "empty", {
                    id = arguments.id
                })
            end
        end
    end
end)

if SapphOnEat_CheckNaN then
    function SapphOnEat_CheckNaN(food, player, percent)
        local CalorieValue = player:getNutrition():getCalories();
        if CalorieValue == nil then
            player:getNutrition():setCalories(400);
            player:getNutrition():setProteins(50);
            player:getNutrition():setCarbohydrates(300);
            player:getNutrition():setLipids(200);
        end
    end
end

