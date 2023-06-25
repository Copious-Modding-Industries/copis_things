local effect_id = GetUpdatedEntityID()
local victim_id = EntityGetRootEntity(effect_id)
local victim_x, victim_y, victim_rot, victim_sx, victim_sy = EntityGetTransform(victim_id)
local axe_id = (function ()
    local projectiles = EntityGetInRadiusWithTag(victim_x, victim_y, 32, "projectile_player") or {}
    local closest = { id = nil, dist = math.huge }
    for i=1, #projectiles do
        local target = projectiles[i]
        -- Skip over already embedded axes
        if EntityGetName(target) ~= "gilded_axe_unembedded" then goto continue end
        -- Compare to closest
        local target_x, target_y = EntityGetTransform(target)
        local t_dist = (target_x-victim_x)^2+(target_y-victim_y)^2
        if closest.dist > t_dist then
            closest.dist = t_dist
            closest.id = target
        end
        ::continue::
    end
    return closest.id
end)()
if not axe_id then return end
-- Below code is only run if a valid axe is found!!

local hitfxs = EntityGetComponent(axe_id, "HitEffectComponent") or {}
for i=1,#hitfxs do
    if ComponentGetValue2(hitfxs[i], "value_string") == "mods/copis_things/files/entities/misc/effect_gilded_axe_hit.xml" then
        EntityRemoveComponent(axe_id, hitfxs[i])
        break
    end
end

-- Halve damage and set hit frames to 1 in 42
local damage_types = {"curse", "drill", "electricity", "explosion", "fire", "healing", "ice", "melee", "overeating", "physics_hit", "poison", "projectile", "radioactive", "slice"}
local projcomp = EntityGetFirstComponent(axe_id, "ProjectileComponent") --[[@cast projcomp number]]
ComponentSetValue2(projcomp, "damage_every_x_frames", 42)
ComponentSetValue2(projcomp, "damage", ComponentGetValue2(projcomp,"damage")/2)
for i=1,#damage_types do
    ComponentObjectSetValue2(projcomp, "damage_by_type", damage_types[i], ComponentObjectGetValue2(projcomp,"damage_by_type",damage_types[i])/2)
end

local velcomp = EntityGetFirstComponent(axe_id, "VelocityComponent") --[[@cast velcomp number]]
ComponentSetValue2(velcomp, "gravity_y", 0)

EntitySetName(axe_id, "gilded_axe_embedded")
-- MATH JUMPSCARE!! OOO SO SCARY
local axe_x, axe_y = EntityGetTransform(axe_id)
local offset_x = (victim_x-axe_x)/victim_sx
local offset_y = (victim_y-axe_y)/victim_sy
local cosine = math.cos(-victim_rot)
local sine   = math.sin(-victim_rot)
local offset_rx = cosine * offset_x + sine   * offset_y
local offset_ry = sine   * offset_x - cosine * offset_y

-- Add all components to the axe in question
EntityAddComponent2(axe_id, "VariableStorageComponent", {
    name = "gilded_axe_embedded_id",
    value_int = victim_id
})
EntityAddComponent2(axe_id, "VariableStorageComponent", {
    name = "gilded_axe_embedded_offset_x",
    value_float = offset_rx
})
EntityAddComponent2(axe_id, "VariableStorageComponent", {
    name = "gilded_axe_embedded_offset_y",
    value_float = offset_ry
})
EntityAddComponent2(axe_id, "LuaComponent", {
    execute_every_n_frame=1,
    script_source_file = "mods/copis_things/files/scripts/projectiles/gilded_axe_handler.lua"
})
-- TODO: fake bleeding particle emitter on axe entity + get the victim's blood material and splatter a bit of it