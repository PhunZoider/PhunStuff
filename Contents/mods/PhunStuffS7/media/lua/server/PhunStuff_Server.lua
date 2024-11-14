if not isServer() then
    return
end

local PhunStuff = PhunStuff

if PhunTools and PhunTools.RunOnceWhenServerEmpties then
    PhunTools:RunOnceWhenServerEmpties("PhunStuff", function()
        PhunStuff:logMemoryStuff()
    end)
end
Events.OnClientCommand.Add(function(module, command, playerObj, arguments)
    if module == "PhunStuff" then
        if command == "mem" then
            PhunStuff:logMemoryStuff()
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

