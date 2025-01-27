print("==================================")
print("CLIENT MAIN LOADING")
print("==================================")
if isServer() then
    return
end
local PS = PhunStuff

-- Fix for NUC keeping items
if ISFixNuc then
    local oldfn = ISFixNuc.perform
    function ISFixNuc:perform()
        oldfn(self)
        if self.ItemName ~= "ElectricWire" then
            self.character:getInventory():RemoveOneOf(self.ItemName)
        end

    end
end

local oldAddLineInChat = ISChat.addLineInChat
function ISChat.addLineInChat(message, tabID)
    if luautils.stringEnds(message:getText(), "[img=music]") then
        return
    end
    oldAddLineInChat(message, tabID)
end

if Machines and Machines.assignNameBasedOnSprite then
    local oldMachinesAssignName = Machines.assignNameBasedOnSprite
    function Machines.assignNameBasedOnSprite(object)
        if object and object.getSprite then
            oldMachinesAssignName(object);
        end
    end
end

-- BANDIT SPAWNING IN VOID

if PS.settings.FixBanditVoidSpawning then
    local BanditScheduler = BanditScheduler
    if BanditScheduler then
        local oldfn = BanditScheduler.GenerateSpawnPoint

        function BanditScheduler.GenerateSpawnPoint(player, d)

            local data = player:getModData()
            if data and data.PhunZones and data.PhunZones.bandits == false then
                return false
            end

            return oldfn(player, d)

        end
    end
end

-- SAFEHOUSE BUFFER

local phunDestroyStuffAction = ISDestroyStuffAction["isValid"];

local safehouseDistance = 15

ISDestroyStuffAction["isValid"] = function(self)

    if self.character and self.character.getPrimaryHandItem then

        local p = self.character
        local username = p:getUsername()
        local cell = p:getCell()
        local safehouses = SafeHouse:getSafehouseList()
        local safehouseCount = safehouses:size()

        if safehouseCount == 0 then
            return true
        end

        local charX = p:getX()
        local charY = p:getY()

        local isOk = false

        for index = 1, safehouseCount, 1 do

            local safehouse = safehouses:get(index - 1)
            local houseX = safehouse:getX() - safehouseDistance
            local houseX2 = safehouse:getX2() + safehouseDistance
            local houseY = safehouse:getY() - safehouseDistance
            local houseY2 = safehouse:getY2() + safehouseDistance

            if charX > houseX and charX < houseX2 then
                if charY > houseY and charY < houseY2 then
                    -- is it theirs?
                    if safehouse:getOwner() == username then
                        isOk = true
                        break
                    else
                        -- are they a member?
                        local members = safehouse:getPlayers()
                        local memberCount = members:size();

                        for memberIndex = 1, memberCount, 1 do
                            -- If the username is found in the members list, return the safehouse.
                            local memberName = members:get(memberIndex - 1)
                            if memberName == username then
                                isOk = true
                                break
                            end
                        end

                        if isOk then
                            break
                        end
                    end
                end
            else
                isOk = true
            end
        end

        if not isOk then
            PhunStuff:say("You are too close to a safehouse that you do not belong to")
            return false
        end

    end
    local result = phunDestroyStuffAction(self)
    return result

end

-- Sweeper fix
if CF8K then
    if CF8K.Sweeper then
        function CF8K.Sweeper:allowAutoRemoveBtn()
            return true
        end
    end
end

