local projectile = GetUpdatedEntityID()
local projcomp = EntityGetFirstComponentIncludingDisabled(projectile, "ProjectileComponent")
if projcomp then
    local shooter = ComponentGetValue2( projcomp, "mWhoShot" )
    if EntityGetIsAlive(shooter) then
        
    end 
end


