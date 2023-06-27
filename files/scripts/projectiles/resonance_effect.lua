local effect_id   = GetUpdatedEntityID()
local victim_id   = EntityGetParent(effect_id)
local biggest_hit = -math.huge
local dmcs        = EntityGetComponentIncludingDisabled(victim_id, "DamageModelComponent") or {}
for i = 1, #dmcs do
    local new_hp = ComponentGetValue2(dmcs[i], "hp")
    local old_hp = ComponentGetValue2(dmcs[i], "mHpBeforeLastDamage")
    local hp_ratio = new_hp - old_hp
    if hp_ratio < biggest_hit then
        biggest_hit = hp_ratio
    end
end

-- This code is adapted from code by Conga Lyne, thanks!!!
local entity_who_caused = 0
local comps = EntityGetComponentIncludingDisabled(effect_id, "VariableStorageComponent") or {}
for i = 1, #comps do
    --This says projectile, but actually gives the ID of the creature who shot the projectile that caused the status effect
    if ComponentGetValue2(comps[k], "name") == "projectile_who_shot" then
        entity_who_caused = ComponentGetValue2(comps[k], "value_int")
        break
    end
end

local x, y = EntityGetTransform(victim_id)
local targets = EntityGetInRadiusWithTag(x, y, 128, "hittable") or {}
for i=1, #targets do
    local target = targets[i]
    if
        (target == entity_who_caused) or
        (EntityGetComponent(target, "GenomeDataComponent") and
        EntityGetHerdRelation(entity_who_caused, id) >= 70)
        then
        goto continue
    end
    --[[ Handle particle ray
    local tx, ty = EntityGetTransform(target)
    local dist = ((tx-x)^2+(ty-y)^2)^0.5
    for j=1, #dist do
        
    end
    ]]
    EntityInflictDamage(target, biggest_hit, "DAMAGE_ELECTRICITY", "Resonated", "DISINTEGRATED", 0, 0, entity_who_caused)
    ::continue::
end
