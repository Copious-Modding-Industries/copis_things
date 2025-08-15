
local entity_id = GetUpdatedEntityID()
local wand = EntityGetParent(entity_id)
if EntityHasTag(wand, "wand") then
	local found = false
	local targets = EntityGetWithTag("jetpack") or {}
	for i=1, #targets do
		if EntityGetName(targets[i]) == "wand_"..tostring(wand) then
			found = true
			break
		end
	end
	if not found then
		--EntityLoad()
		local spells = EntityGetAllChildren(wand, "card_action") or {}
		for i=1, #spells do
			local iac = EntityGetFirstComponentIncludingDisabled(spells[i], "ItemActionComponent") --[[@cast iac number]]
			local ic = EntityGetFirstComponentIncludingDisabled(spells[i], "ItemComponent") --[[@cast ic number]]
			-- Create card clone
			local card = CreateItemActionEntity(ComponentGetValue2(iac, "action_id"))
			local new_ic = EntityGetFirstComponentIncludingDisabled(card, "ItemComponent") --[[@cast new_ic number]]
			ComponentSetValue2(new_ic, "uses_remaining", ComponentGetValue2(ic, "uses_remaining"))
		end




		local sprites = EntityGetComponentIncludingDisabled(wand, "SpriteComponent", "item") or {}
		for i=1, #sprites do
			--EntityAddComponent2()
		end
	end
end