---@return boolean force_sorted
---@return table slots
---@return boolean arcanum_armament
---@return boolean arcanum_axiom
---@return number wand_id
---@return table axioms
local function get_force_sorted(caster)
	local root = EntityGetRootEntity(caster)
	local buffs = EntityGetAllChildren(root) or {}
	local do_slot_check = false
	local slots = {}
	local axioms = {}
	for i=1, #buffs do
		if EntityGetName(buffs[i]) == "arcanum_axiom" then
			local vsc = EntityGetFirstComponent(buffs[i], "VariableStorageComponent") --[[@cast vsc number]]
			axioms[ComponentGetValue2(vsc, "value_int")] = buffs[i]
			do_slot_check = true
		end
	end
	local force_sorted = false
	local arcanum_armament = false
	local arcanum_axiom = false
	local wand_id = nil --[[@cast wand_id number]]
	local wands = {}
	local inventories = EntityGetAllChildren(caster) or {}
	for inventory_index = 1, #inventories do
		if EntityGetName(inventories[inventory_index]) == "inventory_quick" then
			wands = EntityGetAllChildren(inventories[inventory_index], "wand") or {} break
		end
	end
	local inv2c = EntityGetFirstComponent(caster, "Inventory2Component") --[[@cast inv2c number]]
	local active_item = ComponentGetValue2(inv2c, "mActiveItem")
	for i=1, #wands do
		if wands[i] == active_item then
			wand_id = wands[i]
			local wand_children = EntityGetAllChildren(wands[i], "card_action") or {}
			for j=1,#wand_children do
				local iac = EntityGetFirstComponentIncludingDisabled(wand_children[j], "ItemActionComponent") --[[@cast iac number]]
				local action_id = ComponentGetValue2( iac, "action_id" )
				if do_slot_check then
					local ic = EntityGetFirstComponentIncludingDisabled(wand_children[j], "ItemComponent") --[[@cast ic number]]
					local slot_x, slot_y = ComponentGetValue2(ic, "inventory_slot")
					slots[#slots+1] = {slot_x, wand_children[j], action_id}
				end
				if action_id == "COPITH_ORDER_DECK" then
					force_sorted = true
					--[[
				elseif action_id == "COPITH_ARCANUM_ARMAMENT" or action_id == "COPITH_ARCANUM_AXIOM" then
					while #deck > 0 do
						table.insert(discarded, table.remove(deck))
					end]]
				elseif action_id == "COPITH_ARCANUM_ARMAMENT" then
					arcanum_armament = true
					while #deck > 0 do
						table.insert(discarded, table.remove(deck))
					end
				elseif action_id == "COPITH_ARCANUM_AXIOM" then
					arcanum_axiom = true
					while #deck > 0 do
						table.insert(discarded, table.remove(deck))
					end
				end
			end
			break
		end
	end
	return force_sorted, slots, arcanum_armament, arcanum_axiom, wand_id, axioms--, flip_every_other
end

local function order_deck()

	copi_state.skip_type = {
		[0] = false,
		[1] = false,
		[2] = false,
		[3] = false,
		[4] = false,
		[5] = false,
		[6] = false,
		[7] = false,
	}

	local shooter = GetUpdatedEntityID()
	local force_sorted, slots, arcanum_armament, arcanum_axiom, wand_id, axioms--[[, flip_every_other]] = get_force_sorted(shooter)

	if arcanum_axiom then
		table.sort(slots, function(x, y) return x[1] > y[1] end)
		for j=1,#slots do
			if slots[j][3] == "COPITH_ARCANUM_AXIOM" and j<#slots then
				local buff = axioms[slots[j][2]]
				local vsc = EntityGetFirstComponent(buff, "VariableStorageComponent") --[[@cast vsc number]]
				ComponentSetValue2(vsc, "value_string", slots[j+1][2])
			end
		end
	end
	--[[
	-- Check for existing wand, update it
	if arcanum_armament then
		local targets = EntityGetWithTag("jetpack") or {}
		for i=1, #targets do
			if EntityGetName(targets[i]) == "wand_"..tostring(wand_id) then
				break
			end
		end
	end]]

	if force_sorted then
		local before = gun.shuffle_deck_when_empty
		gun.shuffle_deck_when_empty = false
		copi_state.old._order_deck()
		gun.shuffle_deck_when_empty = before
	else
		copi_state.old._order_deck()
	end

	local vscs = EntityGetComponent(shooter, "VariableStorageComponent") or {}
	local vid = 0
	for i=1, #vscs do
		if ComponentGetValue2( vscs[i], "name" ) == "mana_efficiency_mult" then
			vid = vscs[i]
			break
		end
	end
	local shooter_mult = (vid > 0 and ComponentGetValue2(vid, "value_float")) or 1.0
	--[[
	if flip_every_other then
		copi_state.flip_deck = not copi_state.flip_deck
		if copi_state.flip_deck then
			table.sort(deck, function(x, y) return x.deck_index > y.deck_index end)
			print("HEY!")
		end
		shooter_mult = shooter_mult/2
	end]]


	--[[
	print(string.rep("\n", 3))
	print(string.rep("=", 131))
	]]
	-- This allows me to hook into the mana access and call an arbitrary function. Very tricksy :^)
	for _, action in pairs(deck) do
		--[[
		print(string.rep("\n", 3))
		print(string.rep("-", 131))
		for key, value in pairs(action) do
			print(string.format("%-60s | %70s", tostring(key), GameTextGetTranslatedOrNot(tostring(value))))
		end
		]]
		if action.copi_mana_calculated == nil then
			local meta = {}
			if action.skip_mana then
				action.mana = 0
			elseif action.type == ACTION_TYPE_PROJECTILE or action.type == ACTION_TYPE_STATIC_PROJECTILE or
				action.type == ACTION_TYPE_MATERIAL or action.type == ACTION_TYPE_UTILITY then
				local base_mana = action.mana or 0
				action.mana = nil
				meta['__index'] = function(table, key)
					if key == "mana" then
						-- todo optimize shooter mult in some way to not get vsc every time. do get number funcs work here?
						return (base_mana * copi_state.mana_multiplier) * shooter_mult
					end
				end
			end
			setmetatable(action, meta)
			action.copi_mana_calculated = true
		end
	end
end

return {order_deck = order_deck}