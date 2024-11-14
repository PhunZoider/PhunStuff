local PhunZones = PhunZones
if SandboxVars.PhunStuff.FixBanditVoidSpawning then
    local BanditScheduler = BanditScheduler
    if BanditScheduler then
        local oldfn = BanditScheduler.GenerateSpawnPoint

        function BanditScheduler.GenerateSpawnPoint(player, d)

            local zone = PhunZones:getLocation(player:getX(), player:getY())

            if zone and zone.difficulty and zone.difficulty > 1 then
                return oldfn(player, d)
            end
            return false
        end
    end

end
