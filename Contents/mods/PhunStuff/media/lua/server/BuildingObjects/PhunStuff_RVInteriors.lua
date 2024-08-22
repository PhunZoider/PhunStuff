require "BuildingObjects/ISDestroyCursor"
local luautils = luautils
local oldDestroyStuffFn = ISDestroyCursor.canDestroy

local bannedTiles = {}

function ISDestroyCursor:canDestroy(obj)
    local result = oldDestroyStuffFn(self, obj)
    if result and not isAdmin() then

        if obj and obj.getSprite then
            local sn = obj:getSprite():getName()
            if luautils.stringStarts(sn, 'industry_trucks_') then
                return false
            end
            if luautils.stringStarts(sn, 'f_rvinterior') then
                return false
            end
        end

    end
    return result
end
