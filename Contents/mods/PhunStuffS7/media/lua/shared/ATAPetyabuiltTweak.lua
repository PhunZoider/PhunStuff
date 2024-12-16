require "TsarSpawnList"

VehicleZoneDistribution = VehicleZoneDistribution or {};

if VehicleZoneDistribution.bigtrailerparkinglot and VehicleZoneDistribution.bigtrailerparkinglot.vehicles then
    VehicleZoneDistribution.bigtrailerparkinglot.vehicles["Base.TrailerTSMega"] = {
        index = -1,
        spawnChance = 15
    };
    VehicleZoneDistribution.bigtrailerparkinglot.vehicles["Base.ATAPetyarbuilt"] = {
        index = -1,
        spawnChance = 5
    };
    VehicleZoneDistribution.bigtrailerparkinglot.vehicles["Base.ATAPetyarbuiltSleeper"] = {
        index = -1,
        spawnChance = 5
    };
    VehicleZoneDistribution.bigtrailerparkinglot.vehicles["Base.ATAPetyarbuiltSleeperLong"] = {
        index = -1,
        spawnChance = 5
    };
end

-- ATAPetyarbuiltSleeperLong
