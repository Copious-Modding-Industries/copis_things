_G['ACTION_LAST_C'] = {}


extra_modifiers["copis_things_lead_boots"] = function()
	local chardatcomp = EntityGetFirstComponentIncludingDisabled(GetUpdatedEntityID(), "CharacterDataComponent");
	if chardatcomp ~= nil then
		if ComponentGetValue2(chardatcomp, "is_on_ground") == true then
			shot_effects.recoil_knockback = shot_effects.recoil_knockback - 10000;
		end
	end
end

extra_modifiers["copis_things_spell_efficiency"] = function()
	if current_action.uses_remaining > 0 and math.random() <= 0.33 then
		current_action.uses_remaining = current_action.uses_remaining + 1;
	end
end

extra_modifiers["copith_cold_hearted"] = function()
	-- Prevent projectile n-dipping
	if c.cold_hearted then return end c.cold_hearted = true
	local children = EntityGetAllChildren(GetUpdatedEntityID()) or {}
	for i=1, #children do
		if EntityGetName(children[i]) == "cold_hearted" then
			local VSC = EntityGetFirstComponent(children[i], "VariableStorageComponent") ---@cast VSC number
			c.damage_ice_add = c.damage_ice_add + 0.12 * ComponentGetValue2(VSC, "value_int")
			return
		end
	end
end

extra_modifiers["copith_forward_thinking"] = function()
	--mana = math.max(0, mana-3) What's 3 mana debt? No biggie, disabling that will allow it to fuck over giga chicanery
	mana=mana-3
	draw_actions(1, true)
end

extra_modifiers["copith_volatic_impetus"] = function()
	add_projectile("mods/copis_things/files/entities/projectiles/shock.xml")
end

extra_modifiers["copith_focus"] = function()
	-- Prevent projectile n-dipping
	if c.focus_perk then return end c.focus_perk = true
	c.damage_critical_multiplier = c.damage_critical_multiplier + 2
	local children = EntityGetAllChildren(GetUpdatedEntityID()) or {}
	for i=1, #children do
		if EntityGetName(children[i]) == "focus_perk" then
			local GEC = EntityGetFirstComponentIncludingDisabled(children[i], "GameEffectComponent") ---@cast GEC number
			local UIC = EntityGetFirstComponentIncludingDisabled(children[i], "UIIconComponent") ---@cast UIC number
			c.damage_critical_chance = c.damage_critical_chance + (240 - ComponentGetValue2(GEC, "frames"))/2.40
			if ComponentGetValue2(GEC, "frames") == 0 then
				c.extra_entities = c.extra_entities .. "data/entities/particles/tinyspark_red.xml,"
			end
			ComponentSetValue2(GEC, "frames", 240)
			ComponentSetValue2(UIC, "icon_sprite_file", "mods/copis_things/files/ui_gfx/status_indicators/focus_less.png")
			return
		end
	end
end

extra_modifiers["copith_anathema"] = function()
	c.damage_projectile_add = c.damage_projectile_add - 0.4
	local x, y = EntityGetTransform(GetUpdatedEntityID())
	local enemies = EntityGetInRadiusWithTag(x, y, 128, "mortal")
	for i=1, #enemies do
		if EntityGetComponent(enemies[i], "GenomeDataComponent") ~= nil and EntityGetHerdRelation(GetUpdatedEntityID(), enemies[i]) < 70 and enemies[i] ~= GetUpdatedEntityID() then
			EntityInflictDamage(enemies[i], (c.action_mana_drain)/25, "DAMAGE_SLICE", "Anathema", "DISINTEGRATED", 0, 0, GetUpdatedEntityID())
		end
	end
end

extra_modifiers["copis_things_mana_efficiency"] = function()
	mana = math.ceil(mana + c.action_mana_drain * 0.667)
end


extra_modifiers["copis_things_ammo_box"] = function()
	if reflecting then return end
	local shooter = GetUpdatedEntityID()
	local wand = GunUtils.current_wand(shooter)
	local spells = EntityGetAllChildren(wand) or {}
	-- todo cache and then just check if it has the same ID
	local ammo_box_id = nil
	for i = 1, #spells do
		local spell = spells[i]
		if EntityHasTag(spell, "card_action") then
			local iac = EntityGetFirstComponentIncludingDisabled(spell, "ItemActionComponent") --[[@cast iac number]]
			if ComponentGetValue2(iac, "action_id") == "COPITH_AMMO_BOX" then
				local ic = EntityGetFirstComponentIncludingDisabled(spell, "ItemComponent") --[[@cast ic number]]
				if ComponentGetValue2(ic, "uses_remaining") > 0 then
					ammo_box_id = spell
					break
				end
			end
		end
	end

	if ammo_box_id and (current_action.max_uses or -1) > 0 then
		if not (_G['ACTION_LAST_C'][tostring(current_action):sub(8, -1)] == GlobalsGetValue("GLOBAL_CAST_STATE", "0")) then
			current_action.uses_remaining = current_action.uses_remaining + 1
			local ic = EntityGetFirstComponentIncludingDisabled(ammo_box_id, "ItemComponent") --[[@cast ic number]]
			ComponentSetValue2(ic, "uses_remaining", ComponentGetValue2(ic, "uses_remaining") - 1)
			_G['ACTION_LAST_C'][tostring(current_action):sub(8, -1)] = GlobalsGetValue("GLOBAL_CAST_STATE", "0")
		end
	end
end

extra_modifiers["copis_things_ammo_from_hp"] = function()
	local shooter = GetUpdatedEntityID()
	local dmc = EntityGetFirstComponent(shooter, "DamageModelComponent")
	if dmc then
		local hp = ComponentGetValue2(dmc, "hp")
		local max_hp = ComponentGetValue2(dmc, "max_hp")
		local hp_cost = current_action.mana / 25
			if (current_action.max_uses or -1) > 0 then
				if hp / max_hp > 0.5 and hp_cost < hp then
					if not (_G['ACTION_LAST_C'][tostring(current_action):sub(8, -1)] == GlobalsGetValue("GLOBAL_CAST_STATE", "0")) then
						ComponentSetValue2(dmc, "hp", hp - hp_cost)
						current_action.uses_remaining = current_action.uses_remaining + 1
					_G['ACTION_LAST_C'][tostring(current_action):sub(8, -1)] = GlobalsGetValue("GLOBAL_CAST_STATE", "0")
				end
			end
		end
	end
end
