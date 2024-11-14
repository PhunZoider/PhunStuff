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

local function table_size(obj, seen)
    seen = seen or {}
    if seen[obj] then
        return 0
    end
    seen[obj] = true

    local size = 0
    local obj_type = type(obj)

    if obj_type == "table" then
        for k, v in pairs(obj) do
            size = size + table_size(k, seen) + table_size(v, seen)
        end
    elseif obj_type == "string" then
        size = #obj
    elseif obj_type == "number" or obj_type == "boolean" then
        size = 8
    end

    return size
end

local function human_readable_size(size_in_kb)
    local units = {"KB", "MB", "GB", "TB"}
    local size = size_in_kb
    local unit_index = 1

    while size >= 1024 and unit_index < #units do
        size = size / 1024
        unit_index = unit_index + 1
    end

    return string.format("%.1f%s", size, units[unit_index])
end

function PhunStuff:logMemoryStuff()

    local mem_KBytes = human_readable_size(collectgarbage("count")) -- memory currently occupied by Lua
    print("Garbage Collection: ", tostring(mem_KBytes))
    if isServer() then
        PhunTools:addLogEntry("Garbage Collecting", tostring(mem_KBytes))
    end

    local md = ModData.getTableNames()
    for i = 0, md:size() - 1 do
        local name = md:get(i);
        local size = human_readable_size(table_size(ModData.get(name)))
        print(" - ModData: " .. name .. " = " .. size)
        if isServer() then
            PhunTools:addLogEntry("ModData", name, size)
        end
    end

end

-- Events.EveryTenMinutes.Add(function()
--     print(tostring(SandboxVars.DayLength), "EveryTenMinutes")
-- end);

-- Events.EveryHours.Add(function()

--     local hour = getGameTime():getHour()
--     -- local options = SandboxOptions.new()
--     -- options:copyValuesFrom(getSandboxOptions())
--     print("s hour ", tostring(hour), "Current DayLength ", tostring(SandboxVars.DayLength))

--     PhunTools:printTable(SandboxVars.PhunStuff)
--     if isServer() then
--         -- print("s hour ", tostring(hour), "Current DayLength ", tostring(SandboxVars.DayLength))

--         -- if hour >= SandboxVars.DayLength or hour <= SandboxVars.DayLength then
--         --     print("Speed Up", SandboxVars.PhunStuff.SettingToSpeedUpTo)
--         --     SandboxVars.DayLength = SandboxVars.PhunStuff.SettingToSpeedUpTo
--         --     getSandboxOptions():set("DayLength", SandboxVars.PhunStuff.SettingToSpeedUpTo)
--         --     options:set("DayLength", SandboxVars.PhunStuff.SettingToSpeedUpTo)
--         -- else
--         --     print("Revert to", options.PhunStuff.SettingtoRevertTo)
--         --     options.DayLength = options.PhunStuff.SettingtoRevertTo
--         -- end

--         SandboxVars.DayLength = SandboxVars.PhunStuff.SettingToSpeedUpTo
--         getSandboxOptions():updateFromLua()
--         -- getSandboxOptions():getOptionByName("DayLength"):setValue(3)
--         -- getSandboxOptions():sendToServer()
--         -- 
--         -- getSandboxOptions():sendToServer()
--         getSandboxOptions():applySettings()
--         getSandboxOptions():saveServerLuaFile(getServerName())
--         getSandboxOptions():loadServerLuaFile(getServerName())
--         -- getSandboxOptions():save()
--         -- options:save(options)
--         print("hour ", tostring(hour), "Current DayLength ", tostring(SandboxVars.DayLength))
--         -- PhunTools:printTable(SandboxVars.PhunStuff)

--     end
--     print("hour ", tostring(hour), "Current DayLength ", tostring(SandboxVars.DayLength))
--     print(tostring(getGameTime():getHour()))
-- end);
