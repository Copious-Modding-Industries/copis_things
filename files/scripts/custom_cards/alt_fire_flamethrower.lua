local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
local entity_id = GetUpdatedEntityID()
local root = EntityGetRootEntity(entity_id)
local wand = EZWand(EntityGetParent(entity_id))
local x, y = EntityGetTransform(entity_id)
local controlscomp = EntityGetFirstComponent(root, "ControlsComponent")
local cooldown_frames = 12
local variablecomp = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
local cooldown_frame = ComponentGetValue2( variablecomp, "value_int" )
local aim_x, aim_y = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(root, "ControlsComponent"), "mAimingVectorNormalized")

if GameGetFrameNum() >= cooldown_frame then
    if ComponentGetValue2(controlscomp, "mButtonDownRightClick") then
        local mana = wand.mana
        if (mana > 20) then

            GameShootProjectile(root, x+aim_x*12, y+aim_y*12, x+aim_x*20, y+aim_y*20, EntityLoad("data/entities/projectiles/deck/flamethrower.xml", x, y))
            wand.mana = mana - 20
            ComponentSetValue2( variablecomp, "value_int", GameGetFrameNum() + cooldown_frames )
        end
    end
end
