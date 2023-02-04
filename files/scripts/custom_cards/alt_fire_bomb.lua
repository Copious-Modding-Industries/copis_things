local entity_id = GetUpdatedEntityID()
local root = EntityGetRootEntity(entity_id)
local x, y = EntityGetTransform(entity_id)
local controlscomp = EntityGetFirstComponent(root, "ControlsComponent")
local itemcomp = EntityGetFirstComponentIncludingDisabled(entity_id, "ItemComponent")
local abilitycomp = EntityGetFirstComponentIncludingDisabled(entity_id, "AbilityComponent")
local cooldown_frames = 12
local variablecomp = EntityGetFirstComponentIncludingDisabled(entity_id, "VariableStorageComponent")
local cooldown_frame = ComponentGetValue2(variablecomp, "value_int")
local aim_x, aim_y = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(root, "ControlsComponent"),
    "mAimingVectorNormalized")
if GameGetFrameNum() >= cooldown_frame then
    if ComponentGetValue2(controlscomp, "mButtonFrameRightClick") == GameGetFrameNum() then
        local mana = ComponentGetValue2(abilitycomp, "mana")
        local charges = ComponentGetValue2(itemcomp, "uses_remaining")
        if (mana > 25) and (charges > 0) then

            GameShootProjectile(root, x + aim_x * 12, y + aim_y * 12, x + aim_x * 128, y + aim_y * 128,
                EntityLoad("data/entities/projectiles/bomb.xml", x, y))
            ComponentSetValue2(itemcomp, "uses_remaining", charges - 1)
            ComponentSetValue2(abilitycomp, "mana", mana - 25)
            ComponentSetValue2(variablecomp, "value_int", GameGetFrameNum() + cooldown_frames)
            if charges <= 0 then
                GamePlaySound( "data/audio/Desktop/items.bank", "magic_wand/action_consumed", x, y )
                EntityLoad("mods/copis_things/files/entities/misc/spell_fades/bomb_spell_fade.xml", x, y )
            end
        else
            GamePlaySound( "data/audio/Desktop/items.bank", "magic_wand/out_of_mana", x, y );
        end
    end
end