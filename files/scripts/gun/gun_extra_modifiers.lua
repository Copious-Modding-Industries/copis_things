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
			c.damage_ice_add = c.damage_ice_add + math.min(0.12 * ComponentGetValue2(VSC, "value_int"), 0.6)
			return
		end
	end
end

extra_modifiers["copis_things_mana_efficiency"] = function()
    mana = math.ceil(mana + c.action_mana_drain * 0.667)
end


extra_modifiers["copis_things_ammo_box"] = function()
        local shooter = GetUpdatedEntityID()
        local wand = GunUtils.current_wand(shooter)
        local spells = EntityGetAllChildren(wand) or {}
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
