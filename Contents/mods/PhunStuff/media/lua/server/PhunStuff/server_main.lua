local PS = PhunStuff
local oldfn = nil
if OnEat_Zomboxivir then

    oldfn = OnEat_Zomboxivir;
    function OnEat_Zomboxivir(food, player, percent)
        if not food:isRotten() then
            local bodyDamage = player:getBodyDamage();
            local wasInfected = bodyDamage:getInfectionLevel() > 0;
            oldfn(food, player, percent);
            bodyDamage = player:getBodyDamage();
            if wasInfected and bodyDamage:getInfectionLevel() == 0 then
                player:Say(getText("IGUI_ItemSuccessAmpule_" .. ZombRand(1, 4)));
            end
        else
            if isClient() then
                getPlayer():Say(getText("IGUI_ItemRottenAmpule"));
            end
        end
    end
else
    -- probably running on server?
    -- create a stub so we dont get error on server
    OnEat_Zomboxivir = function(food, player, percent)

    end
end

if OnEat_Alcohol then
    local oldEatAlcohol = OnEat_Alcohol;
    function OnEat_Alcohol(food, player)
        -- print("DT Logger: running OnEat_Alcohol");
        -- print("Hunger change for: " .. food:getDisplayName() .. " is: " .. (food:getHungerChange() * 100) * -1)
        -- print("Thirst change for: " .. food:getDisplayName() .. " is: " .. (food:getThirstChange() * 100) * -1)
        local hungerChangeOverdose = food:getHungerChange() * 100 * -1;
        local thirstChangeOverdose = food:getThirstChange() * 100 * -1;

        if DTOverdose then
            -- OVERDOSE MECHANIC
            DTOverdose.overdoseIncrease(player, hungerChangeOverdose + thirstChangeOverdose);
        end

        -- ALCOHOLIC TRAIT
        -- print("DT Logger: DTalcoholicTrait value is " .. player:getModData().DTalcoholicTrait);
        -- print("DT Logger: DTtimeSinceLastDrink value is " .. player:getModData().DTtimeSinceLastDrink);
        player:getModData().DTalcoholicTrait = player:getModData().DTalcoholicTrait - (food:getHungerChange() * 1000) *
                                                   -1;
        player:getModData().DTalcoholicTrait = player:getModData().DTalcoholicTrait - (food:getThirstChange() * 1000) *
                                                   -1;
        player:getModData().DTalcoholicTrait = player:getModData().DTalcoholicTrait - (food:getAlcoholPower() * 100)
        -- print("Alcohol power for: " .. food:getDisplayName() .. " is: " .. (food:getAlcoholPower() * 100))
        player:getModData().DTtimeSinceLastDrink = 0;
        -- print("DT Logger: DTalcoholicTrait value is " .. player:getModData().DTalcoholicTrait);
        -- print("DT Logger: DTtimeSinceLastDrink value is " .. player:getModData().DTtimeSinceLastDrink);
    end
end

function PhunStuffGoldCrafting_OnCreate(items, result, player)
    local chance = ZombRand(1, 100)

    if chance < 50 then
        player:getInventory():AddItems("GoldScraps", ZombRandBetween(1, 3))
    else
        player:getInventory():AddItems("GoldScraps", 1)
    end
end

function PhunStuffGemCrafting_OnCreate(items, result, player)
    local chance = ZombRand(1, 100)

    if chance < 50 then
        player:getInventory():AddItems("GemScrap", ZombRandBetween(1, 3))
    else
        player:getInventory():AddItems("GemScrap", 1)
    end
end

function PhunStuffSilverCrafting_OnCreate(items, result, player)
    local chance = ZombRand(1, 100)

    if chance < 50 then
        player:getInventory():AddItems("SilverScraps", ZombRandBetween(1, 3))
    else
        player:getInventory():AddItems("SilverScraps", 1)
    end
end

local allRecipes = getAllRecipes()
local toRemove = {
    ["Train Electrical"] = true,
    ["Train FirstAid"] = true,
    ["Train MetalWorking"] = true,
    ["Train Mechanic"] = true,
    ["Train Tailoring"] = true,
    ["Train Cooking"] = true,
    ["Learn Engineering"] = true
}
for i = 0, allRecipes:size() - 1 do
    local recipe = allRecipes:get(i)
    if recipe:getModule() and recipe:getModule():getName() == "MCH" then
        if toRemove[recipe:getName()] then
            recipe:setRemoveResultItem(true)
        end
    end

end

-- MACHINES 
-- if Recipe.OnGiveXP.ElectricalTrain then

--     local function giveTrainingXP(player, perk, xpAmount, fatigueIncrease)
--         if player:getPerkLevel(perk) >= 5 then
--             player:Say("I already know this.");
--         else
--             player:getXp():AddXP(perk, xpAmount);
--             player:getStats():setFatigue(player:getStats():getFatigue() + fatigueIncrease);
--         end
--     end

--     function Recipe.OnGiveXP.ElectricalTrain(recipe, ingredients, result, player)
--         giveTrainingXP(player, Perks.Electricity, 120, 0.1);
--     end

--     function Recipe.OnGiveXP.FirstaidTrain(recipe, ingredients, result, player)
--         giveTrainingXP(player, Perks.Doctor, 120, 0.1);
--     end

--     function Recipe.OnGiveXP.MetalworkTrain(recipe, ingredients, result, player)
--         giveTrainingXP(player, Perks.MetalWelding, 120, 0.1);
--     end

--     function Recipe.OnGiveXP.MechanicTrain(recipe, ingredients, result, player)
--         giveTrainingXP(player, Perks.Mechanics, 120, 0.1);
--     end

--     function Recipe.OnGiveXP.TailoringTrain(recipe, ingredients, result, player)
--         giveTrainingXP(player, Perks.Tailoring, 125, 0.1);
--     end

--     function Recipe.OnGiveXP.CookingTrain(recipe, ingredients, result, player)
--         giveTrainingXP(player, Perks.Cooking, 125, 0.1);
--     end

--     function Recipe.OnGiveXP.EngineerTrain(recipe, ingredients, result, player)
--         player:getXp():AddXP(Perks.Engineering, 200);
--         player:getStats():setFatigue(player:getStats():getFatigue() + 0.1);
--     end

-- end

local function removeItemsFromContainer(_container, chance)
    if not _container or not chance or chance <= 0 then
        return;
    end
    print("-------", "FILLING CONTAINER", "-------")
    -- _container:getModData().refreshed = getGameTime():getWorldAgeHours();

    local containerItems = _container:getItems()
    if containerItems then
        for i = containerItems:size() - 1, 0, -1 do
            local item = containerItems:get(i);
            if item then
                local itemName = item.getName and item:getName() or ""
                if string.find(itemName, PS.settings.ExtraItemRemoverKeys) then
                    if ZombRand(100) <= chance then
                        -- getPlayer():Say("Removing item: " .. itemName)
                        print("Removing item: " .. itemName)
                        _container:Remove(item)
                    else
                        print("Keeping item: " .. itemName)
                    end
                end
            end
        end
    end

end

local function checkRemoveItems(_iSInventoryPage)
    PS:checkRemoveItems(_iSInventoryPage)
    -- if (PS.settings.ExtraItemRemoverPercent or 0) == 0 then
    --     return;
    -- end

    -- for i, v in ipairs(_iSInventoryPage.backpacks) do
    --     -- if v.inventory:getVehiclePart() then
    --     --    containerObj = v.inventory:getVehiclePart();
    --     local container
    --     if v.inventory:getParent() then
    --         container = v.inventory:getParent()

    --         if instanceof(container, "IsoDeadBody") or not (container:getContainer() or container:getItemContainer()) then
    --             container = nil
    --         end

    --     end
    --     if v.inventory:getVehiclePart() then
    --         container = v.inventory:getVehiclePart();
    --     end
    --     if container:getContainer() or container:getItemContainer() then

    --         if container:isEmpty() then
    --             local isExplored = container and container.isExplored and container:isExplored();
    --             local isHasBeenLooted = container and container.isHasBeenLooted and container:isHasBeenLooted();
    --             local lastFilled = container:getModData().restocked

    --             if isHasBeenLooted == false then
    --                 if isAdmin() then
    --                     getSpecificPlayer(0):Say("Empty Container that hasnt been looted. Relooting")
    --                 end
    --                 -- assert this should be relooted?
    --                 container:setHasBeenLooted(true)
    --             end
    --             if lastFilled and lastFilled + 24 < getGameTime():getWorldAgeHours() then
    --                 ItemPickerJava.fillContainer(container, getPlayer())
    --             end
    --         elseif not container:getModData().hadItemsRemoved then
    --             container:getModData().hadItemsRemoved = true;
    --             removeItemsFromContainer(container, PS.settings.ExtraItemRemoverPercent)
    --         end

    --         -- if not containerObj:getModData().lastEmpty then
    --         --     containerObj:getModData().lastEmpty = getGameTime():getWorldAgeHours();
    --         -- elseif containerObj:getModData().refreshed and containerObj:getModData().refreshed + 24 <
    --         --     getGameTime():getWorldAgeHours() then
    --         --     ItemPickerJava.fillContainer(containerObj, getPlayer())
    --         -- end
    --         -- print("Container time = " .. tostring(container:getModData().restocked))
    --         -- if not container:getModData().hadItemsRemoved and container:getItemContainer() then
    --         --     container:getModData().hadItemsRemoved = true;
    --         --     removeItemsFromContainer(container:getItemContainer(), PS.settings.ExtraItemRemoverPercent)
    --         -- end
    --     end
    --     -- end
    -- end
end

local function checkRemoveItemsOnRefreshEnd(_iSInventoryPage, _state)
    if _state == "end" then
        print("-------\nREFRESHING CONTAINER\n-------")
        checkRemoveItems(_iSInventoryPage);
    end
end

local function removeItemsOnFill(_roomtype, _containertype, _container)
    print("-------\nFILLING CONTAINER\n-------")
    if _container and _container.getModData then
        _container:getModData().restocked = getGameTime():getWorldAgeHours();
        print("RESTOCKING CONTAINER " .. _container:getModData().restocked)
    end

    if (PS.settings.ExtraItemRemoverPercent or 0) > 0 then
        removeItemsFromContainer(_container, PS.settings.ExtraItemRemoverPercent)
    end
end

-- Evemts.OnServerCommand.Add(function(module, command, arguments)
--     if module == "PhunStuff" then
--         if command == "empty" then
--             print("** Emptying container")
--             -- local loot = getPlayerLoot(player:getPlayerNum())
--             -- local containers = loot.inventoryPane.inventoryPage.backpacks
--             -- local itemList = ArrayList.new();
--             -- for k, v in pairs(containers) do
--             --     local container = v.inventory
--             --     if container then
--             --         for k, v in pairs(radioactiveItems) do
--             --             local items = container:getItemsFromType(k)
--             --             if items:size() > 0 then
--             --                 if not radiatedItems[k] then
--             --                     radiatedItems[k] = {
--             --                         count = 0,
--             --                         level = 0
--             --                     }
--             --                 end
--             --                 radiatedItems[k].count = radiatedItems[k].count + items:size()
--             --                 radiatedItems[k].level = radiatedItems[k].level + (items:size() * v)
--             --                 radiatedLevels = radiatedLevels + (items:size() * v)
--             --             end
--             --         end
--             --     end
--             -- end
--         end
--     end
-- end)

if isClient() then
    return
end

local itemOverides = {
    ["Base.GoldBar"] = {
        Category = "Currency",
        DisplayCategory = "Currency"
    }
}

function PS:tweakRecipees()

    local recipeTweaks = self.recipeOverrides
    if recipeTweaks == nil or #recipeTweaks == 0 then
        return
    end

    local recipes = getScriptManager():getAllRecipes()
    for i = 1, recipes:size() do
        local recipe = recipes:get(i - 1)
        if recipe and recipe.getName and recipeTweaks[recipe:getName()] then
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

function PS:tweakItems()

    local itemTweaks = PhunStuff.itemOverrides

    for k, v in pairs(itemTweaks) do
        local item = ScriptManager.instance:getItem(k);
        if item ~= nil then
            for k2, v2 in pairs(v) do
                print("Tweaking " .. k .. " " .. k2 .. " to " .. v2)
                if k2 == "Condition" then
                    item:setCondition(v2);
                else
                    item:DoParam(k2 .. " = " .. v2);
                end
            end
        end
    end
end

