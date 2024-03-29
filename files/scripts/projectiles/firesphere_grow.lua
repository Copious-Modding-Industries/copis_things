local entity_id = GetUpdatedEntityID()
local radius = 10
local vscs = EntityGetComponent(entity_id, "VariableStorageComponent") or {}
for i = 1, #vscs do
    if ComponentGetValue2(vscs[i], "name") == "starting_frame" then
        radius = (GameGetFrameNum() - ComponentGetValue2(vscs[i], "value_int")) ^ 0.8
        break
    end
end
local pecs = EntityGetComponent(entity_id, "ParticleEmitterComponent", "fire") or {}
local area = math.pi * radius ^ 2
for i = 1, #pecs do
    local pec = pecs[i]
    ComponentSetValue2(pec, "area_circle_radius", 0, radius)
    ComponentSetValue2(pec, "count_min", area / 12)
    ComponentSetValue2(pec, "count_max", area / 12)
end
local gaecs = EntityGetComponent(entity_id, "GameAreaEffectComponent", "fire") or {}
for i = 1, #gaecs do
    local gaec = gaecs[i]
    ComponentSetValue2(gaec, "radius", radius)
end
local mcmcs = EntityGetComponent(entity_id, "MagicConvertMaterialComponent", "fire") or {}
for i = 1, #mcmcs do
    local mcmc = mcmcs[i]
    ComponentSetValue2(mcmc, "radius", radius)
end
local lgcs = EntityGetComponent(entity_id, "LooseGroundComponent", "fire") or {}
for i = 1, #lgcs do
    local lgc = lgcs[i]
    ComponentSetValue2(lgc, "max_distance", radius)
end

local projcomp = EntityGetFirstComponent(entity_id, "ProjectileComponent") --[[@cast projcomp number]]
local shooter = ComponentGetValue2(projcomp, "mWhoShot")
if not shooter then return end
local inv2comp = EntityGetFirstComponentIncludingDisabled(shooter, "Inventory2Component")
if inv2comp then
    local activeitem = ComponentGetValue2(inv2comp, "mActiveItem")
    if EntityHasTag(activeitem, "wand") then
        local ability = EntityGetFirstComponentIncludingDisabled(activeitem, "AbilityComponent") --[[@cast ability number]]
        local mana = ComponentGetValue2(ability, "mana")
        local drain = radius^0.3
        if mana >= drain then
            ComponentSetValue2(ability, "mana", mana - drain)
        else
            EntityKill(entity_id)
        end
    end
end