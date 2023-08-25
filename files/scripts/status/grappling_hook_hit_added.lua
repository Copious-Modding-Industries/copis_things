local effect_id = GetUpdatedEntityID()
local victim_id = EntityGetRootEntity(effect_id)
local victim_x, victim_y = EntityGetTransform(victim_id)
local hook_id = (function ()
    local projectiles = EntityGetInRadiusWithTag(victim_x, victim_y, 32, "projectile_player") or {}
    local closest = { id = nil, dist = math.huge }
    for i=1, #projectiles do
        local target = projectiles[i]
        -- Skip over already embedded hooks
        if EntityGetName(target) ~= "grappling_hook_nohit" then goto continue end
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
if not hook_id then return end
-- Below code is only run if a valid hook is found!!

local hitfxs = EntityGetComponent(hook_id, "HitEffectComponent") or {}
for i=1,#hitfxs do
    if ComponentGetValue2(hitfxs[i], "value_string") == "mods/copis_things/files/entities/misc/effect_grappling_hook_hit.xml" then
        EntityRemoveComponent(hook_id, hitfxs[i])
        break
    end
end

-- Halve damage and set hit frames to 1 in 42
local damage_types = {"curse", "drill", "electricity", "explosion", "fire", "healing", "ice", "melee", "overeating", "physics_hit", "poison", "projectile", "radioactive", "slice"}
local projcomp = EntityGetFirstComponent(hook_id, "ProjectileComponent") --[[@cast projcomp number]]
ComponentSetValue2(projcomp, "damage_every_x_frames", 42)
ComponentSetValue2(projcomp, "damage", ComponentGetValue2(projcomp,"damage")/2)
for i=1,#damage_types do
    ComponentObjectSetValue2(projcomp, "damage_by_type", damage_types[i], ComponentObjectGetValue2(projcomp,"damage_by_type",damage_types[i])/2)
end

local velcomp = EntityGetFirstComponent(hook_id, "VelocityComponent") --[[@cast velcomp number]]
ComponentSetValue2(velcomp, "gravity_y", 0)
EntitySetName(hook_id, "grappling_hook_hit")

-- Add all components to the hook in question
EntityAddComponent2(hook_id, "VariableStorageComponent", {
    name = "grappling_hook_victim",
    value_int = victim_id
})

-- SWITCH TO STATE
local luacomps = EntityGetComponent(hook_id, "LuaComponent") or {}
for i = 1, #luacomps do
    if ComponentGetValue2(luacomps[i], "script_source_file") == "mods/copis_things/files/scripts/projectiles/grappling_hook/grappling_hook_looking.lua" then
        ComponentSetValue2(luacomps[i], "script_source_file", "mods/copis_things/files/scripts/projectiles/grappling_hook/grappling_hook_handler.lua")
    end
end