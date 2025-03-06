local function update(effect, target_card)
	dofile_once("data/scripts/gun/gun.lua")
	local lookup = GunUtils.lookup_spells()
	local iac = EntityGetFirstComponentIncludingDisabled(target_card, "ItemActionComponent") --[[@cast iac number]]
	local action_id = ComponentGetValue2(iac, "action_id")
	local name = GameTextGetTranslatedOrNot(lookup[action_id].name)
	local UIC = EntityGetFirstComponent(effect, "UIIconComponent") ---@cast UIC number
	local vsc = EntityGetFirstComponent(effect, "VariableStorageComponent") --[[@cast vsc number]]
	ComponentSetValue2(UIC, "name",				GameTextGet("$effectname_copith_axiom", name))
	ComponentSetValue2(UIC, "description",		GameTextGet("$effectdesc_copith_axiom", name))
	--ComponentSetValue2(UIC, "icon_sprite_file",	lookup[id].sprite)
	ComponentSetValue2(vsc, "value_int", GetUpdatedEntityID())
	ComponentSetValue2(vsc, "value_string", action_id)
end

local function findnext(wnd, eid)
	-- We've gone through all buffs and none were generated from this spell. Spawn that shit in.
	local spells = EntityGetAllChildren(wnd, "card_action") or {}
	local ic = EntityGetFirstComponentIncludingDisabled(eid, "ItemComponent") --[[@cast ic number]]
	local spell = 0
	local slot = math.huge
	local slot_x, slot_y = ComponentGetValue2(ic, "inventory_slot")
	for i=1, #spells do
		local ic2 = EntityGetFirstComponentIncludingDisabled(spells[i], "ItemComponent") --[[@cast ic2 number]]
		local slot_x2, slot_y2 = ComponentGetValue2(ic2, "inventory_slot")
		-- Spell is after this spell's slot, less than last slot. Narrows to the one after this spell.
		if slot_x2 > slot_x and slot_x < slot then
			spell = spells[i]
			slot = slot_x
		end
	end
	return spell
end

local entity_id = GetUpdatedEntityID()
local wand = EntityGetParent(entity_id)
if EntityHasTag(wand, "wand") then
	local root = EntityGetRootEntity(entity_id)
	local buffs = EntityGetAllChildren(root) or {}
	for i=1, #buffs do
		if EntityGetName(buffs[i]) == "arcanum_axiom" then
			local vsc = EntityGetFirstComponent(buffs[i], "VariableStorageComponent") --[[@cast vsc number]]
			if ComponentGetValue2(vsc, "value_int") == entity_id then
				local spell = findnext(wand, entity_id)
				if spell==0 then goto skip end
				---@diagnostic disable-next-line: param-type-mismatch
				ComponentSetValue2(EntityGetFirstComponent(buffs[i], "GameEffectComponent"), "frames", 60)
				update(buffs[i], spell)
				goto skip
			end
		end
	end
	local spell = findnext(wand, entity_id)
	if spell==0 then goto skip end
	-- We found a spell after this spell
	local effect = EntityLoad("mods/copis_things/files/entities/misc/status_entities/arcanum/axiom.xml")
	update(effect, spell)
	EntityAddChild(root, effect)
	::skip::
end