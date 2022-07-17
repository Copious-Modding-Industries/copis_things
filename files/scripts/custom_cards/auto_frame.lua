dofile_once("data/scripts/lib/utilities.lua")
local entity_id = GetUpdatedEntityID()
local root = EntityGetRootEntity(entity_id)
local comp = EntityGetFirstComponentIncludingDisabled( root, "PlatformShooterPlayerComponent" )
if (comp ~= nil) and not (GameIsInventoryOpen()) then
    ComponentSetValue2( comp, "mForceFireOnNextUpdate", true )
end