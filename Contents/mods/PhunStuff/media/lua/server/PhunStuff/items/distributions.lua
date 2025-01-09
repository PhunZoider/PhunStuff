require 'Items/SuburbsDistributions'
require 'Vehicles/VehicleDistributions'
require "Items/ProceduralDistributions"
require 'Items/Distributions'
require 'Items/ItemPicker'

-- LivingRoomShelf
table.insert(ProceduralDistributions.list["LivingRoomShelf"].items, "PhunRad.BrokenGeigerCounter");
table.insert(ProceduralDistributions.list["LivingRoomShelf"].items, 0.5);

-- ArmyStorageMedical
table.insert(ProceduralDistributions.list["ArmyStorageMedical"].items, "Base.CoughSyrup");
table.insert(ProceduralDistributions.list["ArmyStorageMedical"].items, 3);

-- ArmyStorageElectronics
table.insert(ProceduralDistributions.list["ArmyStorageElectronics"].items, "PhunRad.GeigerCounter");
table.insert(ProceduralDistributions.list["ArmyStorageElectronics"].items, .05);

-- DrugLabSupplies
table.insert(ProceduralDistributions.list["DrugLabSupplies"].items, "Base.CoughSyrup");
table.insert(ProceduralDistributions.list["DrugLabSupplies"].items, 3);

-- DrugShackDrugs
table.insert(ProceduralDistributions.list["DrugShackDrugs"].items, "Base.CoughSyrup");
table.insert(ProceduralDistributions.list["DrugShackDrugs"].items, 3);

-- FireDeptLockers
table.insert(ProceduralDistributions.list["FireDeptLockers"].items, "Base.CoughSyrup");
table.insert(ProceduralDistributions.list["FireDeptLockers"].items, 1.5);

-- LockerArmyBedroom
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, "Base.CoughSyrup");
table.insert(ProceduralDistributions.list["LockerArmyBedroom"].items, 2.5);

-- MedicalStorageDrugs
table.insert(ProceduralDistributions.list["MedicalStorageDrugs"].items, "Base.CoughSyrup");
table.insert(ProceduralDistributions.list["MedicalStorageDrugs"].items, 3);

-- MedicalClinicDrugs
table.insert(ProceduralDistributions.list["MedicalClinicDrugs"].items, "Base.CoughSyrup");
table.insert(ProceduralDistributions.list["MedicalClinicDrugs"].items, 3);

-- PharmacyCosmetics
table.insert(ProceduralDistributions.list["PharmacyCosmetics"].items, "Base.CoughSyrup");
table.insert(ProceduralDistributions.list["PharmacyCosmetics"].items, 2);

-- SafehouseMedical
table.insert(ProceduralDistributions.list["SafehouseMedical"].items, "Base.CoughSyrup");
table.insert(ProceduralDistributions.list["SafehouseMedical"].items, 3);

-- PoliceEvidence
table.insert(ProceduralDistributions.list["PoliceEvidence"].items, "Base.CoughSyrup");
table.insert(ProceduralDistributions.list["PoliceEvidence"].items, 2.5);

-- PoliceLockers
table.insert(ProceduralDistributions.list["PoliceLockers"].items, "Base.CoughSyrup");
table.insert(ProceduralDistributions.list["PoliceLockers"].items, 5);

-- PoolLockers
table.insert(ProceduralDistributions.list["PoolLockers"].items, "Base.CoughSyrup");
table.insert(ProceduralDistributions.list["PoolLockers"].items, 1.25);

-- PrisonGuardLockers
table.insert(ProceduralDistributions.list["PrisonGuardLockers"].items, "Base.CoughSyrup");
table.insert(ProceduralDistributions.list["PrisonGuardLockers"].items, 3);

-- StoreShelfMedical
table.insert(ProceduralDistributions.list["StoreShelfMedical"].items, "Base.CoughSyrup");
table.insert(ProceduralDistributions.list["StoreShelfMedical"].items, 5);

-- BathroomCabinet
table.insert(ProceduralDistributions.list["BathroomCabinet"].items, "Base.CoughSyrup");
table.insert(ProceduralDistributions.list["BathroomCabinet"].items, 3.5);

-- BathroomCounter
table.insert(ProceduralDistributions.list["BathroomCounter"].items, "Base.CoughSyrup");
table.insert(ProceduralDistributions.list["BathroomCounter"].items, 2.5);

-- MedicalClinicTools
table.insert(ProceduralDistributions.list["MedicalClinicTools"].items, "Base.CoughSyrup");
table.insert(ProceduralDistributions.list["MedicalClinicTools"].items, 3);

-- BedroomSideTable
table.insert(ProceduralDistributions.list["BedroomSideTable"].items, "Base.CoughSyrup");
table.insert(ProceduralDistributions.list["BedroomSideTable"].items, 1);

-- OfficeDrawers
table.insert(ProceduralDistributions.list["OfficeDrawers"].items, "Base.CoughSyrup");
table.insert(ProceduralDistributions.list["OfficeDrawers"].items, 1);

-- glovebox
table.insert(VehicleDistributions["GloveBox"].items, "Base.CoughSyrup");
table.insert(VehicleDistributions["GloveBox"].items, 1.5);

-- Suburbs
table.insert(SuburbsDistributions["all"]["inventorymale"].items, "Base.CoughSyrup");
table.insert(SuburbsDistributions["all"]["inventorymale"].items, 0.5);

table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, "Base.CoughSyrup");
table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, 0.5);

