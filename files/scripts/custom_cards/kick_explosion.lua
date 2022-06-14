dofile_once("data/scripts/lib/utilities.lua")
local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
local entity_id = GetUpdatedEntityID()
local root = EntityGetRootEntity(entity_id)
local wand = EZWand(EntityGetParent(entity_id))
local x, y = EntityGetTransform(entity_id)
local controlscomp = EntityGetFirstComponent(root, "ControlsComponent")
local cooldown_frames = 10
local cooldown_frame
local variablecomp = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
cooldown_frame = ComponentGetValue2( variablecomp, "value_int" )


if GameGetFrameNum() >= cooldown_frame then
    if ComponentGetValue2(controlscomp, "mButtonFrameKick") == GameGetFrameNum() then
        local mana = wand.mana
        if (mana > 60) then
            EntityLoad("data/entities/projectiles/deck/explosion.xml", x, y)
            wand.mana = mana - 60
            ComponentSetValue2( variablecomp, "value_int", GameGetFrameNum() + cooldown_frames )
        end
    end
end
