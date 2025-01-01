require "TsarSpawnList"
require "PhunStuff/core"

local PS = PhunStuff

local VehicleZoneDistribution = VehicleZoneDistribution or {};

if PS.settings.ATAChangeDistribution then

    if VehicleZoneDistribution.bigtrailerparkinglot and VehicleZoneDistribution.bigtrailerparkinglot.vehicles then
        VehicleZoneDistribution.bigtrailerparkinglot.vehicles["Base.TrailerTSMega"] = {
            index = -1,
            spawnChance = PS.settings.ATATrailerTSMegaSpawnChance or 15
        };
        VehicleZoneDistribution.bigtrailerparkinglot.vehicles["Base.ATAPetyarbuilt"] = {
            index = -1,
            spawnChance = PS.settings.ATAPetyarbuiltSpawnChance or 5
        };
        VehicleZoneDistribution.bigtrailerparkinglot.vehicles["Base.ATAPetyarbuiltSleeper"] = {
            index = -1,
            spawnChance = PS.settings.ATAPPetyarbuiltSleeperSpawnChance or 5
        };
        VehicleZoneDistribution.bigtrailerparkinglot.vehicles["Base.ATAPetyarbuiltSleeperLong"] = {
            index = -1,
            spawnChance = PS.settings.ATAPPetyarbuiltSleeperLongSpawnChance or 5
        };
    end
end

local oldHordeNightTick = HN_CheckSpawnHordeZombies

-- If using Horde night, do not spawn hordes inside of void/hospital

if oldHordeNightTick ~= nil then
    local OverwrittenHordeNightTick = function()
        local player = getPlayer()

        if player == nil then
            return
        end

        local data = player:getModData()
        if data and data.PhunZones and data.PhunZones.zeds == false then
            return
        end

        oldHordeNightTick()

    end

    if HN_CheckSpawnHordeZombies then
        Events.OnTick.Remove(HN_CheckSpawnHordeZombies);
        Events.OnTick.Add(OverwrittenHordeNightTick);
    end

end

