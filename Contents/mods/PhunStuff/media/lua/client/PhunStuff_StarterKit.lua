require("Hotbar/ISHotbarAttachDefinition")
local starterKit = {

    unemployed = {
        items = "Base.WhiskeyFull(0-2);Base.Corndog(1-4);Base.Bleach;Base.ComicBook",
        weapon = {
            type = "Base.GuitarAcoustic"
        },
        clothing = "Base.Hat_ShowerCap"
    },

    fireofficer = {
        bag = {
            type = "Base.Bag_Schoolbag",
            contents = "Base.WaterBottleFull(1-3);Base.BeefJerky(1-3);Base.BeerBottle(0-2);"
        },
        weapon = {
            type = "Base.HandAxe"
        },
        clothing = "Base.Hat_Fireman"
    },

    policeofficer = {
        bag = {
            type = "Base.Bag_Schoolbag",
            contents = "Base.WaterBottleFull;Base.PeanutButterSandwich(1-3);Base.BeerBottle(0-2);"
        },
        weapon = {
            type = "Base.Nightstick"
        },
        clothing = "Base.HatPolice_Grey"
    },

    parkranger = {
        bag = {
            type = "Base.Bag_BigHikingBag",
            contents = "Base.Acorn(1-5);Base.TrapSnare;Base.WaterBottleFull;Base.Granola(1-3);"
        },
        weapon = {
            type = "Base.HandAxe"
        },
        clothing = "Base.Hat_Ranger"
    },

    constructionworker = {
        bag = {
            type = "Base.Bag_JanitorToolbox",
            contents = "Base.WaterBottleFull;Base.Pear(1-2);Base.Nails(1-6)",
            location = "offhand"
        },
        weapon = {
            type = "Base.LeadPipe"
        },
        clothing = "Base.Hat_HardHat"
    },

    securityguard = {
        bag = {
            type = "Base.Bag_Schoolbag",
            contents = "Base.WaterBottleFull;Base.PeanutButterSandwich(1-3);Base.Torch"
        },
        weapon = {
            type = "Base.Nightstick"
        },
        clothing = "Base.Glasses_Aviators"
    },

    carpenter = {
        bag = {
            type = "Base.Bag_JanitorToolbox",
            contents = "Base.WaterBottleFull;Base.PieApple(1-2);Base.Plank(1-3);Base.Nails(1-6)",
            location = "offhand"
        },
        weapon = {
            type = "Base.Hammer"
        }
    },

    burglar = {
        bag = {
            type = "Base.Bag_DuffelBag",
            contents = "Base.WaterBottleFull;Base.Cereal(1-2);Base.Money(0-14);Base.BellyButton_DangleGold(0-2);Base.Necklace_Choker_Diamond(0-2);Base.Earring_Dangly_Diamond(0-2)"
        },
        weapon = {
            type = "Base.Screwdriver"
        },
        clothing = "Base.Hat_BalaclavaFull"
    },

    chef = {
        bag = {
            type = "Base.Bag_Schoolbag",
            contents = "Base.WaterBottleFull;Base.Cornbread(1-4);Base.Pan;Base.Butter;Base.Chives(0-4);Base.GingerRoot(0-3);Base.Sage(0-5);Base.Thyme(0-5);Base.Cilantro(0-6)"
        },
        weapon = {
            type = "Base.RollingPin"
        },
        clothing = "Base.Hat_ChefHat;Base.Jacket_Chef;Base.Trousers_Chef"
    },

    repairman = {
        bag = {
            type = "Base.Bag_JanitorToolbox",
            contents = "Base.WaterBottleFull;Base.Banana(1-4);Base.Screwdriver;Base.Nails(1-5)",
            location = "offhand"
        },
        weapon = {
            type = "Base.BallPeenHammer"
        }
    },

    farmer = {
        bag = {
            type = "Base.Cooler",
            contents = "Base.WaterBottleFull;farming.CabbageSeed(0-3);Base.Salad(1-4);"
        },
        weapon = {
            type = "Base.GardenHoe"
        },
        clothing = "AuthenticZClothing.Hat_Cowboy_Freddy"
    },

    fisherman = {
        bag = {
            type = "Base.Cooler",
            contents = "Base.WaterBottleFull;Base.FishingTackle;Base.BeerCan(1-3);Base.SushiFish(1-4);Base.Catfish(0-2);Base.Crayfish(0-3)",
            location = "offhand"
        },
        weapon = {
            type = "Base.FishingRod"
        },
        clothing = "Base.Hat_BucketHat"
    },

    doctor = {
        bag = {
            type = "Base.Bag_MedicalBag",
            contents = "Base.WaterBottleFull;Base.Scalpel;Base.Bandage(1-3);Base.PillsVitamins;Base.Tweezers;Base.Yoghrt(1-2);Base.Lollipop(1-4)"
        },
        weapon = {
            type = "AuthenticZClothing.AuthenticOrgan_Brain"
        },
        clothing = "Base.Hat_SurgicalMask_Green"
    },

    veteran = {
        bag = {
            type = "Base.Bag_DuffelBag",
            contents = "Base.WaterBottleFull;Base.WhiskeyFull(0-2);Base.Pills;Base.Oatmeal(1-3)"
        },
        weapon = {
            type = "Base.HuntingKnife"
        },
        clothing = "Base.Necklace_DogTag;Base.Hat_BeretArmy"
    },

    nurse = {
        bag = {
            type = "Base.Bag_DoctorBag",
            contents = "Base.WaterBottleFull;Base.Bandage(1-3);Base.PillsVitamins;Base.SoupBowl(1-2)",
            location = "offhand"
        },
        weapon = {
            type = "AuthenticZClothing.AuthenticCrutch"
        },
        clothing = "AuthenticZClothing.Dress_Nurse;AuthenticZClothing.Shoes_Nurse;AuthenticZClothing.Socks_Long_NurseThigh;AuthenticZClothing.Hat_Nurse"
    },

    lumberjack = {
        bag = {
            type = "Base.Bag_Schoolbag",
            contents = "Base.WaterBottleFull;Base.PillsVitamins;Base.StewBowl(1-2)"
        },
        weapon = {
            type = "Base.HandAxe"
        },
        clothing = "Base.Underpants_AnimalPrint;Base.Bra_Straps_AnimalPrint;Base.Shoes_Strapped;Base.Shirt_lumberjack;Base.Hat_Beany;Base.Dungarees"
    },

    fitnessInstructor = {
        bag = {
            type = "Base.Bag_Schoolbag",
            contents = "Base.WaterBottleFull;Base.PillsVitamins;Base.Salad(1-3);"
        },
        weapon = {
            type = "Base.BadmintonRacket"
        },
        clothing = "Base.Dungarees;Base.Gloves_LeatherGloves"
    },

    burgerflipper = {
        bag = {
            type = "Base.Bag_Schoolbag",
            contents = "Base.WaterBottleFull;Base.Pan;Base.Burger(1-3);"
        },
        weapon = {
            type = "Base.KitchenKnife"
        }
    },

    electrician = {
        bag = {
            type = "Base.Bag_Schoolbag",
            contents = "Base.WaterBottleFull;Base.Wire(1-4);Base.Pencil;Base.CakeRedVelvet(1-3);"
        },
        weapon = {
            type = "Base.Screwdriver"
        }
    },

    engineer = {
        bag = {
            type = "Base.Bag_Schoolbag",
            contents = "Base.WaterBottleFull;Base.NoiseTrap;Base.Pencil;Base.ComicBook;Base.CandyCorn(3-6);"
        },
        weapon = {
            type = "AuthenticZClothing.AuthenticWalkingCane",
            isTwoHanded = true
        }
    },

    metalworker = {
        bag = {
            type = "Base.Bag_Schoolbag",
            contents = "Base.WaterBottleFull;Base.BlowTorch;Base.WeldingRods;Base.CakeCarrot(1-2)"
        },
        weapon = {
            type = "Base.MetalPipe",
            isTwoHanded = true
        },
        clothing = "Base.CBX_Glasses_1"
    },

    mechanics = {
        bag = {
            type = "Base.Bag_JanitorToolbox",
            contents = "Base.WaterBottleFull;Base.CarBattery1;Base.BeerCan(1-4);Base.Burger(1-2)",
            location = "offhand"
        },
        weapon = {
            type = "Base.Wrench"
        }
    },

    tailor = {
        bag = {
            type = "Base.Bag_Schoolbag",
            contents = "Base.Needle;Base.Thread;Base.KnittingNeedles;Base.WaterBottleFull;farming.Salad(1-3);"
        },
        weapon = {
            type = "Base.ClubHammer"
        }
    },

    deliveryman = {
        bag = {
            type = "Base.Bag_Schoolbag",
            contents = "Base.Pencil;Base.BeerBottle(0-2);Base.WaterBottleFull;Base.Pizza(1-3);Base.Pop(1-3);Base.Dogfood(0-2);Base.DogChew(0-2)"
        },
        weapon = {
            type = "Base.ClubHammer"
        }

    },

    loader = {
        bag = {
            type = "Base.Bag_Schoolbag",
            contents = "Base.BeerBottle(0-2);Base.Corndog(1-2);Base.WaterBottleFull"
        },
        weapon = {
            type = "SOMW.CricketBat",
            isTwoHanded = true
        }
    },

    trucker = {
        bag = {
            type = "Base.Bag_Schoolbag",
            contents = "Base.BeerBottle(0-2);Base.Burrito(1-2);Base.HottieZ"
        },
        weapon = {
            type = "Base.BaseballBat"
        },
        clothing = "Base.Hat_Cowboy"
    },

    soldier = {
        bag = {
            type = "Base.Bag_B4BHoffman",
            contents = "Base.WhiskeyFull(0-2);Base.Corndog(1-4);AuthenticZClothing.Authentic_Pills"
        },
        weapon = {
            type = "Base.FlintKnife"
        },
        clothing = "Base.Hat_BaseballCapArmy;Base.Necklace_DogTag;AuthenticZClothing.CigarAZ"
    },

    botanist = {
        bag = {
            type = "AuthenticZClothing.Bag_B4BWalker",
            contents = "Base.WaterBottleFull;Base.Chives(0-4);Base.GingerRoot(0-3);Base.Sage(0-5);Base.Thistle(0-4);Base.Thyme(0-5);Base.Cilantro(0-6);Base.Dandelions(0-5)"
        },
        weapon = {
            type = "Base.Rake"
        }
    },

    graveman = {
        bag = {
            type = "AuthenticZClothing.Bag_B4BWalker",
            contents = "Base.WaterBottleFull;Base.PeanutButterSandwich(1-3);Base.Stake;Base.DirtBag(0-2);Base.RippedSheetsDirty(0-4)"
        },
        weapon = {
            type = "Base.Shovel"
        }
    },

    dancerocc = {
        bag = {
            type = "AuthenticZClothing.Bag_DuffelBag_Festive",
            contents = "AuthenticGymBottle_Blue_full;Base.Pretzel(1-6);"
        },
        weapon = {
            type = "Base.Violin"
        }
    },

    priestocc = {
        bag = {
            type = "AuthenticZClothing.Bag_B4BEvangelo",
            contents = "Base.Wine2;Base.Crackers(1-6);Base.Book;Base.Hotdog(1-3);Base.HottieZ;Base.Tissue"
        },
        weapon = {
            type = "Base.Keytar"
        }
    },

    heavyathinstructor = {
        bag = {
            type = "AuthenticZClothing.Bag_Packsport_Rim",
            contents = "AuthenticZClothing.AuthenticGymBottle_Pink_full;Base.Peanuts(3-10);Base.Pear(1-3)"
        },
        weapon = {
            type = "Base.DumbBell"
        }
    },

    detective = {
        bag = {
            type = "AuthenticZClothing.Bag_B4BMom",
            contents = "Base.WhiskeyFull(1-3);Base.WaterBottleFull(0-1);Base.PieBlueberry(1-3)"
        },
        weapon = {
            type = "Base.Saxophone"
        },
        items = "AuthenticZClothing.Cigarette"

    },

    teacherocc = {
        bag = {
            type = "Base.Bag_Satchel",
            contents = "Base.Pencil(0-1);Base.Crayons(1-4);Base.Apple(1-3);Base.WaterBottleFull(0-1);Base.PopBottle(0-1);Base.Wine2(1-3)",
            location = "offhand"
        },
        weapon = {
            type = "Base.Scissors"
        }
    },

    cleanerman = {
        bag = {
            type = "Base.Bag_JanitorToolbox",
            contents = "Base.Pop(0-2);Base.Garbagebag(1-4);Base.WaterBottleFull(0-1);Base.SnoGlobes(1-3)",
            location = "offhand"
        },
        weapon = {
            type = "Base.Broom"
        },
        clothing = "Base.Glasses_SafetyGoggles"
    },
    stuntman = {
        bag = {
            type = "AuthenticZClothing.Bag_ProtonPack_Back",
            contents = "Base.Splint;Base.Bandage(1-3);Base.Pop(0-2);Base.WaterBottleFull(0-1);Base.Lollipop(0-2)"
        },
        weapon = {
            type = "Base.BaseballBatNails",
            isTwoHanded = true
        },
        clothing = "Base.Glasses_SafetyGoggles"
    },
    gasstationoperator = {
        bag = {
            type = "Base.Bag_Schoolbag",
            contents = "Base.PetrolCan;Base.Money(0-10);Base.Pop(0-2);Base.WaterBottleFull(0-1);Base.Lollipop(0-2)",
            location = "offhand"
        },
        weapon = {
            type = "Base.SpearFork",
            isTwoHanded = true
        }
    },
    campcouns = {
        bag = {
            type = "Base.Bag_Satchel",
            contents = "Base.Pencil(0-1);Base.Crayons(1-4);Base.Apple;Base.WaterBottleFull(0-1);Base.PopBottle(0-1);",
            location = "offhand"
        },
        weapon = {
            type = "Base.ClosedUmbrellaRed",
            isTwoHanded = true
        }
    },
    dragracerocc = {
        bag = {
            type = "AuthenticZClothing.Bag_RoadsideDuffel",
            contents = "Base.Orange;Base.WaterBottleFull(0-1);Base.Rubberducky(0-1);Base.PieApple(1-3);Base.Jack;Base.LugWrench"
        },
        weapon = {
            type = "Base.Poolcue",
            isTwoHanded = true
        },
        clothing = "Base.Hat_CrashHelmet_Stars"
    },
    junkyardworker = {
        bag = {
            type = "Base.Bag_Schoolbag",
            contents = "Base.Orange(0-2);Base.WaterBottleFull(0-1);Base.PopBottle(0-1);Base.Rubberducky(0-1)"
        },
        weapon = {
            type = "Base.MetalPipe",
            isTwoHanded = true
        },
        clothing = "AuthenticZClothing.CigarAZ"
    },
    lifeguard = {
        bag = {
            type = "Base.Bag_Schoolbag",
            contents = "Base.Orange(0-2);Base.WaterBottleFull(0-1);Base.PopBottle(0-1);Base.Rubberducky(0-1)"
        },
        weapon = {
            type = "Base.CanoePadel",
            isTwoHanded = true

        }
    },
    demoworker = {
        bag = {
            type = "AuthenticZClothing.Bag_SchoolBagCEDABlack",
            contents = "Base.ChocoCakes(1-3);Base.WaterBottleFull(1-2);"
        },
        weapon = {
            type = "Base.PickAxeHandle"
        },
        items = "Base.Matches;Base.WaterBottleFull(0-1)",
        clothing = "AuthenticZClothing.CigarAZ"
    },
    butcherocc = {
        bag = {
            type = "Base.Cooler",
            contents = "Base.MeatPatty(1-3);Base.Pan;Base.Mustard(0-1);Base.Ketchup(0-1);Base.Burger(1-3)",
            location = "offhand"
        },
        weapon = {
            type = "Base.KitchenKnife"
        },
        clothing = "AuthenticZClothing.Apron_DonutAZ;Base.Glasses_SafetyGoggles"

    },
    paparazziocc = {
        bag = {
            type = "AuthenticZClothing.Bag_Satchel",
            contents = "Base.CameraFilm(2-5)",
            location = "offhand"
        },
        weapon = {
            type = "Base.IceHockeyStick"
        },
        items = "Base.CameraExpensive",
        clothing = "Base.Hat_BaseballCapBlue"
    },
    minerocc = {
        bag = {
            type = "AuthenticZClothing.Bag_B4BHolly"
        },
        weapon = {
            type = "Base.MetalPipe"
        },
        clothing = "AuthenticZClothing.Hat_HardHat_Miner"
    },
    cashierocc = {
        bag = {
            type = "AuthenticZClothing.Bag_Satchel",
            contents = "Base.ToiletPaper(1-4)",
            location = "offhand"
        },
        weapon = {
            type = "Base.BaseballBatNails"
        },
        items = "Base.Flute",
        clothing = "Base.Hat_BaseballCapBlue"
    },
    criminalocc = {
        bag = {
            type = "Base.Bag_DuffelBag",
            contents = "Base.Money(0-14)"
        },
        weapon = {
            type = "Base.BaseballBatNails"
        },
        items = "Base.IcePick",
        clothing = "Base.Hat_BalaclavaFull"
    },
    animalcontrolofficer = {
        bag = {
            type = "Base.Bag_BigHikingBag",
            contents = "Base.Acorn(1-5);Base.TrapMouse(1-3);Base.Granola(1-3);Base.WaterBottleFull"
        },
        weapon = {
            type = "Base.HuntingKnife"
        },
        items = "Base.Flute"
    }
}

Events.OnNewGame.Add(function(player, square)

    local profession = player:getDescriptor():getProfession()
    local items = starterKit[profession] or nil
    -- print(" -- STARTING NEW TOON --")
    -- print("Profession: " .. profession)
    -- PhunTools:printTable(items or {})
    -- print(" -- END NEW TOON --")

    function getQtyFromEntry(entry)

        if contains(entry, "-") then
            local num1, num2 = entry:match("(%d+)-(%d+)")
            if num1 and num2 then
                local result = ZombRand(tonumber(num2 - num1));
                return result + num1
            elseif num1 then
                return tonumber(num1)
            end
        else
            local num = entry:match("(%d+)")
            if num then
                return tonumber(num)
            end
        end
        return 1
    end

    function contains(str, char)
        return string.find(str, char, 1, true) ~= nil
    end

    function extract(entry)
        local itemType = entry:match("([^%(]+)")
        local qty = getQtyFromEntry(entry)
        return itemType, qty
    end

    function split(string)

        local result = {}
        local delimiter = ";"
        for match in (string .. delimiter):gmatch("(.-);") do

            local itemType, itemQty = extract(match)
            if itemQty and itemQty > 0 then
                for i = 1, itemQty do
                    table.insert(result, itemType)
                end
            end

        end
        return result
    end

    function AddToInv(itemtable, obj)
        for key, value in ipairs(itemtable) do
            if obj then
                obj:AddItem(value)
            else
                player:getInventory():AddItem(value)
            end
        end
    end

    if items then
        if type(items) == "table" then

            if items.bag then
                local spawnedItem = player:getInventory():AddItem(items.bag.type)
                if spawnedItem and items.bag.contents then
                    local itemsToAdd = split(items.bag.contents)
                    AddToInv(itemsToAdd, spawnedItem:getItemContainer())
                end
                if items.bag.location == "offhand" then
                    player:setSecondaryHandItem(spawnedItem)
                else
                    player:setWornItem(items.bag.location or "Back", spawnedItem)
                end
            end

            if items.weapon then
                local spawnedItem = player:getInventory():AddItem(items.weapon.type)
                -- player:setPrimaryHandItem(spawnedItem)
                if items.weapon.isTwoHanded then
                    -- player:setSecondaryHandItem(spawnedItem)
                end
            end

            if items.items then
                local itemsToAdd = split(items.items)
                AddToInv(itemsToAdd, nil)
            end

            if items.clothing then
                local itemsToSpawn = split(items.clothing)
                for _, v in ipairs(itemsToSpawn) do
                    local spawnedItem = player:getInventory():AddItem(v)
                    local location = spawnedItem:getBodyLocation()
                    -- player:setWornItem(location, nil)
                    local wornItem = player:getWornItem(location)
                    if wornItem then
                        player:getInventory():Remove(wornItem)
                    end

                    player:setWornItem(location, spawnedItem)
                end
            end

        elseif type(items) == "string" then
            local itemsToAdd = split(items)
            AddToInv(itemsToAdd, nil)
        end
    end

end)
