dofile_once("data/scripts/lib/utilities.lua")
local entity_id = GetUpdatedEntityID()
local root = EntityGetRootEntity(entity_id)
local comp = EntityGetFirstComponentIncludingDisabled( root, "PlatformShooterPlayerComponent" )
local controlComp = EntityGetFirstComponentIncludingDisabled( root, "ControlsComponent" )
if (comp ~= nil) and (controlComp ~= nil ) and not (GameIsInventoryOpen()) then
    local alt = ComponentGetValue2( controlComp, "mButtonDownRightClick" )
    if (alt) then
        ComponentSetValue2( comp, "mForceFireOnNextUpdate", true )
    end
end