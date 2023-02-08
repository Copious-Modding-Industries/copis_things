dofile_once("data/scripts/lib/utilities.lua")
local entity_id = GetUpdatedEntityID()
local root = EntityGetRootEntity(entity_id)
local comp = EntityGetFirstComponentIncludingDisabled( root, "PlatformShooterPlayerComponent" )
local dmc = EntityGetFirstComponent( root, "DamageModelComponent" )
local hpdiff = 1.0
if (comp ~= nil) and (dmc ~= nil) then
    hpdiff = ComponentGetValue2( dmc, "hp" ) / ComponentGetValue2( dmc, "max_hp" )
    if hpdiff <= 0.25 then
        ComponentSetValue2( comp, "mForceFireOnNextUpdate", true )
    end
end