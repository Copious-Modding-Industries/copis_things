---@diagnostic disable-next-line: lowercase-global
function damage_received( damage, message, entity_thats_responsible, is_fatal, projectile_thats_responsible )
	local util = dofile_once("mods/copis_things/files/scripts/lib/gooder_util.lua")
	local victim = GetUpdatedEntityID()
	local proj = EntityGetFirstComponent(projectile_thats_responsible, "ProjectileComponent")
	--local damagefield = ComponentObjectGetValue2(message, "config", "action_type")
	if proj then
		local shooter = ComponentGetValue2(proj, "mWhoShot")
		local bitfield = ComponentObjectGetValue2(proj, "config", "action_type")
		--[[ Extract enum data packed into action type
			1	1:		Faction damage, slime
			2	2:		Faction damage, robot
			3	4:		Faction damage, orcs
			4	8:		Faction damage, mage
			5	16:		Faction damage, ghost
			6	32:		Shatter modifier
			7	64:		Frozen on Wet (Snap Freeze)
			8	128:	Burn on Oiled (Flash Burn)
			9	256:	Poison on Bloody (Viral Affliction)
			10	512:	Cold Hearted
			11	1024:	Blood Forge
		]]
		local config_data = {
			function ()

			end,
			function ()

			end,
			function ()

			end,
			function ()

			end,
			function ()

			end,

			--[[ ==================================================== Detect 'Shatter' modifier (or damage caused by it) ====================================================
				If the enemy is frozen or takes ice damage:
					Increased damage
					On Kill: Fire icicles out
			]]
			function ()
				if (message:find("damage_ice") or GameGetGameEffectCount(victim, "FROZEN")>=1) or message:find("Shattered!") then
					if is_fatal then
						for i=1, 3 do
							local created_proj_id = util.shoot_proj(nil, math.random(-math.pi, math.pi), "mods/copis_things/files/entities/projectiles/shatter_icicle.xml", shooter)
						end
					else
						EntityInflictDamage(victim, 0.2, "DAMAGE_PHYSICS_BODY_DAMAGED", "Shattered!", "FROZEN", 0, 0, entity_thats_responsible)
					end
				end
			end,

			--[[ ==================================================== Detect 'Snap Freeze' modifier ====================================================
				If the enemy is wet or shot inflicts wet:
					Inflict frozen
					Deal 2x damage
			]]
			function (count)
				if ComponentObjectGetValue2(proj, "config", "game_effect_entities"):find("effect_apply_wet") or GameGetGameEffectCount(victim, "WET")>=1 then
					LoadGameEffectEntityTo(victim, "data/entities/misc/effect_frozen_short.xml")
					EntityInflictDamage(victim, damage*count, "DAMAGE_ICE", "$damage_ice", "FROZEN", 0, 0, entity_thats_responsible)
				end
			end,

			--[[ ==================================================== Detect 'Flash Burn' modifier ====================================================
				If the enemy is oiled or shot inflicts oiled:
					Inflict burn
					Deal 2x damage
			]]
			function (count)
				if ComponentObjectGetValue2(proj, "config", "game_effect_entities"):find("effect_apply_oiled") or GameGetGameEffectCount(victim, "OILED")>=1 then
					LoadGameEffectEntityTo(victim, "data/entities/misc/effect_apply_on_fire.xml")
					EntityInflictDamage(victim, damage*count, "DAMAGE_FIRE", "$damage_fire", "DISINTEGRATED", 0, 0, entity_thats_responsible)
				end
			end,

			--[[ ==================================================== Detect 'Viral Affliction' modifier ====================================================
				If the enemy is bloody or shot inflicts bloody:
					Inflict poison
					Deal 2x damage
			]]
			function (count)
				if ComponentObjectGetValue2(proj, "config", "game_effect_entities"):find("effect_apply_bloody") or GameGetGameEffectCount(victim, "BLOODY")>=1 then
					LoadGameEffectEntityTo(victim, "data/entities/misc/effect_poison.xml")
					EntityInflictDamage(victim, damage*count, "DAMAGE_POISON", "$damage_poison", "NORMAL", 0, 0, entity_thats_responsible)
				end
			end,

			--[[ ==================================================== Detect 'Cold Hearted' modifier ====================================================
				On kill:
					Give buff stack, limited to 5 instances.
			]]
			function (count)
				if not is_fatal then return end
				count = tonumber(count)
				local children = EntityGetAllChildren(entity_thats_responsible) or {}
				for i=1, #children do
					if EntityGetName(children[i]) == "cold_hearted" then
						local GEC = EntityGetFirstComponent(children[i], "GameEffectComponent") ---@cast GEC number
						local VSC = EntityGetFirstComponent(children[i], "VariableStorageComponent") ---@cast VSC number
						ComponentSetValue2(GEC, "frames", 601)
						local stacks = ComponentGetValue2(VSC, "value_int")
						if stacks < 5*count then
							stacks = stacks+count
							local UIC = EntityGetFirstComponent(children[i], "UIIconComponent") ---@cast UIC number
							ComponentSetValue2(UIC, "icon_sprite_file", table.concat{"mods/copis_things/files/ui_gfx/status_indicators/cold_hearted_", math.floor(stacks/count), ".png"})
							ComponentSetValue2(UIC, "name", GameTextGet("$effectname_copith_cold_hearted", tostring(stacks)))
							ComponentSetValue2(UIC, "description", GameTextGet("$effectdesc_copith_cold_hearted", tostring(3*(stacks))))
							ComponentSetValue2(VSC, "value_int", stacks)
						end
						return
					end
				end
				local eid = LoadGameEffectEntityTo(entity_thats_responsible, "mods/copis_things/files/entities/misc/status_entities/cold_hearted.xml")
				local UIC = EntityGetFirstComponent(eid, "UIIconComponent") ---@cast UIC number
				ComponentSetValue2(UIC, "name", GameTextGet("$effectname_copith_cold_hearted", "1"))
				ComponentSetValue2(UIC, "description", GameTextGet("$effectdesc_copith_cold_hearted", "3"))
			end,

			--[[ ==================================================== Detect 'Blood Forge' passive ====================================================
				On kill:
					Chance to restore charges to spells on wand. True limited spells have a biome limit.
			]]
			function ()
				if not is_fatal then return end
				-- Find wands with spell
				local items = GameGetAllInventoryItems( shooter ) or {}
				local wands = {}
				for i=1, #items do
					if EntityHasTag(items[i], "wand") then
						local spells = EntityGetAllChildren(items[i], "card_action") or {}
						for j=1, #spells do
							local iac = EntityGetFirstComponentIncludingDisabled(spells[j], "ItemActionComponent") --[[@cast iac number]]
							if ComponentGetValue2(iac, "action_id") == "COPITH_BLOOD_FORGE" then
								wands[#wands+1] = {}
								for k=1, #spells do
									local ic = EntityGetFirstComponentIncludingDisabled(spells[k], "ItemComponent") --[[@cast ic number]]
									if ComponentGetValue2(ic, "uses_remaining") >= 0 then
										wands[#wands][#wands[#wands]+1] = ic
									end
								end
								break
							end
						end
					end
				end
				math.randomseed(GameGetFrameNum(), projectile_thats_responsible)
				if (math.random() > 0.02) then
					for i=1, #wands do
						local target = wands[i][math.random(1, #wands[i])]
						ComponentSetValue2(target, "uses_remaining", ComponentGetValue2(target, "uses_remaining")+1)
					end
				end

			end,
		}
		for i=0, #config_data-1 do
			if bit.band(bitfield, 2^i) == 2^i then
				config_data[i+1]()
			end
		end




	end

end