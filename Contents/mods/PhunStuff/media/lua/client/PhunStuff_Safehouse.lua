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
            PhunTweaks:say("You are too close to a safehouse that you do not belong to")
            return false
        end

    end
    local result = phunDestroyStuffAction(self)
    return result

end
