local projectile = GetUpdatedEntityID()
local projcomp = EntityGetFirstComponentIncludingDisabled(projectile, "ProjectileComponent")
if projcomp ~= nil then
    local shooter = ComponentGetValue2(projcomp, "mWhoShot")
    if EntityGetIsAlive(shooter) then
        local effect_entity = EntityCreateNew("COPI_TELEPORT_EFFECT_BAD")
        EntityAddComponent2(effect_entity, "GameEffectComponent", {
            effect="UNSTABLE_TELEPORTATION",
            frames=1,
            teleportation_probability=0,
            teleportation_delay_min_frames=0,
            exclusivity_group=42069001,
        })
        EntityAddComponent2(effect_entity, "InheritTransformComponent", {})
        EntityAddChild(shooter, effect_entity)
    end
end
EntityKill(projectile)