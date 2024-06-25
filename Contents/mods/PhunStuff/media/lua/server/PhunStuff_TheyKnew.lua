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

