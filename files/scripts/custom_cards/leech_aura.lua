local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)
for _, enemy in pairs(EntityGetInRadiusWithTag(pos_x, pos_y, 64, "enemy")) do
    local dmc = EntityGetFirstComponentIncludingDisabled(enemy, "DamageModelComponent")
    local bleed_mat = ComponentGetValue2(dmc, "blood_material")
    local enemy_x, enemy_y = EntityGetTransform(enemy)
    EntityInflictDamage( enemy, 0.1, "DAMAGE_MELEE", "Leeched", "BLOOD_SPRAY", 0, 0, EntityGetRootEntity(entity_id))
    if bleed_mat then
        local particle = EntityLoad("mods/copis_things/entities/particles/suck_particle.xml", enemy_x, enemy_y)
        EntityAddChild(entity_id, particle)
        local p = EntityGetFirstComponentIncludingDisabled(particle, "ParticleEmitterComponent")
        ComponentSetValue2(p, "m_next_emit_frame", GameGetFrameNum() + 1)
        ComponentSetValue2(p, "emitted_material_name", bleed_mat)
        ComponentSetValue2(p, "offset", enemy_x - pos_x, enemy_y - pos_y)
    end
end