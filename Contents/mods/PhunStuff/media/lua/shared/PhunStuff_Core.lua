local oldHordeNightTick = HN_CheckSpawnHordeZombies
local phunStats = nil

if oldHordeNightTick ~= nil then
    print("1")
    local OverwrittenHordeNightTick = function()
        print("2")
        local player = getPlayer()

        if player == nil then
            return
        end

        if player:getX() > 19800 and player:getY() > 12000 then
            -- Do not spawn zombies in interior zone
            return
        else
            oldHordeNightTick()
        end
    end

    if HN_CheckSpawnHordeZombies then
        print("3")
        Events.OnTick.Remove(HN_CheckSpawnHordeZombies);
        Events.OnTick.Add(OverwrittenHordeNightTick);

    end

end

PhunStuff = {
    inied = false,
    recipeOverrides = {},
    itemOverrides = {
        ["FunctionalAppliances.FABubBeerBottle"] = {
            DisplayCategory = "FoodA"
        },
        ["FunctionalAppliances.FABubLiteBeerBottle"] = {
            DisplayCategory = "FoodA"
        },
        ["FunctionalAppliances.FASwillerBeerBottle"] = {
            DisplayCategory = "FoodA"
        },
        ["FunctionalAppliances.FASwillerLiteBeerBottle"] = {
            DisplayCategory = "FoodA"
        },
        ["FunctionalAppliances.FAHomeBrewBeerBottle"] = {
            DisplayCategory = "FoodA"
        },
        ["SapphCooking.Vermouth"] = {
            DisplayCategory = "FoodA"
        },
        ["SapphCooking.LiqueurBottle"] = {
            DisplayCategory = "FoodA"
        },
        ["SapphCooking.CachacaFull"] = {
            DisplayCategory = "FoodA"
        },
        ["SOMW.Kukri"] = {
            DisplayCategory = "WepMelee"
        },
        ["SOMW.CombatKnife"] = {
            DisplayCategory = "WepMelee"
        },
        ["SOMW.LongLeadPipe"] = {
            DisplayCategory = "WepMelee"
        }
    }
}

function PhunStuff:ini()
    self.settings.debug = self.settings.debug or true
    self.inied = true
end

function PhunStuff:get()
    if not self.inied then
        self:ini()
    end
    return self
end

function PhunStuff:debug(...)
    if self.settings.debug then
        local args = {...}
        PhunTools:debug(args)
    end
end

function PhunStuff:say(message, player, r, g, b, a)
    if not player then
        player = getPlayer();
    end

    player:setHaloNote(message, r or 255, g or 255, b or 0, a or 300);

end
