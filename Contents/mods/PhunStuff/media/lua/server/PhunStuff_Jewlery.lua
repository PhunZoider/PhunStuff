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
