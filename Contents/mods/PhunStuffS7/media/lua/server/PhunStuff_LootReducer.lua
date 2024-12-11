if not isServer() then
    return
end

local sandbox = SandboxVars.PhunStuff

local function removeItemsFromContainer(_container, chance)
    if not _container or not chance or chance <= 0 then
        return;
    end

    local containerItems = _container:getItems()
    if containerItems then
        for i = containerItems:size() - 1, 0, -1 do
            local item = containerItems:get(i);
            if item then
                local itemName = item:getName()
                if string.find(itemName, sandbox.ExtraItemRemoverKeys) then
                    if ZombRand(100) <= chance then
                        print("Removing item: " .. itemName)
                        _container:Remove(item)
                    end
                end
            end
        end
    end
end

local function checkRemoveItems(_iSInventoryPage)
    if sandbox.ExtraItemRemoverPercent == 0 then
        return;
    end
    local containerObj;
    for i, v in ipairs(_iSInventoryPage.backpacks) do
        if v.inventory:getVehiclePart() then
            containerObj = v.inventory:getVehiclePart();
            if not containerObj:getModData().hadItemsRemoved and instanceof(containerObj, "VehiclePart") and
                containerObj:getItemContainer() then
                containerObj:getModData().hadItemsRemoved = true;
                removeItemsFromContainer(containerObj:getItemContainer(), sandbox.ExtraItemRemoverPercent)
            end
        end
    end
end

local function checkRemoveItemsOnRefreshEnd(_iSInventoryPage, _state)
    if _state == "end" then
        checkRemoveItems(_iSInventoryPage);
    end
end
local function removeItemsOnFill(_roomtype, _containertype, _container)
    if sandbox.ExtraItemRemoverPercent > 0 then
        removeItemsFromContainer(_container, sandbox.ExtraItemRemoverPercent)
    end
end

Events.OnRefreshInventoryWindowContainers.Add(checkRemoveItemsOnRefreshEnd);
Events.OnFillContainer.Add(removeItemsOnFill);
