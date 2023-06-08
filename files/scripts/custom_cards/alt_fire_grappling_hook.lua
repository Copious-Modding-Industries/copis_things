dofile_once("data/scripts/lib/utilities.lua")
local entity_id = GetUpdatedEntityID()
local root = EntityGetRootEntity(entity_id)
local parent = EntityGetParent(entity_id)
local x, y = EntityGetTransform(entity_id)
local abilitycomp = EntityGetFirstComponentIncludingDisabled(parent, "AbilityComponent")
local variablecomp = EntityGetFirstComponentIncludingDisabled(entity_id, "VariableStorageComponent")
local controlscomp = EntityGetFirstComponentIncludingDisabled(root, "ControlsComponent")
if (abilitycomp ~= nil) and (variablecomp ~= nil) and (controlscomp ~= nil) then
    local cooldown_frames = 30
    local cooldown_frame = ComponentGetValue2(variablecomp, "value_int")
    local aim_x, aim_y = ComponentGetValue2(controlscomp, "mAimingVectorNormalized")
    if GameGetFrameNum() >= cooldown_frame then
        if ComponentGetValue2(controlscomp, "mButtonFrameRightClick") == GameGetFrameNum() then
            local mana = ComponentGetValue2(abilitycomp, "mana")
            if (mana >= 12) then


                local hook_id = shoot_projectile(
                    root,
                    "mods/copis_things/files/entities/projectiles/grappling_hook.xml",
                    x + aim_x * 12,
                    y + aim_y * 12,
                    aim_x * 128,
                    aim_y * 128
                )
                do -- Get shooter ent
                    local projectile = EntityGetFirstComponentIncludingDisabled(hook_id, "ProjectileComponent")
                    if projectile ~= nil then
                        ComponentSetValue2(projectile, "lifetime", 360);
                        EntityRemoveTag(projectile, "projectile_player") -- lagproofing
                    end
                    local vars = EntityGetComponentIncludingDisabled(hook_id, "VariableStorageComponent") or {}
                    for j = 1, #vars do
                        if ComponentGetValue2(vars[j], "name") == "target_ent" then
                            ComponentSetValue2(vars[j], "value_int", root)
                        end
                    end
                end

                ComponentSetValue2(abilitycomp, "mana", mana - 12)
                ComponentSetValue2(variablecomp, "value_int", GameGetFrameNum() + cooldown_frames)
            else
                GamePlaySound( "data/audio/Desktop/items.bank", "magic_wand/out_of_mana", x, y );
            end
        end
    end
end