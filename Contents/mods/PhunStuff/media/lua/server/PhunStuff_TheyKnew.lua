local oldfn = nil
if OnEat_Zomboxivir then

    oldfn = OnEat_Zomboxivir;
    function OnEat_Zomboxivir(food, player, percent)
        if not food:isRotten() then
            oldfn(food, player, percent);
            local stats = PhunStats:getPlayerData(player);
            if stats and stats.current then
                stats.current.ampules = (stats.current.ampules or 0) + 1;
                stats.total.ampules = (stats.total.ampules or 0) + 1;
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

