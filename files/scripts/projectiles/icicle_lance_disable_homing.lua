dofile_once("data/scripts/lib/utilities.lua")
local entity_id    = GetUpdatedEntityID()
--[[
for _,value in ipairs(EntityGetAllChildren(entity_id) or {}) do
	local comp EntityGetFirstComponentIncludingDisabled(value, "HomingComponent")
	EntitySetComponentIsEnabled(value, comp, false)
	ComponentAddTag(comp, "re_enable_homing")
end
]]

edit_component2( entity_id, "VelocityComponent", function(comp,vars)
	local vx, vy = ComponentGetValue2( comp, "mVelocity")
	ComponentSetValue2( comp, "mVelocity", vx * -1, vy * -1)
end)