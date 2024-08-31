local entity_id = GetUpdatedEntityID()
local wand = EntityGetParent(entity_id)
local shooter = EntityGetRootEntity(wand)
if EntityHasTag(wand, "wand") and wand ~= shooter then
	local actions = EntityGetAllChildren(wand, "card_action")
	local abilcomp = EntityGetFirstComponentIncludingDisabled(wand, "AbilityComponent") --[[@type number]]
	for i=1, ComponentObjectGetValue2(abilcomp, "gun_config", "deck_capacity")-#actions do
		local effect_comp, effect_id = GetGameEffectLoadTo( shooter, "MOVEMENT_FASTER", true )
		ComponentSetValue2( effect_comp, "frames", 6 )
	end
	for i=1, math.floor((ComponentObjectGetValue2(abilcomp, "gun_config", "deck_capacity")-#actions)/2) do
		local effect_comp, effect_id = GetGameEffectLoadTo( shooter, "FASTER_LEVITATION", true )
		ComponentSetValue2( effect_comp, "frames", 6 )
	end
end