dofile_once("data/scripts/lib/utilities.lua")
local entity_id = GetUpdatedEntityID()
local root = EntityGetRootEntity(entity_id)
local x, y = EntityGetTransform(entity_id)
local controlscomp = EntityGetFirstComponent(root, "ControlsComponent")
local cooldown_frames = 42
local variablecomp = EntityGetFirstComponentIncludingDisabled( entity_id, "VariableStorageComponent" )
local cooldown_frame = ComponentGetValue2( variablecomp, "value_int" )
local aim_x, aim_y = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(root, "ControlsComponent"), "mAimingVectorNormalized")

if GameGetFrameNum() >= cooldown_frame then
    if ComponentGetValue2(controlscomp, "mButtonFrameRightClick") == GameGetFrameNum() then
        local wallet_component = EntityGetFirstComponentIncludingDisabled(root, "WalletComponent")
        local money = ComponentGetValue2(wallet_component, "money")
        if money >= 10 then
            ComponentSetValue2(wallet_component, "money", money - 10)
            GameShootProjectile(root, x+aim_x*12, y+aim_y*12, x+aim_x*20, y+aim_y*20, EntityLoad("mods/copis_things/files/entities/projectiles/coin.xml", x, y))
            ComponentSetValue2( variablecomp, "value_int", GameGetFrameNum() + cooldown_frames )
        end
    end
end
