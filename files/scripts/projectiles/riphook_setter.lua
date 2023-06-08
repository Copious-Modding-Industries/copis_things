local entity_id = GetUpdatedEntityID()
local projcomp = EntityGetFirstComponentIncludingDisabled(entity_id, "ProjectileComponent")
if projcomp then
    local target = -420
    do -- Get shooter ent
        local vars = EntityGetComponentIncludingDisabled(entity_id, "VariableStorageComponent") or {}
        for i = 1, #vars do
            if ComponentGetValue2(vars[i], "name") == "target_ent" then
                target = ComponentGetValue2(vars[i], "value_int")
                if target == -420 then
                    local ent_that_shot = ComponentGetValue2(projcomp, "mEntityThatShot")
                    if ent_that_shot ~= 0 then
                        target = ent_that_shot
                    else
                        target = ComponentGetValue2(projcomp, "mWhoShot")
                    end
                    ComponentSetValue2(vars[i], "value_int", target)
                end
            end
        end
    end
end

-- SWITCH TO CARRY STATE
local luacomps = EntityGetComponent(entity_id, "LuaComponent") or {}
for i = 1, #luacomps do
    if ComponentGetValue2(luacomps[i], "script_source_file") == "mods/copis_things/files/scripts/projectiles/riphook_setter.lua" then
        ComponentSetValue2(luacomps[i], "script_source_file", "mods/copis_things/files/scripts/projectiles/riphook_carry.lua")
    end
end



