local entity_id = GetUpdatedEntityID()
local root = EntityGetRootEntity(entity_id)
local comp = EntityGetFirstComponentIncludingDisabled( root, "PlatformShooterPlayerComponent" )
local inv2Comp = EntityGetFirstComponentIncludingDisabled( root, "Inventory2Component" )
if (comp ~= nil) and (inv2Comp ~= nil ) and not (GameIsInventoryOpen()) then
    local switch = ComponentGetValue2( inv2Comp, "mLastItemSwitchFrame" )
    if (switch == GameGetFrameNum()) then
        ComponentSetValue2( comp, "mForceFireOnNextUpdate", true )
    end
end