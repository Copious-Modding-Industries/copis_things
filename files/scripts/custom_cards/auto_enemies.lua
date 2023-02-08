dofile_once("data/scripts/lib/utilities.lua")
local entity_id = GetUpdatedEntityID()
local root = EntityGetRootEntity(entity_id)
local x, y = EntityGetTransform( root )
local comp = EntityGetFirstComponentIncludingDisabled( root, "PlatformShooterPlayerComponent" )
local targets = EntityGetInRadiusWithTag( x, y, 256, "homing_target" ) or {}
GamePrint(tostring(#targets))
if (comp ~= nil) and ( #targets >= 15 ) then
    ComponentSetValue2( comp, "mForceFireOnNextUpdate", true )
end