local projectile = GetUpdatedEntityID()
if EntityGetName(projectile) ~= "separator" then
    EntityAddTag(projectile, "SWORD_FORMATION")
    local projcomp = EntityGetFirstComponentIncludingDisabled(projectile, "ProjectileComponent")
    if not ComponentGetValue2(projcomp, "penetrate_world") then
        ComponentSetValue2(projcomp, "penetrate_world", true )
        EntityAddComponent2(projectile, "LuaComponent", {
            execute_every_n_frame=2,
            remove_after_executed=true,
            script_source_file = "mods/copis_things/files/scripts/projectiles/sword_haxx.lua"
        })
    end
end