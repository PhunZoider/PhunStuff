local itemOverides = {
    ["Base.GoldBar"] = {
        Category = "Currency",
        DisplayCategory = "Currency"
    }
}

local tweakRecipees = function()

    local recipeTweaks = PhunStuff.recipeOverrides
    if recipeTweaks == nil or #recipeTweaks == 0 then
        return
    end

    local recipes = getScriptManager():getAllRecipes()
    for i = 1, recipes:size() do
        local recipe = recipes:get(i - 1)
        if recipeTweaks[recipe:getName()] then
            local item = recipeTweaks[recipe:getName()]
            if item.disabled then
                print("Disabling recipe: " .. recipe:getName())
                recipe:setIsHidden(true)
                recipe:setNeedToBeLearn(true)
            elseif item.fnCarSpawn then
                -- overrides the recipe to spawn a car instead of crafting it
                _G[item.fn] = function(items, result, player)
                    if isClient() then
                        local building = player:getBuilding()
                        if building then
                            player:Say("You cannot craft a car inside a building.")
                            player:getInventory():AddItems("Pearls", item.pearls)
                        end
                        sendClientCommand("PhunStuff", "SpawnCar", {
                            x = player:getX(),
                            y = player:getY(),
                            type = item.type
                        })
                    else
                        local square = player:getSquare()
                        addVehicleDebug(item.type, IsoDirections.E, nil, square.x, square.y, 0)
                    end
                end

            elseif item.fn then
                _G[item.fn] = item.fn
            end
        end
    end
end

local tweakItems = function()

    local itemTweaks = PhunStuff.itemOverrides

    for k, v in pairs(itemTweaks) do
        local item = ScriptManager.instance:getItem(k);
        if item ~= nil then
            for k2, v2 in pairs(v) do
                print("Tweaking " .. k .. " " .. k2 .. " to " .. v2)
                if k2 == "Condition" then
                    item:setCondition(v2);
                else
                    -- item[k2] = v2
                    item:DoParam(k2 .. " = " .. v2);
                end
            end
        end
    end
end

Events.OnGameBoot.Add(tweakItems)
Events.OnGameStart.Add(tweakRecipees)

