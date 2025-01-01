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

if isClient() then
    return
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

    local containerItems = _container:getItems()
    if containerItems then
        for i = containerItems:size() - 1, 0, -1 do
            local item = containerItems:get(i);
            if item then
                local itemName = item:getName()
                if string.find(itemName, PS.settings.ExtraItemRemoverKeys) then
                    if ZombRand(100) <= chance then
                        print("Removing item: " .. itemName)
                        _container:Remove(item)
                    end
                end
            end
        end
    end
end

local function checkRemoveItems(_iSInventoryPage)
    if (PS.settings.ExtraItemRemoverPercent or 0) == 0 then
        return;
    end
    local containerObj;
    for i, v in ipairs(_iSInventoryPage.backpacks) do
        if v.inventory:getVehiclePart() then
            containerObj = v.inventory:getVehiclePart();
            if not containerObj:getModData().hadItemsRemoved and instanceof(containerObj, "VehiclePart") and
                containerObj:getItemContainer() then
                containerObj:getModData().hadItemsRemoved = true;
                removeItemsFromContainer(containerObj:getItemContainer(), PS.settings.ExtraItemRemoverPercent)
            end
        end
    end
end

local function checkRemoveItemsOnRefreshEnd(_iSInventoryPage, _state)
    if _state == "end" then
        checkRemoveItems(_iSInventoryPage);
    end
end
local function removeItemsOnFill(_roomtype, _containertype, _container)
    if (PS.settings.ExtraItemRemoverPercent or 0) > 0 then
        removeItemsFromContainer(_container, PS.settings.ExtraItemRemoverPercent)
    end
end

Events.OnRefreshInventoryWindowContainers.Add(checkRemoveItemsOnRefreshEnd);
Events.OnFillContainer.Add(removeItemsOnFill);

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
                    item:DoParam(k2 .. " = " .. v2);
                end
            end
        end
    end
end

Events.OnGameBoot.Add(tweakItems)
Events.OnGameStart.Add(tweakRecipees)

