dofile_once("data/scripts/lib/utilities.lua")
local entity_id = GetUpdatedEntityID()
local root = EntityGetRootEntity(entity_id)
local comp = EntityGetFirstComponentIncludingDisabled( root, "PlatformShooterPlayerComponent" )
local damageComp = EntityGetFirstComponentIncludingDisabled( root, "DamageModelComponent" )
if (comp ~= nil) and (damageComp ~= nil ) and not (GameIsInventoryOpen()) then
    local hurt = ComponentGetValue2( damageComp, "mLastDamageFrame" )
    if (hurt == GameGetFrameNum()) then
        ComponentSetValue2( comp, "mForceFireOnNextUpdate", true )
    end
end