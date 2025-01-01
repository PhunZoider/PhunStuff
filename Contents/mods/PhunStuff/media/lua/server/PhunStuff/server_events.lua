if isClient() then
    return
end

local PS = PhunStuff

Events.OnClientCommand.Add(function(module, command, playerObj, arguments)
    if module == "PhunStuff" then
        if command == "mem" then
            PS:logMemoryStuff()
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
