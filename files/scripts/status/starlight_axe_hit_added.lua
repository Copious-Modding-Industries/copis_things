local effect_id = GetUpdatedEntityID()
local vscs = EntityGetComponentIncludingDisabled(effect_id, "VariableStorageComponent") or {}
for i=1, #vscs do
	if ComponentGetValue2(vscs[i], "name") == "projectile_who_shot" then
		local shooter = ComponentGetValue2(vscs[i], "value_int")
		if EntityGetIsAlive(shooter) then
			local inv2comp = EntityGetFirstComponentIncludingDisabled(shooter, "Inventory2Component") --[[@cast inv2comp number]]
			if inv2comp then
				local activeitem = ComponentGetValue2(inv2comp, "mActiveItem")
				if EntityHasTag(activeitem, "wand") then
					local ability = EntityGetFirstComponentIncludingDisabled(activeitem, "AbilityComponent") --[[@cast ability number]]
					ComponentSetValue2(ability, "mana", ComponentGetValue2(ability, "mana") + 60)
				end
			end
		end
		break
	end
end