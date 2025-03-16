local root = EntityGetRootEntity(GetUpdatedEntityID())
EntityRemoveTag(root, "homing_target")
local dmc = EntityGetFirstComponent(root, "DamageModelComponent")

if ComponentGetValue2(GetUpdatedComponentID(), "mTimesExecuted")==7 then
	
end