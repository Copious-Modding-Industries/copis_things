dofile_once("mods/copis_things/files/scripts/lib/disco_util/disco_util.lua")
-- Evil lib todo remove


-- Evil regex: \t\{([\t\r\n\s\S]*?)(?=\s*action\s*=\s*function\()[^\n(?=\n\s*action\s*=\s*function\()]*

local meta_manager = function(action, current_id)
	if action['id'] == current_id then
		if not HasFlagPersistent("copis_things_meta_spell") then
			GamePrintImportant("$secret_meta_spell_main", "$secret_meta_spell_sub")
			AddFlagPersistent("copis_things_meta_spell")
		end
		return true
	end
	return false
end

local year, month, day, hour = GameGetDateAndTimeLocal()
local events = {
	april_fools = month == 4 and day == 1,
	birthday = month == 11 and day == 11
}



-- prevent angry code
---@diagnostic disable-next-line: lowercase-global


local actions_to_insert = {
	{
		id                = "COPITH_PSYCHIC_SHOT",
		name              = "$actionname_psychic_shot",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_psychic_shot",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/psychic_shot.png",
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "2,3,4,5,6",
		spawn_probability = "0.3,0.4,0.5,0.6,0.6",
		inject_after      = {"HOMING", "HOMING_SHORT", "HOMING_ROTATE", "HOMING_SHOOTER", "AUTOAIM", "HOMING_ACCELERATING", "HOMING_CURSOR", "HOMING_AREA"},
		subtype           = { homing = true },
		price             = 150,
		mana              = 15,
		pandorium_ignore  = true,
		action            = function()
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/psychic_shot.xml,"
			draw_actions(1, true)
		end
	},
	-- LUNGE
	{
		id                = "COPITH_LUNGE",
		name              = "$actionname_lunge",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_lunge",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/lunge.png",
		type              = ACTION_TYPE_UTILITY,
		spawn_level       = "2,4",
		spawn_probability = "0.6,0.6",
		price             = 100,
		mana              = 5,
		pandorium_ignore  = true,
		ai_never_uses     = true,
		action            = function()
			local entity_id = GetUpdatedEntityID()
			local controls_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "ControlsComponent")
			if controls_comp ~= nil then
				local character_data_comp = EntityGetFirstComponent(entity_id, "CharacterDataComponent")
				if character_data_comp ~= nil then
					local caster = {
						velocity = { x = 0, y = 0 },
						position = { x = 0, y = 0 }
					}
					local mouse = {
						position = { x = 0, y = 0 }
					}

					caster.position.x, caster.position.y = EntityGetTransform(entity_id)
					caster.velocity.x, caster.velocity.y = ComponentGetValueVector2(character_data_comp, "mVelocity")
					mouse.position.x, mouse.position.y = ComponentGetValueVector2(controls_comp, "mMousePosition")

					local offset = {
						x = mouse.position.x - caster.position.x,
						y = mouse.position.y - caster.position.y
					}
					local force = {
						x = 650,
						y = 1000
					}

					local len = math.sqrt((offset.x ^ 2) + (offset.y ^ 2))
					caster.velocity.x = caster.velocity.x + (offset.x / len * force.x)
					caster.velocity.y = caster.velocity.y + (offset.y / len * force.y)

					ComponentSetValue2(character_data_comp, "mVelocity", caster.velocity.x, caster.velocity.y)
				end
			end
		end
	},
	{
		id                = "COPITH_PROJECTION_CAST",
		name              = "$actionname_projection_cast",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_projection_cast",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/projection_cast.png",
		type              = ACTION_TYPE_UTILITY,
		spawn_level       = "6,10",
		spawn_probability = "0.2,0.7",
		inject_after      = {"SUPER_TELEPORT_CAST", "TELEPORT_CAST", "LONG_DISTANCE_CAST"},
		price             = 250,
		mana              = 50,
		pandorium_ignore  = true,
		action            = function()
			c.fire_rate_wait = c.fire_rate_wait + 10
			c.spread_degrees = c.spread_degrees - 6
			if not reflecting then
				add_projectile_trigger_death("mods/copis_things/files/entities/projectiles/projection_cast.xml", 1)
			end
		end
	},
	{
		id                = "COPITH_SLOW",
		name              = "$actionname_slow",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_slow",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/slow.png",
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "1,		2,		3,		4",
		spawn_probability = "0.8,		0.8,	0.8,	0.8",
		inject_after      = {"SPEED"},
		price             = 50,
		mana              = -3,
		--max_uses        = 100,
		custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/slow.xml",
		action = function()
			c.speed_multiplier = c.speed_multiplier * 0.6
			c.spread_degrees = c.spread_degrees - 8
			draw_actions(1, true)
		end
	},
	{
		id                = "COPITH_CLAIRVOYANCE",
		name              = "$actionname_clairvoyance",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_clairvoyance",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/clairvoyance.png",
		type              = ACTION_TYPE_PASSIVE,
		spawn_level       = "1,2,3,4,5,6",
		spawn_probability = "0.1,0.5,1,1,1,1",
		inject_after      = {"TORCH", "TORCH_ELECTRIC"},
		price             = 160,
		mana              = 0,
		custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/clairvoyance.xml",
		action = function()
			draw_actions(1, true)
		end
	},
	{
		id                = "COPITH_ANCHORED_SHOT",
		name              = "$actionname_anchored_shot",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_anchored_shot",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/anchored_shot.png",
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "1,2,3",
		spawn_probability = "1,0.5,0.5",
		price             = 100,
		mana              = 10,
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 26
			if reflecting then
				return
			end
			if c.formation == nil then
				c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/anchored_shot.xml,"
				c.formation = "anchored"
			end
			c.spread_degrees = c.spread_degrees - 10
			c.lifetime_add = c.lifetime_add + 250
			draw_actions(1, true)
		end
	},
	{
		id                = "COPITH_LEVITY_SHOT",
		name              = "$actionname_levity_shot",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_levity_shot",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/levity_shot.png",
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "1,2,3",
		spawn_probability = "1,0.5,0.5",
		price             = 100,
		mana              = 5,
		action = function()
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/levity_shot.xml,"
			c.speed_multiplier = c.speed_multiplier * 0.9
			c.spread_degrees = c.spread_degrees - 10
			draw_actions(1, true)
		end
	},
	{
		id                = "COPITH_SPREAD",
		name              = "$actionname_spread",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_spread",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/spread.png",
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "1,2,3,4,5,6",
		spawn_probability = "0.8,0.8,0.8,0.8,0.8,0.8",
		price             = 100,
		mana              = -5,
		action = function()
			c.spread_degrees = c.spread_degrees + 30.0
			c.fire_rate_wait = c.fire_rate_wait - 5
			draw_actions(1, true)
		end
	},
	{
		id                  = "COPITH_DART",
		name                = "$actionname_dart",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_dart",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/dart.png",
		related_projectiles = { "mods/copis_things/files/entities/projectiles/dart.xml" },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "0,1,2",
		spawn_probability   = "2,1,0.5",
		inject_after        = {"BULLET", "BULLET_TRIGGER", "BULLET_TIMER"},
		price               = 120,
		mana                = 7,
		action = function()
			add_projectile("mods/copis_things/files/entities/projectiles/dart.xml")
			c.fire_rate_wait = c.fire_rate_wait + 2
		end
	},
	{
		id                  = "COPITH_TEMPORARY_CIRCLE",
		name                = "$actionname_temporary_circle",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_temporary_circle",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/temporary_circle.png",
		related_projectiles = { "mods/copis_things/files/entities/projectiles/temporary_circle.xml" },
		type                = ACTION_TYPE_UTILITY,
		spawn_level         = "0,1,2,4,5,6",
		spawn_probability   = "0.1,0.1,0.3,0.4,0.2,0.1",
		inject_after        = {"TEMPORARY_WALL", "TEMPORARY_PLATFORM"},
		price               = 100,
		mana                = 40,
		max_uses            = 20,
		action = function()
			add_projectile("mods/copis_things/files/entities/projectiles/temporary_circle.xml")
			c.fire_rate_wait = c.fire_rate_wait + 40
		end
	},
	{
		id                     = "COPITH_LARPA_FORWARDS",
		name                   = "$actionname_larpa_forwards",
		author                 = "Copi",
		mod                    = "Copi's Things",
		description            = "$actiondesc_larpa_forwards",
		sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/forwards_larpa.png",
		related_extra_entities = { "mods/copis_things/files/entities/misc/forwards_larpa.xml" },
		type                   = ACTION_TYPE_MODIFIER,
		spawn_level            = "2,3,4,5,10",
		spawn_probability      = "0.1,0.2,0.3,0.4,0.2",
		inject_after           = {"LARPA_CHAOS", "LARPA_DOWNWARDS", "LARPA_UPWARDS", "LARPA_CHAOS_2", "LARPA_DEATH"},
		price                  = 260,
		mana                   = 100,
		--max_uses             = 20,
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 15
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/forwards_larpa.xml,"
			draw_actions(1, true)
		end
	},

	{
		id                     = "COPITH_GUNNER_SHOT",
		name                   = "$actionname_gunner_shot",
		author                 = "Copi",
		mod                    = "Copi's Things",
		description            = "$actiondesc_gunner_shot",
		sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/gunner_shot.png",
		related_extra_entities = { "mods/copis_things/files/entities/misc/gunner_shot.xml" },
		type                   = ACTION_TYPE_MODIFIER,
		spawn_level            = "2,3,4,5,10",
		spawn_probability      = "0.1,0.2,0.3,0.4,0.1",
		price                  = 260,
		mana                   = 100,
		--max_uses             = 20,
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 15
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/gunner_shot.xml,"
			draw_actions(1, true)
		end
	},
	{
		id                     = "COPITH_GUNNER_SHOT_STRONG",
		name                   = "$actionname_gunner_shot_strong",
		author                 = "Copi",
		mod                    = "Copi's Things",
		description            = "$actiondesc_gunner_shot_strong",
		sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/gunner_shot_strong.png",
		related_extra_entities = { "mods/copis_things/files/entities/misc/gunner_shot_strong.xml" },
		type                   = ACTION_TYPE_MODIFIER,
		spawn_level            = "2,3,4,5,10",
		spawn_probability      = "0.1,0.2,0.3,0.4,0.1",
		price                  = 260,
		mana                   = 100,
		--max_uses             = 20,
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 15
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/gunner_shot_strong.xml,"
			draw_actions(1, true)
		end
	},
	{
		id                = "COPITH_SOIL_TRAIL",
		name              = "$actionname_soil_trail",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_soil_trail",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/soil_trail.png",
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "2,3,4",
		spawn_probability = "0.3,0.3,0.3",
		inject_after      = {"ACID_TRAIL", "POISON_TRAIL", "OIL_TRAIL", "WATER_TRAIL", "GUNPOWDER_TRAIL", "FIRE_TRAIL"},
		price             = 160,
		mana              = 10,
		action = function()
			c.trail_material = c.trail_material .. "soil,"
			c.trail_material_amount = c.trail_material_amount + 9
			draw_actions(1, true)
		end
	},
	{
		id                  = "COPITH_CONCRETEBALL",
		name                = "$actionname_concreteball",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_concreteball",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/chunk_of_concrete.png",
		related_projectiles = { "mods/copis_things/files/entities/projectiles/chunk_of_concrete.xml" },
		type                = ACTION_TYPE_MATERIAL,
		spawn_level         = "1,2,3,5",
		spawn_probability   = "1,1,1,1",
		inject_after        = {"SOILBALL"},
		price               = 10,
		mana                = 5,
		action = function()
			add_projectile("mods/copis_things/files/entities/projectiles/chunk_of_concrete.xml")
		end
	},
	{
		id                = "COPITH_EVISCERATOR_DISC",
		name              = "$actionname_eviscerator_disc",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_eviscerator_disc",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/eviscerator.png",
		inject_after      = {"ALL_SPELLS"},
		type              = ACTION_TYPE_OTHER,
		spawn_level       = "6,10",
		spawn_probability = "0.1,0.1",
		price             = 1000,
		mana              = 280,
		recursive         = true,
		pandorium_ignore  = true,
		custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/eviscerator.xml",
		action = function()
			if reflecting then
				return
			end
			c.spread_degrees = c.spread_degrees + 5.0
			add_projectile("mods/copis_things/files/entities/projectiles/eviscerator.xml")
		end
	},
	{
		id                = "COPITH_SUMMON_HAMIS",
		name              = "$actionname_summon_hamis",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_summon_hamis",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/summon_hamis.png",
		type              = ACTION_TYPE_UTILITY,
		spawn_level       = "0,1,2,3,4,5,6",
		spawn_probability = "0.3,0.2,0.2,0.2,0.2,0.2,0.2",
		price             = 0,
		mana              = 10,
		action = function()
			add_projectile("mods/copis_things/files/entities/projectiles/longleg_projectile.xml")
			c.fire_rate_wait = c.fire_rate_wait + 10
		end
	},
	{
		id                  = "COPITH_SILVER_BULLET",
		name                = "$actionname_silver_bullet",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_silver_bullet",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/silver_bullet.png",
		related_projectiles = { "mods/copis_things/files/entities/projectiles/silver_bullet.xml" },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "2,3,4",
		spawn_probability   = "1,1,0.5",
		price               = 220,
		mana                = 25,
		action = function()
			add_projectile("mods/copis_things/files/entities/projectiles/silver_bullet.xml")
			c.fire_rate_wait = c.fire_rate_wait - 12
		end
	},
	{
		id                  = "COPITH_SILVER_MAGNUM",
		name                = "$actionname_silver_magnum",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_silver_magnum",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/silver_magnum.png",
		related_projectiles = { "mods/copis_things/files/entities/projectiles/silver_magnum.xml" },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "4,			5,			6",
		spawn_probability   = "1.00,		0.66,		0.33",
		price               = 330,
		mana                = 40,
		action = function()
			add_projectile("mods/copis_things/files/entities/projectiles/silver_magnum.xml")
			c.fire_rate_wait = c.fire_rate_wait - 6
		end
	},
	{
		id                  = "COPITH_SILVER_BULLET_DEATH_TRIGGER",
		name                = "$actionname_silver_bullet_death_trigger",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_silver_bullet_death_trigger",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/silver_bullet_death_trigger.png",
		related_projectiles = { "mods/copis_things/files/entities/projectiles/silver_bullet.xml" },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "4,			5,			6",
		spawn_probability   = "1.00,		0.50,		0.20",
		price               = 220,
		mana                = 30,
		action = function()
			add_projectile_trigger_death("mods/copis_things/files/entities/projectiles/silver_bullet.xml", 1)
			c.fire_rate_wait = c.fire_rate_wait - 12
		end
	},
	{
		id                  = "COPITH_SILVER_MAGNUM_DEATH_TRIGGER",
		name                = "$actionname_silver_magnum_death_trigger",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_silver_magnum_death_trigger",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/silver_magnum_death_trigger.png",
		related_projectiles = { "mods/copis_things/files/entities/projectiles/silver_magnum.xml" },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "2, 3, 4",
		spawn_probability   = "1.00, 0.66, 0.33",
		price               = 330,
		mana                = 45,
		action = function()
			add_projectile_trigger_death("mods/copis_things/files/entities/projectiles/silver_magnum.xml", 1)
			c.fire_rate_wait = c.fire_rate_wait - 6
		end
	},
	{
		   id                     = "COPITH_SLOTS_TO_POWER",
		   name                   = "$actionname_slots_to_power",
		   author                 = "Copi",
		   mod                    = "Copi's Things",
		   description            = "$actiondesc_slots_to_power",
		   sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/slots_to_power.png",
		   sprite_unidentified    = "data/ui_gfx/gun_actions/homing_unidentified.png",
		   related_extra_entities = { "mods/copis_things/files/entities/misc/slots_to_power.xml" },
		   type                   = ACTION_TYPE_MODIFIER,
		   spawn_level            = "1,2,3,10",
		   spawn_probability      = "0.2,0.5,0.5,0.1",
		   price                  = 120,
		   mana                   = 110,
		-- max_uses               = 20,
		action = function()
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/slots_to_power.xml,"
			c.fire_rate_wait = c.fire_rate_wait + 20
			draw_actions(1, true)
		end
	},
	--[=[
	-- TODO translations
	-- TODO figure out why the gods are so sus
	{   -- Unshuffle
		id                = "COPITH_UPGRADE_GUN_SHUFFLE",
		name              = "Upgrade - Unshuffle (One-off)",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_upgrade_gun_shuffle",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/upgrade_gun_shuffle.png",
		type              = ACTION_TYPE_UTILITY,
		spawn_level       = "1,2,3,10",
		spawn_probability = "1.2,1.2,0.3,0.4",
		price             = 840,
		mana              = 0,
		recursive         = true,
		never_ac          = true,
		action = function(recursion_level, iteration)
			-- Check for initial reflection and greek letters/non-self casts
			if not reflecting then
				local this_wand = GunUtils.current_wand(GetUpdatedEntityID())
				local this_card = GunUtils.current_card(this_wand)
				local pos_x, pos_y = EntityGetTransform(this_wand)
				if current_action.id == "COPITH_UPGRADE_GUN_SHUFFLE" then
					local ability = EntityGetFirstComponentIncludingDisabled(this_wand, "AbilityComponent") --[[@cast ability integer]]
					if ComponentObjectGetValue2(ability, "gun_config", "shuffle_deck_when_empty") then
						-- I have no clue what this bs scaling is I threw it together in desmso DM if you have a better func to use
						GunUtils.update_ability(ability, {
							-- gunaction_config
							{
								object = 'gunaction_config',
								key    = 'fire_rate_wait',
								modify = function (old)
									return old * 1.1
								end,
							},
							-- gun_config
							{
								object = 'gun_config',
								key    = 'actions_per_round',
								modify = function (old)
									return math.max(1, old-1)
								end,
							},
							{
								object = 'gun_config',
								key    = 'shuffle_deck_when_empty',
								value  = false,
							},
							{
								object = 'gun_config',
								key    = 'reload_time',
								modify = function (old)
									return old * 1.1
								end,
							},
							-- Ability
							{
								key    = 'mana_max',
								modify = function (old)
									return old * 0.9
								end,
							},
							{
								key    = 'mana_charge_speed',
								modify = function (old)
									return old * 0.9
								end,
							},
						})
						--stuff
						GameScreenshake(50, pos_x, pos_y)
						GamePrintImportant("Wand unshuffled!", "Stats slightly reduced.")
						-- Remove this spell
						EntityKill(this_card)
					end
				else
					GamePlaySound("data/audio/Desktop/items.bank", "magic_wand/out_of_mana", pos_x, pos_y)
					GamePrintImportant("Your wand is already unshuffled!", "")
					-- non-self cast alert
					GamePrintImportant("You cannot cheat the gods!", "")
				end
			end
		end
	},
	{   -- Shuffle
		id                = "COPITH_UPGRADE_GUN_SHUFFLE_BAD",
		name              = "Upgrade - Shuffle (One-off)",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_upgrade_gun_shuffle_bad",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/upgrade_gun_shuffle_bad.png",
		type              = ACTION_TYPE_UTILITY,
		spawn_level       = "1,2,3,10",
		spawn_probability = "0.6,0.7,0.5,0.2",
		price             = 840,
		mana              = 0,
		recursive         = true,
		never_ac          = true,
		action = function(recursion_level, iteration)
			-- Check for initial reflection and greek letters/non-self casts
			if not reflecting then
				local this_wand = GunUtils.current_wand(GetUpdatedEntityID())
				local this_card = GunUtils.current_card(this_wand)
				local pos_x, pos_y = EntityGetTransform(this_wand)
				if current_action.id == "COPITH_UPGRADE_GUN_SHUFFLE_BAD" then
					local ability = EntityGetFirstComponentIncludingDisabled(this_wand, "AbilityComponent") --[[@cast ability integer]]
						if ComponentObjectGetValue2(ability, "gun_config", "shuffle_deck_when_empty") then
							-- I have no clue what this bs scaling is I threw it together in desmso DM if you have a better func to use
							GunUtils.update_ability(ability, {
								-- gunaction_config
								{
									object = 'gunaction_config',
									key    = 'fire_rate_wait',
									modify = function (old)
										return old * 0.55
									end,
								},
								-- gun_config
								{
									   object = 'gun_config',
									   key    = 'actions_per_round',
									   modify = function (old)
									if old <  = 26 then
											math.min(old+math.random(0,3), 26)
										end
										return old
									end,
								},
								{
									object = 'gun_config',
									key    = 'shuffle_deck_when_empty',
									value  = true,
								},
								{
									object = 'gun_config',
									key    = 'reload_time',
									modify = function (old)
										return old * math.random(0.55, 0.75) - 5
									end,
								},
								-- Ability
								{
									key    = 'mana_max',
									modify = function (old)
										return old * math.random(1.2, 1.6) + math.random(20,60)
									end,
								},
								{
									key    = 'mana_charge_speed',
									modify = function (old)
										return old * math.random(1.2, 1.6) + math.random(20,60)
									end,
								},
							})
							--stuff
							GameScreenshake(50, pos_x, pos_y)
							GamePrintImportant("Wand unshuffled!", "Stats slightly reduced.")
							-- Remove this spell
							EntityKill(this_card)
						end
				else
					GamePlaySound("data/audio/Desktop/items.bank", "magic_wand/out_of_mana", pos_x, pos_y)
					GamePrintImportant("Your wand is already unshuffled!", "")
					-- non-self cast alert
					GamePrintImportant("You cannot cheat the gods!", "")
				end
			end
		end
	},
	{   -- S/C
		id                = "COPITH_UPGRADE_ACTIONS_PER_ROUND",
		name              = "Upgrade - Spells per Cast (One-off)",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_upgrade_actions_per_round",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/upgrade_actions_per_round.png",
		type              = ACTION_TYPE_UTILITY,
		spawn_level       = "1,2,3,10",
		spawn_probability = "1,1,0.5,0.1",
		price             = 840,
		mana              = 0,
		recursive         = true,
		never_ac          = true,
		action = function(recursion_level, iteration)
			-- Check for initial reflection and greek letters/non-self casts
			if not reflecting then
				local this_wand = GunUtils.current_wand(GetUpdatedEntityID())
				local this_card = GunUtils.current_card(this_wand)
				local pos_x, pos_y = EntityGetTransform(this_wand)
				if current_action.id == "COPITH_UPGRADE_ACTIONS_PER_ROUND" then
					local ability = EntityGetFirstComponentIncludingDisabled(this_wand, "AbilityComponent") --[[@cast ability integer]]
					-- I have no clue what this bs scaling is I threw it together in desmso DM if you have a better func to use
					GunUtils.update_ability(ability, {
						-- gun_config
						{
							object = 'gun_config',
							key    = 'actions_per_round',
							modify = function (old)
								--stuff
								old = math.min(old+math.random(1,2), 32)
								GameScreenshake(50, pos_x, pos_y)
								GamePrintImportant("Wand upgraded!", old .. " spells per cast.")
								return old
							end,
						},
					})
					-- Remove this spell
						EntityKill(this_card)
				else
					GamePlaySound("data/audio/Desktop/items.bank", "magic_wand/out_of_mana", pos_x, pos_y)
					-- non-self cast alert
					GamePrintImportant("You cannot cheat the gods!", "")
				end
			end
		end
	},
	{   -- Speed
		id                = "COPITH_UPGRADE_SPEED_MULTIPLIER",
		name              = "Upgrade - Spell speed multiplier (One-off)",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_upgrade_speed_multiplier",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/upgrade_speed_multiplier.png",
		type              = ACTION_TYPE_UTILITY,
		spawn_level       = "1,2,3,10",
		spawn_probability = "1,1,0.5,0.1",
		price             = 840,
		mana              = 0,
		recursive         = true,
		never_ac          = true,
		action = function(recursion_level, iteration)
			-- Check for initial reflection and greek letters/non-self casts
			if not reflecting and current_action.id == "COPITH_UPGRADE_SPEED_MULTIPLIER" then
				local this_wand = GunUtils.current_wand(GetUpdatedEntityID())
				local this_card = GunUtils.current_card(this_wand)
				local pos_x, pos_y = EntityGetTransform(this_wand)
				local ability = EntityGetFirstComponentIncludingDisabled(this_wand, "AbilityComponent") --[[@cast ability integer]]
				if ability then
					-- I have no clue what this bs scaling is I threw it together in desmso DM if you have a better func to use
					GunUtils.update_ability(ability, {
						-- gunaction_config
						{
							object = 'gunaction_config',
							key    = 'speed_multiplier',
							modify = function (old)
								--stuff
								old = old + Random(2, 3)
								GameScreenshake(50, pos_x, pos_y)
								GamePrintImportant("Wand upgraded!", tostring(old) .. " speed multiplier.")
								return old
							end,
						},
					})
					-- Remove this spell
					EntityKill(this_card)
				end
			else
				-- non-self cast alert
				GamePrintImportant("You cannot cheat the gods!", "")
			end
		end
	},
	{   -- Capacity
		id                = "COPITH_UPGRADE_GUN_CAPACITY",
		name              = "Upgrade - Wand capacity (One-off)",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_upgrade_gun_capacity",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/upgrade_gun_capacity.png",
		type              = ACTION_TYPE_UTILITY,
		spawn_level       = "1,2,3,10",
		spawn_probability = "1,1,0.5,0.1",
		price             = 840,
		mana              = 0,
		recursive         = true,
		never_ac          = true,
		action = function(recursion_level, iteration)
			-- Check for initial reflection and greek letters/non-self casts
			if not reflecting then
				local this_wand = GunUtils.current_wand(GetUpdatedEntityID())
				local this_card = GunUtils.current_card(this_wand)
				local pos_x, pos_y = EntityGetTransform(this_wand)
				if current_action.id == "COPITH_UPGRADE_GUN_CAPACITY" then
					local ability = EntityGetFirstComponentIncludingDisabled(this_wand, "AbilityComponent") --[[@cast ability integer]]
					if ComponentObjectGetValue2(ability, "gun_config", "deck_capacity") < 26 then
						-- I have no clue what this bs scaling is I threw it together in desmso DM if you have a better func to use
						GunUtils.update_ability(ability, {
							-- gun_config
							{
								object = 'gun_config',
								key    = 'deck_capacity',
								modify = function (old)
									--stuff

									old = math.min(old+math.random(1,2), 32)
									GameScreenshake(50, pos_x, pos_y)
									GamePrintImportant("Wand upgraded!", old .. " spells per cast.")
									return old
								end,
							},
						})
						-- Remove this spell
						EntityKill(this_card)
					else
						GamePrintImportant("Wand is already too large!")
					end
				else
					GamePlaySound("data/audio/Desktop/items.bank", "magic_wand/out_of_mana", pos_x, pos_y)
					-- non-self cast alert
					GamePrintImportant("You cannot cheat the gods!", "")
				end
			end


			-- Check for initial reflection
			if not reflecting then
				-- Check for greek letters/non-self casts
				if    current_action.id == "COPITH_UPGRADE_GUN_CAPACITY" then
				local EZWand             = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
				local entity_id          = GetUpdatedEntityID()
				local inventory          = EntityGetFirstComponent(entity_id, "Inventory2Component")
				if    inventory         ~= nil then
				local active_wand        = ComponentGetValue2(inventory, "mActiveItem")
				local pos_x ,             pos_y = EntityGetTransform(entity_id)
				local wand               = EZWand(active_wand)
				if    wand              ~= nil then
							if (wand.capacity < 26) then
								wand: RemoveSpells("COPITH_UPGRADE_GUN_CAPACITY")
								SetRandomSeed(pos_x, pos_y + GameGetFrameNum() + 137)
								      wand.capacity                                                   = wand.capacity + Random(1, 3)
								local sprite_file                                                     = wand:GetSprite()
								if    not sprite_file:match("data/items_gfx/wands/wand_0%d%d%d.png") == nil then
									wand: UpdateSprite()
								end
								GameScreenshake(50, pos_x, pos_y)
								GamePrintImportant("Wand upgraded!", tostring(wand.capacity) .. " capacity.")
							end
						end
					else
						-- non-self cast alert
						GamePrintImportant("You cannot cheat the gods!", "")
					end
				end
			end
		end
	},
	{   -- Cast Delay
		id                = "COPITH_UPGRADE_FIRE_RATE_WAIT",
		name              = "Upgrade - Cast Delay (One-off)",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_upgrade_fire_rate_wait",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/upgrade_fire_rate_wait.png",
		type              = ACTION_TYPE_UTILITY,
		spawn_level       = "1,2,3,10",
		spawn_probability = "1,1,0.5,0.2",
		price             = 840,
		mana              = 0,
		recursive         = true,
		never_ac          = true,
		action = function(recursion_level, iteration)
			-- Check for initial reflection and greek letters/non-self casts
			if reflecting then return end
			if current_action.id == "COPITH_UPGRADE_FIRE_RATE_WAIT" then

				local this_wand = GunUtils.current_wand(GetUpdatedEntityID())
				local this_card = GunUtils.current_card(this_wand)
				local ability = EntityGetComponentIncludingDisabled(this_wand, "AbilityComponent")
				if ability then

					EntityKill(this_card)
				end
			else

				-- non-self cast alert
				GamePrintImportant("You cannot cheat the gods!", "")
			end



			-- Check for initial reflection
			if not reflecting then
				-- Check for greek letters/non-self casts
				if current_action.id == "COPITH_UPGRADE_FIRE_RATE_WAIT" then
					local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
					local entity_id = GetUpdatedEntityID()
					local inventory = EntityGetFirstComponent(entity_id, "Inventory2Component")
					if inventory ~= nil then
						local active_wand = ComponentGetValue2(inventory, "mActiveItem")
						local pos_x, pos_y = EntityGetTransform(entity_id)
						local wand = EZWand(active_wand)
						if wand ~= nil then
							wand:RemoveSpells("COPITH_UPGRADE_FIRE_RATE_WAIT")
							-- I have no clue what this bs scaling is I threw it together in desmso DM me on discord Human#6606 if you have a better func to use
							local castDelay_old = wand.castDelay
							wand.castDelay = ((wand.castDelay - 0.2) * 0.8) + 0.2
							local sprite_file = wand:GetSprite()
							if not sprite_file:match("data/items_gfx/wands/wand_0%d%d%d.png") == nil then
								wand:UpdateSprite()
							end
							GameScreenshake(50, pos_x, pos_y)
							local desc = table.concat({
								("%.2fs"):format(castDelay_old / 60),
								"->",
								("%.2fs"):format(wand.castDelay / 60),
								"cast delay."
							}, " ")
							GamePrintImportant("Wand upgraded!", desc)
						end
					else
						-- non-self cast alert
						GamePrintImportant("You cannot cheat the gods!", "")
					end
				end
			end
		end
	},
	{   -- Reload Time
		id                = "COPITH_UPGRADE_RELOAD_TIME",
		name              = "Upgrade - Reload Time (One-off)",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_upgrade_reload_time",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/upgrade_reload_time.png",
		type              = ACTION_TYPE_UTILITY,
		spawn_level       = "1,2,3,10",
		spawn_probability = "1,1,0.5,0.2",
		price             = 840,
		mana              = 0,
		recursive         = true,
		never_ac          = true,
		action = function(recursion_level, iteration)

			-- Check for initial reflection and greek letters/non-self casts
			if not reflecting and current_action.id == "COPITH_UPGRADE_RELOAD_TIME" then

				local this_wand = GunUtils.current_wand(GetUpdatedEntityID())
				local this_card = GunUtils.current_card(this_wand)
				local ability = EntityGetComponentIncludingDisabled(this_wand, "AbilityComponent")
				if ability then

					EntityKill(this_card)
				end
			else

				-- non-self cast alert
				GamePrintImportant("You cannot cheat the gods!", "")
			end



			-- Check for initial reflection
			if not reflecting then
				-- Check for greek letters/non-self casts
				if current_action.id == "COPITH_UPGRADE_RELOAD_TIME" then
					local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
					local entity_id = GetUpdatedEntityID()
					local inventory = EntityGetFirstComponent(entity_id, "Inventory2Component")
					if inventory ~= nil then
						local active_wand = ComponentGetValue2(inventory, "mActiveItem")
						local pos_x, pos_y = EntityGetTransform(entity_id)
						local wand = EZWand(active_wand)
						if wand ~= nil then
							wand:RemoveSpells("COPITH_UPGRADE_RELOAD_TIME")
							-- I have no clue what this bs scaling is I threw it together in desmso DM me on discord Human#6606 if you have a better func to use
							local rechargeTime_old = wand.rechargeTime
							wand.rechargeTime = ((wand.rechargeTime - 0.2) * 0.8) + 0.2
							local sprite_file = wand:GetSprite()
							if not sprite_file:match("data/items_gfx/wands/wand_0%d%d%d.png") == nil then
								wand:UpdateSprite()
							end
							GameScreenshake(50, pos_x, pos_y)
							local desc = table.concat({
								("%.2fs"):format(rechargeTime_old / 60),
								"->",
								("%.2fs"):format(wand.rechargeTime / 60),
								"recharge time."
							}, " ")
							GamePrintImportant("Wand upgraded!", desc)
						end
					else
						-- non-self cast alert
						GamePrintImportant("You cannot cheat the gods!", "")
					end
				end
			end
		end
	},
	{   -- Accuracy
		id                = "COPITH_UPGRADE_SPREAD_DEGREES",
		name              = "Upgrade - Accuracy (One-off)",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_upgrade_spread_degrees",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/upgrade_spread_degrees.png",
		type              = ACTION_TYPE_UTILITY,
		spawn_level       = "1,2,3,10",
		spawn_probability = "1,1,0.5,0.2",
		price             = 840,
		mana              = 0,
		recursive         = true,
		never_ac          = true,
		action = function(recursion_level, iteration)

			-- Check for initial reflection and greek letters/non-self casts
			if not reflecting and current_action.id == "COPITH_UPGRADE_SPREAD_DEGREES" then

				local this_wand = GunUtils.current_wand(GetUpdatedEntityID())
				local this_card = GunUtils.current_card(this_wand)
				local ability = EntityGetComponentIncludingDisabled(this_wand, "AbilityComponent")
				if ability then

					EntityKill(this_card)
				end
			else

				-- non-self cast alert
				GamePrintImportant("You cannot cheat the gods!", "")
			end



			-- Check for initial reflection
			if not reflecting then
				-- Check for greek letters/non-self casts
				if current_action.id == "COPITH_UPGRADE_SPREAD_DEGREES" then
					local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
					local entity_id = GetUpdatedEntityID()
					local inventory = EntityGetFirstComponent(entity_id, "Inventory2Component")
					if inventory ~= nil then
						local active_wand = ComponentGetValue2(inventory, "mActiveItem")
						local pos_x, pos_y = EntityGetTransform(entity_id)
						local wand = EZWand(active_wand)
						if wand ~= nil then
							wand:RemoveSpells("COPITH_UPGRADE_SPREAD_DEGREES")
							-- I have no clue what this bs scaling is I threw it together in desmso DM me on discord Human#6606 if you have a better func to use
							local rechargeTime_old = wand.rechargeTime
							wand.spread = wand.spread - ((math.abs(wand.spread) * 0.25) + 0.5)
							local sprite_file = wand:GetSprite()
							if not sprite_file:match("data/items_gfx/wands/wand_0%d%d%d.png") == nil then
								wand:UpdateSprite()
							end
							GameScreenshake(50, pos_x, pos_y)
							local desc = table.concat({
								tostring(rechargeTime_old),
								"->",
								tostring(wand.spread),
								"degrees spread."
							}, " ")
							GamePrintImportant("Wand upgraded!", desc)
						end
					else
						-- non-self cast alert
						GamePrintImportant("You cannot cheat the gods!", "")
					end
				end
			end
		end
	},
	{   -- Maximum mana
		id                = "COPITH_UPGRADE_MANA_MAX",
		name              = "Upgrade - Maximum mana (One-off)",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_upgrade_mana_max",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/upgrade_mana_max.png",
		type              = ACTION_TYPE_UTILITY,
		spawn_level       = "1,2,3,10",
		spawn_probability = "1,1,0.5,0.2",
		price             = 840,
		mana              = 0,
		recursive         = true,
		never_ac          = true,
		action = function(recursion_level, iteration)

			-- Check for initial reflection and greek letters/non-self casts
			if not reflecting and current_action.id == "COPITH_UPGRADE_MANA_MAX" then

				local this_wand = GunUtils.current_wand(GetUpdatedEntityID())
				local this_card = GunUtils.current_card(this_wand)
				local ability = EntityGetComponentIncludingDisabled(this_wand, "AbilityComponent")
				if ability then

					EntityKill(this_card)
				end
			else

				-- non-self cast alert
				GamePrintImportant("You cannot cheat the gods!", "")
			end



			-- Check for initial reflection
			if not reflecting then
				-- Check for greek letters/non-self casts
				if current_action.id == "COPITH_UPGRADE_MANA_MAX" then
					local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
					local entity_id = GetUpdatedEntityID()
					local inventory = EntityGetFirstComponent(entity_id, "Inventory2Component")
					if inventory ~= nil then
						local active_wand = ComponentGetValue2(inventory, "mActiveItem")
						local pos_x, pos_y = EntityGetTransform(entity_id)
						local wand = EZWand(active_wand)
						if wand ~= nil then
							wand:RemoveSpells("COPITH_UPGRADE_MANA_MAX")
							-- I have no clue what this bs scaling is I threw it together in desmso DM me on discord Human#6606 if you have a better func to use
							wand.manaMax = wand.manaMax * 1.2 + 50
							local sprite_file = wand:GetSprite()
							if not sprite_file:match("data/items_gfx/wands/wand_0%d%d%d.png") == nil then
								wand:UpdateSprite()
							end
							GameScreenshake(50, pos_x, pos_y)
							GamePrintImportant("Wand upgraded!", tostring(wand.manaMax) .. " mana capacity.")
						end
					else
						-- non-self cast alert
						GamePrintImportant("You cannot cheat the gods!", "")
					end
				end
			end
		end
	},
	{   -- Mana charge speed
		id                = "COPITH_UPGRADE_MANA_CHARGE_SPEED",
		name              = "Upgrade - Mana charge speed (One-off)",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_upgrade_mana_charge_speed",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/upgrade_mana_charge_speed.png",
		type              = ACTION_TYPE_UTILITY,
		spawn_level       = "1,2,3,10",
		spawn_probability = "1,1,0.5,0.2",
		price             = 840,
		mana              = 0,
		recursive         = true,
		never_ac          = true,
		action = function(recursion_level, iteration)

			-- Check for initial reflection and greek letters/non-self casts
			if not reflecting and current_action.id == "COPITH_UPGRADE_MANA_CHARGE_SPEED" then

				local this_wand = GunUtils.current_wand(GetUpdatedEntityID())
				local this_card = GunUtils.current_card(this_wand)
				local ability = EntityGetComponentIncludingDisabled(this_wand, "AbilityComponent")
				if ability then

					EntityKill(this_card)
				end
			else

				-- non-self cast alert
				GamePrintImportant("You cannot cheat the gods!", "")
			end



			-- Check for initial reflection
			if not reflecting then
				-- Check for greek letters/non-self casts
				if current_action.id == "COPITH_UPGRADE_MANA_CHARGE_SPEED" then
					local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
					local entity_id = GetUpdatedEntityID()
					local inventory = EntityGetFirstComponent(entity_id, "Inventory2Component")
					if inventory ~= nil then
						local active_wand = ComponentGetValue2(inventory, "mActiveItem")
						local pos_x, pos_y = EntityGetTransform(entity_id)
						local wand = EZWand(active_wand)
						if wand ~= nil then
							wand:RemoveSpells("COPITH_UPGRADE_MANA_CHARGE_SPEED")
							-- I have no clue what this bs scaling is I threw it together in desmso DM me on discord Human#6606 if you have a better func to use
							wand.manaChargeSpeed = wand.manaChargeSpeed * 1.2 + 50
							local sprite_file = wand:GetSprite()
							if not sprite_file:match("data/items_gfx/wands/wand_0%d%d%d.png") == nil then
								wand:UpdateSprite()
							end
							GameScreenshake(50, pos_x, pos_y)
							GamePrintImportant("Wand upgraded!", tostring(wand.manaChargeSpeed) .. " mana charge speed.")
						end
					else
						-- non-self cast alert
						GamePrintImportant("You cannot cheat the gods!", "")
					end
				end
			end
		end
	},
	{   -- Upgrade - Always Cast
		id                = "COPITH_UPGRADE_GUN_ACTIONS_PERMANENT",
		name              = "Upgrade - Always Cast (One-off)",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_upgrade_gun_actions_permanent",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/upgrade_gun_action_permanent_actions.png",
		type              = ACTION_TYPE_UTILITY,
		spawn_level       = "1,2,3,10",
		spawn_probability = "1,1,0.5,0.2",
		price             = 840,
		mana              = 0,
		recursive         = true,
		never_ac          = true,
		-- Maybe broken?
		action = function(recursion_level, iteration)

			-- Check for initial reflection and greek letters/non-self casts
			if not reflecting and current_action.id == "COPITH_UPGRADE_GUN_ACTIONS_PERMANENT" then

				local this_wand = GunUtils.current_wand(GetUpdatedEntityID())
				local this_card = GunUtils.current_card(this_wand)
				local ability = EntityGetComponentIncludingDisabled(this_wand, "AbilityComponent")
				if ability then

					EntityKill(this_card)
				end
			else

				-- non-self cast alert
				GamePrintImportant("You cannot cheat the gods!", "")
			end



			draw_actions(1, true) -- Check for initial reflection
			if not reflecting then
				-- Check for greek letters/non-self casts
				if current_action.id == "COPITH_UPGRADE_GUN_ACTIONS_PERMANENT" then
					local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
					local entity_id = GetUpdatedEntityID()
					local inventory = EntityGetFirstComponent(entity_id, "Inventory2Component")
					if inventory ~= nil then
						local active_wand = ComponentGetValue2(inventory, "mActiveItem")
						local pos_x, pos_y = EntityGetTransform(entity_id)
						local wand = EZWand(active_wand)
						if wand ~= nil then
							local spells, attached_spells = wand:GetSpells()
							if (#spells > 0 and spells[1].action_id ~= "COPITH_UPGRADE_GUN_ACTIONS_PERMANENT" and
								spells[1].action_id ~= "COPITH_UPGRADE_GUN_ACTIONS_PERMANENT_REMOVE")
							then
								local action_to_attach = spells[1]
								wand:RemoveSpells("COPITH_UPGRADE_GUN_ACTIONS_PERMANENT")
								wand:RemoveSpells(spells[1].action_id)
								wand:AttachSpells(spells[1].action_id)
								local function has_custom_sprite(ez_wand)
									local sprite_file = ez_wand:GetSprite()
									return sprite_file:match("data/items_gfx/wands/wand_0%d%d%d.png") == nil
								end
								if not has_custom_sprite(wand) then
									wand:UpdateSprite()
								end
								GameScreenshake(50, pos_x, pos_y)
								GamePrintImportant("Spell attached!")
							end
						end
					else
						-- non-self cast alert
						GamePrintImportant("You cannot cheat the gods!", "")
					end
				end
			end
		end
	},
	{   -- Remove Always Cast
		id                = "COPITH_UPGRADE_GUN_ACTIONS_PERMANENT_REMOVE",
		name              = "Upgrade - Remove Always Cast (One-off)",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_upgrade_gun_actions_permanent_remove",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/upgrade_gun_action_permanent_actions_remove.png",
		type              = ACTION_TYPE_UTILITY,
		spawn_level       = "1,2,3,10",
		spawn_probability = "1,1,0.5,0.2",
		price             = 840,
		mana              = 0,
		recursive         = true,
		never_ac          = true,
		-- Maybe broken?
		action = function(recursion_level, iteration)

			-- Check for initial reflection and greek letters/non-self casts
			if not reflecting and current_action.id == "COPITH_UPGRADE_GUN_ACTIONS_PERMANENT_REMOVE" then

				local this_wand = GunUtils.current_wand(GetUpdatedEntityID())
				local this_card = GunUtils.current_card(this_wand)
				local ability = EntityGetComponentIncludingDisabled(this_wand, "AbilityComponent")
				if ability then

					EntityKill(this_card)
				end
			else

				-- non-self cast alert
				GamePrintImportant("You cannot cheat the gods!", "")
			end



			draw_actions(1, true) -- Check for initial reflection
			if not reflecting then
				-- Check for greek letters/non-self casts
				if current_action.id == "COPITH_UPGRADE_GUN_ACTIONS_PERMANENT_REMOVE" then
					local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
					local entity_id = GetUpdatedEntityID()
					local inventory = EntityGetFirstComponent(entity_id, "Inventory2Component")
					if inventory ~= nil then
						local active_wand = ComponentGetValue2(inventory, "mActiveItem")
						local pos_x, pos_y = EntityGetTransform(entity_id)
						local wand = EZWand(active_wand)
						if wand ~= nil then
							local spells, attached_spells = wand:GetSpells()
							if (#attached_spells > 0 and attached_spells[1].action_id ~= "UPGRADE_GUN_ACTIONS_PERMANENT" and
								wand:GetFreeSlotsCount() > 0)
							then
								local action_to_attach = attached_spells[1]
								wand:RemoveSpells("COPITH_UPGRADE_GUN_ACTIONS_PERMANENT_REMOVE")
								wand:DetachSpells(attached_spells[1].action_id)
								wand:AddSpells(attached_spells[1].action_id)
								local function has_custom_sprite(ez_wand)
									local sprite_file = ez_wand:GetSprite()
									return sprite_file:match("data/items_gfx/wands/wand_0%d%d%d.png") == nil
								end
								if not has_custom_sprite(wand) then
									wand:UpdateSprite()
								end
								GameScreenshake(50, pos_x, pos_y)
								GamePrintImportant("Spell extracted!")
							end
						end
					else
						-- non-self cast alert
						GamePrintImportant("You cannot cheat the gods!", "")
					end
				end
			end
		end
	},]=]
	{
		id                  = "COPITH_DAMAGE_LIFETIME",
		name                = "$actionname_damage_lifetime",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_damage_lifetime",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/damage_lifetime.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
		type                = ACTION_TYPE_MODIFIER,
		spawn_level         = "1,2,4,5,10",
		spawn_probability   = "0.1,1,0.1,0.1,0.2",
		price               = 280,
		mana                = 30,
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 12
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/damage_lifetime.xml,"
			draw_actions(1, true)
		end
	},
	{
		id                = "COPITH_HITFX_CRITICAL_ELECTROCUTED",
		name              = "$actionname_hitfx_critical_electrocuted",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_hitfx_critical_electrocuted",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/crit_on_electrocuted.png",
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "1,3,4,5",
		spawn_probability = "0.2,0.2,0.2,0.2",
		inject_after      = {"HITFX_CRITICAL_BLOOD", "HITFX_CRITICAL_OIL", "HITFX_CRITICAL_WATER", "HITFX_BURNING_CRITICAL_HIT"},
		price             = 70,
		mana              = 10,
		--max_uses        = 50,
		action = function()
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/crit_on_electrocuted.xml,"
			draw_actions(1, true)
		end
	},
	{
		id                = "COPITH_HITFX_CRITICAL_FROZEN",
		name              = "$actionname_hitfx_critical_frozen",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_hitfx_critical_frozen",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/crit_on_frozen.png",
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "1,3,4,5",
		spawn_probability = "0.2,0.2,0.2,0.2",
		inject_after      = {"HITFX_CRITICAL_BLOOD", "HITFX_CRITICAL_OIL", "HITFX_CRITICAL_WATER", "HITFX_BURNING_CRITICAL_HIT"},
		price             = 70,
		mana              = 10,
		--max_uses        = 50,
		action = function()
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/crit_on_frozen.xml,"
			draw_actions(1, true)
		end
	},
	{
		id                = "COPITH_PASSIVE_MANA",
		name              = "$actionname_passive_mana",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_passive_mana",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/passive_mana.png",
		type              = ACTION_TYPE_PASSIVE,
		spawn_level       = "1,2,3,4,5,6",
		spawn_probability = "0.5,0.5,0.5,0.5,0.5,0.5",
		price             = 200,
		mana              = 0,
		custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/passive_mana.xml",
		action = function()
			draw_actions(1, true)
		end
	},
	{
		id                = "COPITH_FREEZING_VAPOUR_TRAIL",
		name              = "$actionname_freezing_vapour_trail",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_freezing_vapour_trail",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/freezing_vapour_trail.png",
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "0,1,2,3,4,5,6",
		spawn_probability = "0.5,0.5,0.5,0.5,0.5,0.5,0.5",
		inject_after      = {"ACID_TRAIL", "POISON_TRAIL", "OIL_TRAIL", "WATER_TRAIL", "GUNPOWDER_TRAIL", "FIRE_TRAIL"},
		price             = 300,
		mana              = 13,
		action = function()
			c.trail_material = c.trail_material .. "blood_cold"
			c.trail_material_amount = c.trail_material_amount + 5
			draw_actions(1, true)
		end
	},
	{
		id                = "COPITH_VOID_TRAIL",
		name              = "$actionname_void_trail",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_void_trail",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/void_trail.png",
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "0,1,2,3,4,5,6",
		spawn_probability = "0.5,0.5,0.5,0.5,0.5,0.5,0.5",
		inject_after      = {"ACID_TRAIL", "POISON_TRAIL", "OIL_TRAIL", "WATER_TRAIL", "GUNPOWDER_TRAIL", "FIRE_TRAIL"},
		price             = 200,
		mana              = 6,
		action = function()
			c.trail_material = c.trail_material .. "void_liquid,"
			c.trail_material_amount = c.trail_material_amount + 1
			draw_actions(1, true)
		end
	},
	{
		id                = "COPITH_DAMAGE_CRITICAL",
		name              = "$actionname_damage_critical",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_damage_critical",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/damage_critical.png",
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "0,1,2,3,4,5,6",
		spawn_probability = "0.7,0.7,0.7,0.7,0.7,0.7,0.7",
		price             = 300,
		mana              = 5,
		action = function()
			c.damage_critical_multiplier = math.max(1, c.damage_critical_multiplier) + 1
			if not reflecting then
				c.damage_critical_chance = math.max(c.damage_critical_chance, 5)
			end
			draw_actions(1, true)
		end
	},
	{
		id                = "COPITH_DIMIGE",
		name              = "$actionname_dimige",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_dimige",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/dimige.png",
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "0,1,2,3",
		spawn_probability = "1.0,1.0,1.0,1.0",
		price             = 70,
		mana              = 5,
		action = function()
			local projectile_type_sum = 0
			for k, v in ipairs(deck or {}) do
				if v.type == ACTION_TYPE_PROJECTILE or v.type == ACTION_TYPE_STATIC_PROJECTILE or
					v.type == ACTION_TYPE_MATERIAL
				then
					projectile_type_sum = projectile_type_sum + 1
				end
			end
			for k, v in ipairs(hand or {}) do
				if v.type == ACTION_TYPE_PROJECTILE or v.type == ACTION_TYPE_STATIC_PROJECTILE or
					v.type == ACTION_TYPE_MATERIAL
				then
					projectile_type_sum = projectile_type_sum + 1
				end
			end
			for k, v in ipairs(discarded or {}) do
				if v.type == ACTION_TYPE_PROJECTILE or v.type == ACTION_TYPE_STATIC_PROJECTILE or
					v.type == ACTION_TYPE_MATERIAL
				then
					projectile_type_sum = projectile_type_sum + 1
				end
			end
			c.damage_projectile_add = c.damage_projectile_add + 0.04 + 0.04 * projectile_type_sum
			draw_actions(1, true)
		end
	},
	{
		id                = "COPITH_POWER_SHOT",
		name              = "$actionname_power_shot",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_power_shot",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/power_shot.png",
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "0,1,2,3,4,5,6",
		spawn_probability = "0.7,0.7,0.7,0.7,0.7,0.7,0.7",
		price             = 300,
		mana              = 20,
		action = function()
			c.damage_projectile_add = c.damage_projectile_add + 0.24
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/power_shot.xml,"
			draw_actions(1, true)
		end
	},
	{
		id                = "COPITH_LOVELY_TRAIL",
		name              = "$actionname_lovely_trail",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_lovely_trail",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/lovely_trail.png",
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "0,1,2,3,4,5,6",
		spawn_probability = "0.2,0.2,0.2,0.2,0.2,0.2,0.2",
		price             = 10,
		mana              = 0,
		action = function()
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/particles/lovely_trail.xml,"
			draw_actions(1, true)
		end
	},
	{
		id                = "COPITH_STARRY_TRAIL",
		name              = "$actionname_starry_trail",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_starry_trail",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/starry_trail.png",
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "0,1,2,3,4,5,6",
		spawn_probability = "0.2,0.2,0.2,0.2,0.2,0.2,0.2",
		price             = 10,
		mana              = 0,
		action = function()
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/particles/starry_trail.xml,"
			draw_actions(1, true)
		end
	},
	{
		id                = "COPITH_SPARKLING_TRAIL",
		name              = "$actionname_sparkling_trail",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_sparkling_trail",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/sparkling_trail.png",
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "0,1,2,3,4,5,6",
		spawn_probability = "0.2,0.2,0.2,0.2,0.2,0.2,0.2",
		price             = 10,
		mana              = 0,
		action = function()
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/particles/sparkling_trail.xml,"
			draw_actions(1, true)
		end
	},
	{
		id                = "COPITH_NULL_TRAIL",
		name              = "$actionname_null_trail",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_null_trail",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/null_trail.png",
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "0,1,2,3,4,5,6",
		spawn_probability = "0.2,0.2,0.2,0.2,0.2,0.2,0.2",
		price             = 10,
		mana              = 0,
		action = function()
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/null_trail.xml,"
			draw_actions(1, true)
		end
	},
	{
		id                = "COPITH_ROOT_GROWER",
		name              = "$actionname_root_grower",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_root_grower",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/root_grower.png",
		type              = ACTION_TYPE_STATIC_PROJECTILE,
		spawn_level       = "0,1,2,3,4,5",
		spawn_probability = "0.5,0.5,0.5,0.5,0.5,0.5",
		price             = 90,
		mana              = 40,
		max_uses          = 10,
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 12
			add_projectile("mods/copis_things/files/entities/props/root_grower.xml")
		end
	},
	{
		id                = "COPITH_ALT_FIRE_FLAMETHROWER",
		name              = "$actionname_alt_fire_flamethrower",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_alt_fire_flamethrower",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/alt_fire_flamethrower.png",
		type              = ACTION_TYPE_PASSIVE,
		spawn_level       = "1,2,3,4,5",
		spawn_probability = "0.2,0.3,0.2,0.1,0.1",
		price             = 280,
		mana              = 20,
		skip_mana         = true,
		custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/alt_fire_flamethrower.xml",
		action = function()
			-- does nothing to the projectiles
			draw_actions(1, true)
		end
	},
	{
		id                  = "COPITH_DECOY",
		name                = "$action_decoy",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_decoy",
		sprite              = "data/ui_gfx/gun_actions/decoy.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/decoy_unidentified.png",
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "0,1,2,3,4,5",
		spawn_probability   = "0.1,0.3,0.2,0.2,0.1,0.1",
		price               = 130,
		mana                = 60,
		max_uses            = 10,
		custom_xml_file     = "data/entities/misc/custom_cards/decoy.xml",
		action = function()
			add_projectile("data/entities/projectiles/deck/decoy.xml")
			c.fire_rate_wait = c.fire_rate_wait + 40
		end
	},
	{
		id                  = "COPITH_DECOY_TRIGGER",
		name                = "$action_decoy_trigger",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_decoy_trigger",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/decoy_death_trigger.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/decoy_trigger_unidentified.png",
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "0,1,2,3,4,5",
		spawn_probability   = "0.1,0.3,0.2,0.2,0.1,0.1",
		price               = 150,
		mana                = 80,
		max_uses            = 10,
		custom_xml_file     = "data/entities/misc/custom_cards/decoy_trigger.xml",
		action = function()
			add_projectile_trigger_death("data/entities/projectiles/deck/decoy_trigger.xml", 1)
			c.fire_rate_wait = c.fire_rate_wait + 40
		end
	},--[[
	{
		id                     = "COPITH_HITFX_EXPLOSION_FROZEN",
		name                   = "Explosion on frozen enemies",
		author                 = "Copi",
		mod                    = "Copi's Things",
		description            = "Makes a projectile explode upon collision with frozen creatures",
		sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/explode_on_frozen.png",
		sprite_unidentified    = "data/ui_gfx/gun_actions/freeze_unidentified.png",
		related_extra_entities = { "mods/copis_things/files/entities/misc/hitfx_explode_frozen.xml" },
		type                   = ACTION_TYPE_MODIFIER,
		spawn_level            = "1,3,4,5",
		spawn_probability      = "0.2,0.2,0.2,0.2",
		inject_after           = {"HITFX_EXPLOSION_SLIME", "HITFX_EXPLOSION_SLIME_GIGA", "HITFX_EXPLOSION_ALCOHOL", "HITFX_EXPLOSION_ALCOHOL_GIGA"},
		price                  = 140,
		mana                   = 20,
		--max_uses             = 50,
		action = function()
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/hitfx_explode_frozen.xml,"
			draw_actions(1, true)
		end
	},
	{
		id                     = "COPITH_HITFX_EXPLOSION_FROZEN_GIGA",
		name                   = "Giant explosion on frozen enemies",
		author                 = "Copi",
		mod                    = "Copi's Things",
		description            = "Makes a projectile explode powerfully upon collision with frozen creatures",
		sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/explode_on_frozen_giga.png",
		sprite_unidentified    = "data/ui_gfx/gun_actions/freeze_unidentified.png",
		related_extra_entities = {
			"mods/copis_things/files/entities/misc/hitfx_explode_frozen_giga.xml",
			"data/entities/particles/tinyspark_orange.xml"
		},
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "1,3,4,5",
		spawn_probability = "0.1,0.1,0.1,0.1",
		price             = 300,
		mana              = 200,
		max_uses          = 20,
		action = function()
			c.extra_entities =
				c.extra_entities ..
				"mods/copis_things/files/entities/misc/hitfx_explode_frozen.xml,data/entities/particles/tinyspark_orange.xml,"
			draw_actions(1, true)
		end
	},]]
	{
		id                     = "COPITH_CIRCLE_EDIT_WANDS_EVERYWHERE",
		name                   = "$actionname_circle_edit_wands_everywhere",
		author                 = "Copi",
		mod                    = "Copi's Things",
		description            = "$actiondesc_circle_edit_wands_everywhere",
		sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/circle_edit_wands_everywhere.png",
		sprite_unidentified    = "data/ui_gfx/gun_actions/freeze_unidentified.png",
		related_extra_entities = { "mods/copis_things/files/entities/projectiles/circle_edit_wands_everywhere.xml" },
		type                   = ACTION_TYPE_STATIC_PROJECTILE,
		spawn_level            = "0,1,2,3",
		spawn_probability      = "1,1,1,1",
		inject_after           = {"BERSERK_FIELD", "POLYMORPH_FIELD", "CHAOS_POLYMORPH_FIELD", "ELECTROCUTION_FIELD", "FREEZE_FIELD", "REGENERATION_FIELD", "TELEPORTATION_FIELD", "LEVITATION_FIELD", "SHIELD_FIELD"},
		price                  = 200,
		mana                   = 50,
		max_uses               = 3,
		action = function()
			add_projectile("mods/copis_things/files/entities/projectiles/circle_edit_wands_everywhere.xml")
			draw_actions(1, true)
		end
	},
	{
		id                     = "COPITH_MINI_SHIELD",
		name                   = "$actionname_mini_shield",
		author                 = "Copi",
		mod                    = "Copi's Things",
		description            = "$actiondesc_mini_shield",
		sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/mini_shield.png",
		sprite_unidentified    = "data/ui_gfx/gun_actions/freeze_unidentified.png",
		related_extra_entities = { "mods/copis_things/files/entities/misc/mini_shield.xml" },
		type                   = ACTION_TYPE_MODIFIER,
		spawn_level            = "0,1,2,3,4,5,6",
		spawn_probability      = "1,1,1,1,1,1,1",
		inject_after           = {"ENERGY_SHIELD_SHOT"},
		price                  = 540,
		mana                   = 20,
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 6
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/mini_shield.xml,"
			draw_actions(1, true)
		end
	},
	{
		id                  = "COPITH_NGON_SHAPE",
		name                = "Formation - N-gon",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_ngon_shape",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/ngon_shape.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/freeze_unidentified.png",
		type                = ACTION_TYPE_DRAW_MANY,
		spawn_level         = "0,		1,2,3,4,5,6",
		spawn_probability   = "0.33,	0.33,0.33,0.33,0.33,0.33,0.33",
		inject_after        = {"I_SHAPE", "Y_SHAPE", "T_SHAPE", "W_SHAPE", "CIRCLE_SHAPE", "PENTAGRAM_SHAPE"},
		price               = 120,
		mana                = 24,
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 16
			c.pattern_degrees = 180
			draw_actions(#deck, true)
		end
	},
	{
		id                  = "COPITH_STORED_SHOT",
		name                = "$actionname_stored_shot",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_stored_shot",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/stored_shot.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/freeze_unidentified.png",
		type                = ACTION_TYPE_STATIC_PROJECTILE,
		spawn_level         = "0,1,2,3,4,5,6",
		spawn_probability   = "0.4,0.4,0.4,0.4,0.4,0.4,0.4",
		price               = 160,
		mana                = 4,
		action = function()
			current_reload_time = current_reload_time + 3
			if reflecting then
				return
			end
			add_projectile_trigger_death("mods/copis_things/files/entities/projectiles/stored_shot.xml", 1)
		end
	},
	{
		id                     = "COPITH_BARRIER_TRAIL",
		name                   = "$actionname_barrier_trail",
		author                 = "Copi",
		mod                    = "Copi's Things",
		description            = "$actiondesc_barrier_trail",
		sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/barrier_trail.png",
		sprite_unidentified    = "data/ui_gfx/gun_actions/freeze_unidentified.png",
		related_extra_entities = { "mods/copis_things/files/entities/misc/barrier_trail.xml" },
		type                   = ACTION_TYPE_MODIFIER,
		spawn_level            = "2,3,4,5",
		spawn_probability      = "0.7,0.7,0.7,0.7",
		price                  = 200,
		mana                   = 20,
		action = function()
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/barrier_trail.xml,"
			draw_actions(1, true)
		end
	},
	{
		id                  = "COPITH_DEATH_RAY",
		name                = "$actionname_death_ray",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_death_ray",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/death_ray.png",
		related_projectiles = { "mods/copis_things/files/entities/projectiles/death_ray.xml" },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "3,4",
		spawn_probability   = "1.00,0.50",
		price               = 220,
		mana                = 25,
		action = function()
			add_projectile("mods/copis_things/files/entities/projectiles/death_ray.xml")
		end
	},
	{
		id                  = "COPITH_LIGHT_BULLET_DEATH_TRIGGER",
		name                = "$actionname_light_bullet_death_trigger",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_light_bullet_death_trigger",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/light_bullet_death_trigger.png",
		related_projectiles = { "data/entities/projectiles/deck/light_bullet.xml" },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "0,1,2,3",
		spawn_probability   = "1,0.5,0.5,0.5",
		inject_after        = {"LIGHT_BULLET", "LIGHT_BULLET_TRIGGER", "LIGHT_BULLET_TRIGGER_2", "LIGHT_BULLET_TIMER"},
		price               = 140,
		mana                = 10,
		--max_uses          = 100,
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 3
			c.screenshake = c.screenshake + 0.5
			c.damage_critical_chance = c.damage_critical_chance + 5
			add_projectile_trigger_death("data/entities/projectiles/deck/light_bullet.xml", 1)
		end
	},
	{
		id                  = "COPITH_IF_ALT_FIRE",
		name                = "Requirement - Alt Fire",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_if_alt_fire",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/if_alt_fire.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
		spawn_requires_flag = "card_unlocked_maths",
		type                = ACTION_TYPE_OTHER,
		spawn_level         = "10",
		spawn_probability   = "1",
		inject_after        = {"IF_ENEMY", "IF_PROJECTILE", "IF_HP", "IF_HALF", "IF_END", "IF_ELSE"},
		price               = 100,
		mana                = 0,
		never_ac            = true,
		action = function(recursion_level, iteration)
			if reflecting then return end
			local endpoint = -1
			local elsepoint = -1
			local entity_id = GetUpdatedEntityID()
			local controlscomp = EntityGetFirstComponent(entity_id, "ControlsComponent")

			local doskip = false ---@diagnostic disable-next-line: param-type-mismatch
			if (ComponentGetValue2(controlscomp, "mButtonDownRightClick") ~= true) then
				doskip = true
			end

			if (#deck > 0) then
				for i, v in ipairs(deck) do
					if (v ~= nil) then
						if (string.sub(v.id, 1, 3) == "IF_") and (v.id ~= "IF_END") and (v.id ~= "IF_ELSE") then
							endpoint = -1
							break
						end

						if (v.id == "IF_ELSE") then
							endpoint = i
							elsepoint = i
						end

						if (v.id == "IF_END") then
							endpoint = i
							break
						end
					end
				end

				local envelope_min = 1
				local envelope_max = 1

				if doskip then
					if (elsepoint > 0) then
						envelope_max = elsepoint
					elseif (endpoint > 0) then
						envelope_max = endpoint
					end

					for i = envelope_min, envelope_max do
						local v = deck[envelope_min]

						if (v ~= nil) then
							table.insert(discarded, v)
							table.remove(deck, envelope_min)
						end
					end
				else
					if (elsepoint > 0) then
						envelope_min = elsepoint

						if (endpoint > 0) then
							envelope_max = endpoint
						else
							envelope_max = #deck
						end

						for i = envelope_min, envelope_max do
							local v = deck[envelope_min]

							if (v ~= nil) then
								table.insert(discarded, v)
								table.remove(deck, envelope_min)
							end
						end
					end
				end
			end

			draw_actions(1, true)
		end
	},
	{
		id                     = "COPITH_ZIPPING_ARC",
		name                   = "$actionname_zipping_arc",
		author                 = "Copi",
		mod                    = "Copi's Things",
		description            = "$actiondesc_zipping_arc",
		sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/zipping_arc.png",
		sprite_unidentified    = "data/ui_gfx/gun_actions/sinewave_unidentified.png",
		related_extra_entities = { "mods/copis_things/files/entities/misc/zipping_arc.xml" },
		type                   = ACTION_TYPE_MODIFIER,
		spawn_level            = "2,4,6",
		spawn_probability      = "0.3,0.5,0.4",
		price                  = 50,
		mana                   = 10,
		--max_uses             = 150,
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 10
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/zipping_arc.xml,"
			draw_actions(1, true)
		end
	},
	{
		id                  = "COPITH_SLOW_BULLET_TIMER_N",
		name                = "$actionname_slow_bullet_timer_n",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_slow_bullet_timer_n",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/slow_bullet_timer_n.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/slow_bullet_timer_unidentified.png",
		related_projectiles = { "data/entities/projectiles/deck/bullet_slow.xml" },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "1,2,3,4,5,6",
		spawn_probability   = "0.3,0.3,0.3,0.3,0.5,0.5",
		inject_after        = {"SLOW_BULLET", "SLOW_BULLET_TRIGGER", "SLOW_BULLET_TIMER"},
		price               = 200,
		mana                = 50,
		--max_uses          = 50,
		custom_xml_file     = "data/entities/misc/custom_cards/bullet_slow.xml",
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 6
			c.screenshake = c.screenshake + 2
			c.spread_degrees = c.spread_degrees + 3.6

			if reflecting then
				Reflection_RegisterProjectile("data/entities/projectiles/deck/bullet_slow.xml")
				return
			end

			local firerate = c.fire_rate_wait
			local n = 1

			BeginProjectile("data/entities/projectiles/deck/bullet_slow.xml")
			while (#deck > 0) do
				n = n + 1
				BeginTriggerTimer(firerate * n)
				c.speed_multiplier = math.max(c.speed_multiplier, 1)
				draw_shot(create_shot(1), true)
				EndTrigger()
			end
			EndProjectile()

			c.lifetime_add = c.lifetime_add + (n * firerate)

			shot_effects.recoil_knockback = shot_effects.recoil_knockback + 20.0
		end
	},
	{
		id                  = "COPITH_FALSE_SPELL",
		name                = "$actionname_false_spell",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_false_spell",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/false_spell.png",
		related_projectiles = { "mods/copis_things/files/entities/projectiles/false_spell.xml" },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "0,1",
		spawn_probability   = "0.1,0.1",
		price               = 90,
		mana                = 1,
		action = function()
			c.fire_rate_wait = c.fire_rate_wait - 6
			current_reload_time = current_reload_time - 3
			add_projectile("mods/copis_things/files/entities/projectiles/false_spell.xml")
		end
	},
	{
		id                = "COPITH_AUTO_FRAME",
		name              = "$actionname_auto_frame",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_auto_frame",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/auto_frame.png",
		type              = ACTION_TYPE_PASSIVE,
		spawn_level       = "3,4,5,6",
		spawn_probability = "0.1,0.1,0.1,0.1",
		price             = 160,
		mana              = 0,
		custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/auto_frame.xml",
		action = function()
			draw_actions(1, true)
		end
	},
	{
		id                  = "COPITH_ICICLE_LANCE",
		name                = "$actionname_icicle_lance",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_icicle_lance",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/icicle_lance.png",
		related_projectiles = { "mods/copis_things/files/entities/projectiles/icicle_lance.xml" },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "1,2,3,4,5,6",
		spawn_probability   = "1,1,1,1,1,1",
		price               = 175,
		mana                = 25,
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 12
			add_projectile("mods/copis_things/files/entities/projectiles/icicle_lance.xml")
		end
	},
	{
		id                     = "COPITH_STATIC_TO_EXPLOSION",
		name                   = "$actionname_static_to_explosion",
		author                 = "Copi",
		mod                    = "Copi's Things",
		description            = "$actiondesc_static_to_explosion",
		sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/static_to_explosion.png",
		sprite_unidentified    = "data/ui_gfx/gun_actions/explosive_projectile_unidentified.png",
		related_extra_entities = {
			"mods/copis_things/files/entities/misc/static_to_explosion.xml",
			"data/entities/particles/tinyspark_yellow.xml"
		},
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "2,3,4",
		spawn_probability = "0.3,0.3,0.3",
		inject_after      = {"WATER_TO_POISON", "BLOOD_TO_ACID", "LAVA_TO_BLOOD", "LIQUID_TO_EXPLOSION", "TOXIC_TO_ACID", "STATIC_TO_SAND"},
		price             = 140,
		mana              = 70,
		max_uses          = 8,
		action = function()
			c.extra_entities =
				c.extra_entities ..
				"mods/copis_things/files/entities/misc/static_to_explosion.xml,data/entities/particles/tinyspark_yellow.xml,"
			c.fire_rate_wait = c.fire_rate_wait + 60
			draw_actions(1, true)
		end
	},
	{
		id                     = "COPITH_LIQUID_TO_SOIL",
		name                   = "$actionname_liquid_to_soil",
		author                 = "Copi",
		mod                    = "Copi's Things",
		description            = "$actiondesc_liquid_to_soil",
		sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/liquid_to_soil.png",
		sprite_unidentified    = "data/ui_gfx/gun_actions/explosive_projectile_unidentified.png",
		related_extra_entities = {
			"mods/copis_things/files/entities/misc/liquid_to_soil.xml",
			"data/entities/particles/tinyspark_yellow.xml"
		},
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "2,3,4",
		spawn_probability = "0.3,0.3,0.3",
		inject_after      = {"WATER_TO_POISON", "BLOOD_TO_ACID", "LAVA_TO_BLOOD", "LIQUID_TO_EXPLOSION", "TOXIC_TO_ACID", "STATIC_TO_SAND"},
		price             = 140,
		mana              = 70,
		max_uses          = 8,
		action = function()
			c.extra_entities =
				c.extra_entities ..
				"mods/copis_things/files/entities/misc/liquid_to_soil.xml,data/entities/particles/tinyspark_yellow.xml,"
			c.fire_rate_wait = c.fire_rate_wait + 60
			draw_actions(1, true)
		end
	},
	{
		id                     = "COPITH_POWDER_TO_WATER",
		name                   = "$actionname_powder_to_water",
		author                 = "Copi",
		mod                    = "Copi's Things",
		description            = "$actiondesc_powder_to_water",
		sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/powder_to_water.png",
		sprite_unidentified    = "data/ui_gfx/gun_actions/explosive_projectile_unidentified.png",
		related_extra_entities = {
			"mods/copis_things/files/entities/misc/powder_to_water.xml",
			"data/entities/particles/tinyspark_yellow.xml"
		},
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "2,3,4",
		spawn_probability = "0.3,0.3,0.3",
		inject_after      = {"WATER_TO_POISON", "BLOOD_TO_ACID", "LAVA_TO_BLOOD", "LIQUID_TO_EXPLOSION", "TOXIC_TO_ACID", "STATIC_TO_SAND"},
		price             = 140,
		mana              = 70,
		max_uses          = 8,
		action = function()
			c.extra_entities =
				c.extra_entities ..
				"mods/copis_things/files/entities/misc/powder_to_water.xml,data/entities/particles/tinyspark_yellow.xml,"
			c.fire_rate_wait = c.fire_rate_wait + 60
			draw_actions(1, true)
		end
	},
	{
		id                     = "COPITH_POWDER_TO_STEEL",
		name                   = "$actionname_powder_to_steel",
		author                 = "Copi",
		mod                    = "Copi's Things",
		description            = "$actiondesc_powder_to_steel",
		sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/powder_to_steel.png",
		sprite_unidentified    = "data/ui_gfx/gun_actions/explosive_projectile_unidentified.png",
		related_extra_entities = {
			"mods/copis_things/files/entities/misc/powder_to_steel.xml",
			"data/entities/particles/tinyspark_yellow.xml"
		},
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "2,3,4",
		spawn_probability = "0.3,0.3,0.3",
		inject_after      = {"WATER_TO_POISON", "BLOOD_TO_ACID", "LAVA_TO_BLOOD", "LIQUID_TO_EXPLOSION", "TOXIC_TO_ACID", "STATIC_TO_SAND"},
		price             = 140,
		mana              = 70,
		max_uses          = 8,
		action = function()
			c.extra_entities =
				c.extra_entities ..
				"mods/copis_things/files/entities/misc/powder_to_steel.xml,data/entities/particles/tinyspark_yellow.xml,"
			c.fire_rate_wait = c.fire_rate_wait + 60
			draw_actions(1, true)
		end
	},
	{
		id                  = "COPITH_ZAP",
		name                = "$actionname_zap",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_zap",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/zap.png",
		related_projectiles = { "mods/copis_things/files/entities/projectiles/zap.xml" },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "1,3,4",
		spawn_probability   = "1,1,1",
		price               = 170,
		mana                = 8,
		custom_xml_file     = "mods/copis_things/files/entities/misc/custom_cards/zap.xml",
		action = function()
			c.fire_rate_wait = c.fire_rate_wait - 5
			current_reload_time = current_reload_time - 5

			if reflecting then
				Reflection_RegisterProjectile("mods/copis_things/files/entities/projectiles/zap.xml")
				return
			end

			local function zap(count)
				BeginProjectile("mods/copis_things/files/entities/projectiles/zap.xml")
					BeginTriggerDeath()
						for i = 1, count, 1 do
							BeginProjectile("mods/copis_things/files/entities/projectiles/zap.xml")
							EndProjectile()
						end
						register_action(c)
						SetProjectileConfigs()
					EndTrigger()
				EndProjectile()
			end

			if GameGetFrameNum() % 3 == 0 then
				BeginProjectile("mods/copis_things/files/entities/projectiles/zap.xml")
					BeginTriggerDeath()
						zap(2)
						zap(2)
						register_action(c)
						SetProjectileConfigs()
					EndTrigger()
				EndProjectile()
			elseif GameGetFrameNum() % 3 == 1 then
				BeginProjectile("mods/copis_things/files/entities/projectiles/zap.xml")
					BeginTriggerDeath()
						BeginProjectile("mods/copis_things/files/entities/projectiles/zap.xml")
						EndProjectile()
					zap(1)
						register_action(c)
						SetProjectileConfigs()
					EndTrigger()
				EndProjectile()
			else
				BeginProjectile("mods/copis_things/files/entities/projectiles/zap.xml")
					BeginTriggerDeath()
						zap(1)
					EndTrigger()
				EndProjectile()

				BeginProjectile("mods/copis_things/files/entities/projectiles/zap.xml")
					BeginTriggerDeath()
						zap(1)
					EndTrigger()
				EndProjectile()
			end
		end
	},
	{
		id                  = "COPITH_MATRA_MAGIC",
		name                = "$actionname_matra_magic",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_matra_magic",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/matra_magic.png",
		related_projectiles = { "mods/copis_things/files/entities/projectiles/matra_magic.xml" },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "3,4,5,6",
		spawn_probability   = "1,1,1,1",
		price               = 180,
		mana                = 52,
		action = function()
			add_projectile("mods/copis_things/files/entities/projectiles/matra_magic.xml")
			c.fire_rate_wait = c.fire_rate_wait + 33
			current_reload_time = current_reload_time + 33
		end
	},
	{
		id                  = "COPITH_VOMERE",
		name                = "$actionname_vomere",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_vomere",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/vomeremancy.png",
		related_projectiles = { "mods/copis_things/files/entities/projectiles/vomere.xml" },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "3,4,5,6",
		spawn_probability   = "1,1,1,1",
		price               = 180,
		mana                = 52,
		max_uses            = 30,
		custom_uses_logic   = true,
		ai_never_uses       = true,
		action = function()
			if reflecting then
				return
			end
			local valid1 = false
			local valid2 = false
			local spell_comp
			local uses_left
			local stomach
			local entity_id = GetUpdatedEntityID()

				IngestionComps = EntityGetComponent(entity_id, "IngestionComponent") or {}

				for _, value in pairs(IngestionComps) do
					stomach = value
					local fullness = ComponentGetValue2(value, "ingestion_size")
					if fullness >= 500 then
						valid1 = true
					else
						valid1 = false
						GamePrint("Not enough satiety!")
						return
					end

					local inventory_2_comp = EntityGetFirstComponentIncludingDisabled(entity_id, "Inventory2Component")
					if inventory_2_comp == nil then
						return
					end
					local wand_id = ComponentGetValue2(inventory_2_comp, "mActiveItem")
					for i, spell in ipairs(EntityGetAllChildren(wand_id) or {}) do
						spell_comp = EntityGetFirstComponentIncludingDisabled(spell, "ItemComponent")
						if spell_comp ~= nil and
							ComponentGetValue2(spell_comp, "mItemUid") == current_action.inventoryitem_id
						then
							uses_left = ComponentGetValue2(spell_comp, "uses_remaining")
							if uses_left ~= 0 then
								valid2 = true
							else
								valid2 = false
								GamePrint("Not enough charges!")
								return
							end
							break
						end
					end

					if valid1 == true and valid2 == true then
						ComponentSetValue2(stomach, "ingestion_size", fullness - 500) ---@diagnostic disable-next-line: param-type-mismatch
						ComponentSetValue2(spell_comp, "uses_remaining", uses_left - 1)
						add_projectile("mods/copis_things/files/entities/projectiles/vomere.xml")
						c.fire_rate_wait = c.fire_rate_wait + 15
						current_reload_time = current_reload_time + 33
					end
				end
		end
	},
	{
		id                  = "COPITH_CIRCLE_RANDOM",
		name                = "$actionname_circle_random",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_circle_random",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/circle_random.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/cloud_water_unidentified.png",
		related_projectiles = { "mods/copis_things/files/entities/projectiles/circle_random.xml" },
		type                = ACTION_TYPE_MATERIAL,
		spawn_level         = "1,2,3,4",                                                            -- CIRCLE_FIRE
		spawn_probability   = "0.4,0.4,0.4,0.4",                                                    -- CIRCLE_FIRE
		inject_after        = {"CIRCLE_FIRE", "CIRCLE_ACID", "CIRCLE_OIL", "CIRCLE_WATER"},
		price               = 170,
		mana                = 20,
		max_uses            = 15,
		action = function()
			add_projectile("mods/copis_things/files/entities/projectiles/circle_random.xml")
			c.fire_rate_wait = c.fire_rate_wait + 20
		end
	},
	{
		id                  = "COPITH_CLOUD_RANDOM",
		name                = "$actionname_cloud_random",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_cloud_random",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/cloud_random.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/cloud_water_unidentified.png",
		related_projectiles = { "mods/copis_things/files/entities/projectiles/cloud_random.xml" },
		type                = ACTION_TYPE_STATIC_PROJECTILE,
		spawn_level         = "0,1,2,3,4,5",                                                              -- CLOUD_WATER
		spawn_probability   = "0.3,0.3,0.3,0.3,0.3,0.3",                                                  -- CLOUD_WATER
		inject_after        = {"CLOUD_WATER", "CLOUD_OIL", "CLOUD_BLOOD", "CLOUD_ACID", "CLOUD_THUNDER"},
		price               = 140,
		mana                = 30,
		max_uses            = 10,
		action = function()
			add_projectile("mods/copis_things/files/entities/projectiles/cloud_random.xml")
			c.fire_rate_wait = c.fire_rate_wait + 15
		end
	},
	{
		id                  = "COPITH_TOUCH_RANDOM",
		name                = "$actionname_touch_random",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_touch_random",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/touch_random.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/cloud_water_unidentified.png",
		related_projectiles = { "mods/copis_things/files/entities/projectiles/touch_random.xml" },
		type                = ACTION_TYPE_MATERIAL,
		spawn_level         = "1,2,3,4,5,6,7,10",                                                                        -- TOUCH_WATER
		spawn_probability   = "0,0,0,0,0.1,0.1,0.1,0.1",                                                                 -- TOUCH_WATER
		inject_after        = {"TOUCH_GOLD", "TOUCH_WATER", "TOUCH_OIL", "TOUCH_ALCOHOL", "TOUCH_BLOOD", "TOUCH_SMOKE"},
		price               = 420,
		mana                = 280,
		max_uses            = 5,
		action = function()
			add_projectile("mods/copis_things/files/entities/projectiles/touch_random.xml")
		end
	},
	{
		id                  = "COPITH_CHUNK_OF_RANDOM",
		name                = "$actionname_chunk_of_random",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_chunk_of_random",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/chunk_of_random.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/cloud_water_unidentified.png",
		related_projectiles = { "mods/copis_things/files/entities/projectiles/chunk_of_random.xml" },
		type                = ACTION_TYPE_MATERIAL,
		spawn_level         = "1,2,3,5",
		spawn_probability   = "0.4,0.4,0.4,0.4",
		inject_after        = {"SOILBALL"},
		price               = 50,
		mana                = 50,
		action = function()
			add_projectile("mods/copis_things/files/entities/projectiles/chunk_of_random.xml")
		end
	},
	{
		id                  = "COPITH_MATERIAL_RANDOM",
		name                = "$actionname_material_random",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_material_random",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/material_random.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/cloud_water_unidentified.png",
		related_projectiles = { "mods/copis_things/files/entities/projectiles/material_random.xml" },
		type                = ACTION_TYPE_MATERIAL,
		spawn_level         = "1,2,3,4,5",                                                            -- MATERIAL_WATER
		spawn_probability   = "0.4,0.4,0.4,0.4,0.4",                                                  -- MATERIAL_WATER
		inject_after        = {"MATERIAL_OIL", "MATERIAL_BLOOD", "MATERIAL_ACID", "MATERIAL_CEMENT"},
		price               = 110,
		mana                = 0,
		sound_loop_tag      = "sound_spray",
		action = function()
			add_projectile("mods/copis_things/files/entities/projectiles/material_random.xml")
			c.fire_rate_wait = c.fire_rate_wait - 15
			current_reload_time = current_reload_time - ACTION_DRAW_RELOAD_TIME_INCREASE -
				10 -- this is a hack to get the cement reload time back to 0
		end
	},
	{
		id                  = "COPITH_SEA_RANDOM",
		name                = "$actionname_sea_random",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_sea_random",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/sea_random.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/cloud_water_unidentified.png",
		related_projectiles = { "mods/copis_things/files/entities/projectiles/sea_random.xml" },
		type                = ACTION_TYPE_MATERIAL,
		spawn_level         = "0,4,5,6",                                                                       -- SEA_LAVA
		spawn_probability   = "0.2,0.2,0.2,0.2",                                                               -- SEA_LAVA
		inject_after        = {"SEA_LAVA", "SEA_ALCOHOL", "SEA_OIL", "SEA_WATER", "SEA_ACID", "SEA_ACID_GAS"},
		price               = 350,
		mana                = 140,
		max_uses            = 3,
		action = function()
			add_projectile("mods/copis_things/files/entities/projectiles/sea_random.xml")
			c.fire_rate_wait = c.fire_rate_wait + 15
		end
	},
	{
		id                  = "COPITH_SUMMON_ANVIL",
		name                = "$actionname_summon_anvil",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_summon_anvil",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/summon_anvil.png",
		related_projectiles = { "mods/copis_things/files/entities/projectiles/anvil.xml" },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "0,1,2,3,4,5,6",                                                       -- SUMMON_ROCK
		spawn_probability   = "0.1,0.1,0.2,0.3,0.1,0.1,0.1",                                         -- SUMMON_ROCK
		inject_after        = {"SUMMON_ROCK"},
		price               = 227,
		mana                = 143,
		max_uses            = 3,
		custom_xml_file     = "mods/copis_things/files/entities/misc/custom_cards/summon_anvil.xml",
		action = function()
			add_projectile("mods/copis_things/files/entities/projectiles/anvil.xml")
		end
	},
	{
		id                  = "COPITH_ARCANE_TURRET",
		name                = "$actionname_arcane_turret",
		description         = "$actiondesc_arcane_turret",
		author              = "Disco Witch",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/spell_turret.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/light_bullet_unidentified.png",
		related_projectiles = { "mods/copis_things/files/entities/projectiles/spell_turret.xml" },
		type                = ACTION_TYPE_STATIC_PROJECTILE,
		spawn_level         = "0,1,2,3,4,5,6,10",
		spawn_probability   = "0,0,0,0.1,0.1,0.1,0.2,0.3",
		price               = 500,
		mana                = 300,
		ai_never_uses       = true,
		max_uses            = -1,
		action = function()
			add_projectile("mods/copis_things/files/entities/projectiles/spell_turret.xml")
			c.fire_rate_wait = c.fire_rate_wait + 60
			if reflecting then
				return
			end

			local shooter = Entity.Current() -- Returns the entity shooting the wand
			---@diagnostic disable-next-line: undefined-field
			local wand = Entity(shooter.Inventory2Component.mActiveItem)
			if not wand then
				return
			end

			local storage = Entity(EntityCreateNew("turret_storage")) -- Create a storage entity to pass our spell info to the turret
			local cards = GetSpells(wand)
			local store_deck = ""
			local store_inventory_item_id = "COPITH_" -- The inventory_item_id is used to synchronize spell uses
			for k, v in ipairs(deck) do -- Generate ordered lists of cards to populate the turret wand
				store_deck = store_deck .. tostring(cards[v.deck_index + 1]:id()) .. ","
				store_inventory_item_id = store_inventory_item_id .. tostring(v.inventoryitem_id) .. ","
			end
			storage.variables.wand = tostring(wand:id()) -- Store relevant data in the storage entity for the turret to retrieve on spawn
			storage.variables.deck = store_deck
			storage.variables.inventoryitem_id = store_inventory_item_id
			for i, action in ipairs(deck) do
				table.insert(discarded, action)
			end -- Dump the rest of the deck into discard because they're consumed by the turret
			deck = {}
		end
	},
	{
		id                  = "COPITH_RECURSIVE_LARPA",
		name                = "$actionname_recursive_larpa",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_recursive_larpa",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/recursive_larpa.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/light_bullet_unidentified.png",
		related_projectiles = {},
		type                = ACTION_TYPE_MODIFIER,
		spawn_level         = "6, 10",
		spawn_probability   = "0.1, 0.2",
		inject_after        = {"LARPA_CHAOS", "LARPA_DOWNWARDS", "LARPA_UPWARDS", "LARPA_CHAOS_2", "LARPA_DEATH"},
		price               = 300,
		mana                = 150,
		ai_never_uses       = true,
		max_uses            = -1,
		action = function()
			if reflecting then
				return
			end
			c.fire_rate_wait = c.fire_rate_wait + 60
			BeginProjectile("mods/copis_things/files/entities/projectiles/recursive_larpa_host.xml")
			BeginTriggerHitWorld()
			local shot = create_shot(1)
			shot.state.extra_entities =
				shot.state.extra_entities .. "mods/copis_things/files/entities/misc/recursive_larpa.xml,"
			draw_shot(shot, true)
			EndTrigger()
			EndProjectile()
		end
	},
	{
		id                  = "COPITH_LARPA_FIELD",
		name                = "$actionname_larpa_field",
		description         = "$actiondesc_larpa_field",
		author              = "Disco Witch",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/larpa_lens.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/light_bullet_unidentified.png",
		related_projectiles = { "mods/copis_things/files/entities/projectiles/larpa_lens.xml" },
		type                = ACTION_TYPE_STATIC_PROJECTILE,
		spawn_level         = "0,1,2,3,4,5,6,10",
		spawn_probability   = "0,0,0,0.1,0.1,0.1,0.2,0.3",
		inject_after        = {"PROJECTILE_TRANSMUTATION_FIELD", "PROJECTILE_THUNDER_FIELD", "PROJECTILE_GRAVITY_FIELD"},
		price               = 300,
		mana                = 50,
		max_uses            = 12,
		action = function()
			add_projectile("mods/copis_things/files/entities/projectiles/larpa_lens.xml")
			c.fire_rate_wait = c.fire_rate_wait + 15
		end
	},
	{
		id                  = "COPITH_SHIELD_SAPPER",
		name                = "$actionname_shield_sapper",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "Slowly sap nearby energy shields (including your own)",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/shield_sapper.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/light_bullet_unidentified.png",
		related_projectiles = {},
		type                = ACTION_TYPE_PASSIVE,
		spawn_level         = "1,2,3,4,5,6",
		spawn_probability   = "0.05,0.6,0.6,0.6,0.6,0.6",
		inject_after        = {"ENERGY_SHIELD", "ENERGY_SHIELD_SECTOR"},
		price               = 220,
		mana                = 0,
		custom_xml_file     = "mods/copis_things/files/entities/misc/custom_cards/shield_sapper.xml",
		action = function()
			draw_actions(1, true)
		end
	},
	{
		id                  = "COPITH_PAPER_SHOT",
		name                = "$actionname_paper_shot",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_paper_shot",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/paper_shot.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/light_bullet_unidentified.png",
		related_projectiles = { "mods/copis_things/files/entities/misc/paper_shot.xml" },
		type                = ACTION_TYPE_MODIFIER,
		spawn_level         = "0,1,2,3,4",
		spawn_probability   = "0.5,0.4,0.3,0.2,0.1",
		price               = 20,
		mana                = 5,
		action = function()
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/paper_shot.xml,"
			c.damage_slice_add = c.damage_slice_add + 0.2
			draw_actions(1, true)
		end
	},
	{
		id                  = "COPITH_FEATHER_SHOT",
		name                = "$actionname_feather_shot",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_feather_shot",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/feather_shot.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/light_bullet_unidentified.png",
		related_projectiles = { "mods/copis_things/files/entities/misc/feather_shot.xml" },
		type                = ACTION_TYPE_MODIFIER,
		spawn_level         = "1,3,5",
		spawn_probability   = "0.3,0.3,0.3",
		price               = 100,
		mana                = 3,
		action = function()
			c.lifetime_add = c.lifetime_add + 21
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/feather_shot.xml,"
			current_reload_time = current_reload_time - 6
			draw_actions(1, true)
		end
	},
	{
		id                  = "COPITH_SCATTER_6",
		name                = "$actionname_scatter_6",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_scatter_6",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/scatter_6.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/scatter_2_unidentified.png",
		type                = ACTION_TYPE_DRAW_MANY,
		spawn_level         = "1,2,3,4,5,6",                                              -- SCATTER_4
		spawn_probability   = "0.4,0.4,0.5,0.6,0.6,0.6",                                  -- SCATTER_4
		inject_after        = {"SCATTER_2", "SCATTER_3", "SCATTER_4"},
		price               = 140,
		mana                = 2,
		--max_uses          = 100,
		action = function()
			draw_actions(6, true)
			c.spread_degrees = c.spread_degrees + 60.0
		end
	},
	{
		id                  = "COPITH_SCATTER_8",
		name                = "$actionname_scatter_8",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_scatter_8",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/scatter_8.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/scatter_2_unidentified.png",
		type                = ACTION_TYPE_DRAW_MANY,
		spawn_level         = "1,2,3,4,5,6",                                              -- SCATTER_4
		spawn_probability   = "0.2,0.2,0.3,0.4,0.4,0.4",                                  -- SCATTER_4
		inject_after        = {"SCATTER_2", "SCATTER_3", "SCATTER_4"},
		price               = 160,
		mana                = 4,
		--max_uses          = 100,
		action = function()
			draw_actions(8, true)
			c.spread_degrees = c.spread_degrees + 80.0
		end
	},
	{
		id                  = "COPITH_CLOUD_MAGIC_LIQUID_HP_REGENERATION",
		name                = "$actionname_cloud_magic_liquid_hp_regeneration",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_cloud_magic_liquid_hp_regeneration",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/cloud_magic_liquid_hp_regeneration.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/cloud_water_unidentified.png",
		related_projectiles = { "mods/copis_things/files/entities/projectiles/cloud_magic_liquid_hp_regeneration.xml" },
		type                = ACTION_TYPE_STATIC_PROJECTILE,
		spawn_level         = "0,1,2,3,4,5",                                                                             -- CLOUD_WATER
		spawn_probability   = "0.2,0.2,0.2,0.2,0.2,0.2",                                                                 -- CLOUD_WATER
		inject_after        = {"CLOUD_WATER", "CLOUD_OIL", "CLOUD_BLOOD", "CLOUD_ACID", "CLOUD_THUNDER"},
		price               = 300,
		mana                = 120,
		max_uses            = 3,
		never_unlimited     = true,
		action = function()
			add_projectile("mods/copis_things/files/entities/projectiles/cloud_magic_liquid_hp_regeneration.xml")
			c.fire_rate_wait = c.fire_rate_wait + 15
		end
	},
	{
		id                  = "COPITH_CHAOS_SPRITES",
		name                = "$actionname_chaos_sprites",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_chaos_sprites",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/chaos_sprites.png",
		related_projectiles = { "mods/copis_things/files/entities/projectiles/chaos_sprites.xml", 5 },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "3,4,5,6",
		spawn_probability   = "1,1,1,1",
		price               = 260,
		mana                = 42,
		max_uses            = -1,
		never_unlimited     = true,
		action = function()
			for i=1, 5 do
				add_projectile("mods/copis_things/files/entities/projectiles/chaos_sprites.xml")
			end
		end
	},
	{
		id                  = "COPITH_SHIELD_GHOST",
		name                = "$actionname_shield_ghost",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_shield_ghost",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/shield_ghost.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/torch_unidentified.png",
		type                = ACTION_TYPE_PASSIVE,
		spawn_level         = "1,2,3,4,5,6",
		spawn_probability   = "0.1,0.5,1,1,1,1",
		inject_after        = {"TINY_GHOST"},
		price               = 160,
		mana                = 0,
		custom_xml_file     = "mods/copis_things/files/entities/misc/custom_cards/shield_ghost.xml",
		action = function()
			draw_actions(1, true)
		end
	},
	{
		id                  = "COPITH_VACUUM_CLAW",
		name                = "$actionname_vacuum_claw",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_vacuum_claw",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/vacuum_claw.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/chainsaw_unidentified.png",
		related_projectiles = { "mods/copis_things/files/entities/projectiles/vacuum_claw.xml" },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "2,3,4,5",
		spawn_probability   = "0.5,1,1,0.5",
		price               = 120,
		mana                = 35,
		custom_xml_file     = "mods/copis_things/files/entities/misc/custom_cards/vacuum_claw.xml",
		action = function()
			current_reload_time = current_reload_time - 12
			c.fire_rate_wait = c.fire_rate_wait - 10
			if reflecting then
				return
			end
			add_projectile("mods/copis_things/files/entities/projectiles/vacuum_claw.xml")
		end
	},
	{
		id                  = "COPITH_CAUSTIC_CLAW",
		name                = "$actionname_caustic_claw",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_caustic_claw",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/caustic_claw.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/chainsaw_unidentified.png",
		related_projectiles = { "mods/copis_things/files/entities/projectiles/caustic_claw.xml" },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "1,2,3,4",
		spawn_probability   = "0.5,1,1,0.5",
		price               = 120,
		mana                = 50,
		action = function()
			current_reload_time = current_reload_time + 12
			c.fire_rate_wait = c.fire_rate_wait + 10
			if reflecting then
				return
			end
			add_projectile("mods/copis_things/files/entities/projectiles/caustic_claw.xml")
		end
	},
	{
		id                  = "COPITH_LUMINOUS_BLADE",
		name                = "$actionname_luminous_blade",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_luminous_blade",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/luminous_blade.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/chainsaw_unidentified.png",
		related_projectiles = { "mods/copis_things/files/entities/projectiles/luminous_blade.xml" },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "0,2,4,6",
		spawn_probability   = "0.1,0.2,0.6,0.3",
		price               = 150,
		mana                = 40,
		custom_xml_file     = "mods/copis_things/files/entities/misc/custom_cards/luminous_blade.xml",
		action = function()
			c.fire_rate_wait = c.fire_rate_wait - 20
			current_reload_time = current_reload_time - ACTION_DRAW_RELOAD_TIME_INCREASE -
				5 -- this is a hack to get the digger reload time back to 0
			if reflecting then
				return
			end
			add_projectile("mods/copis_things/files/entities/projectiles/luminous_blade.xml")
		end
	},
	{
		id                = "COPITH_INVERT",
		name              = "$actionname_invert",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_invert",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/invert.png",
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "2,3,4,5",
		spawn_probability = "0.2,0.3,0.4,0.3",
		inject_after      = {"SPEED"},
		price             = 75,
		mana              = 1,
		--max_uses        = 100,
		action = function()
			c.speed_multiplier = c.speed_multiplier * -1
			draw_actions(1, true)
		end
	},
	{
		id                  = "COPITH_TELEPORT_PROJECTILE_SHORT_TRIGGER_DEATH",
		name                = "$actionname_teleport_projectile_short_trigger_death",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_teleport_projectile_short_trigger_death",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/teleport_projectile_short_trigger_death.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/teleport_projectile_unidentified.png",
		related_projectiles = { "data/entities/projectiles/deck/teleport_projectile_short.xml" },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "0,1,2,4,5,6",                                                                                                                          -- TELEPORT_PROJECTILE
		spawn_probability   = "0.4,0.6,0.7,0.4,0.3,0.2",                                                                                                              -- TELEPORT_PROJECTILE
		inject_after        = {"TELEPORT_PROJECTILE", "TELEPORT_PROJECTILE_SHORT", "TELEPORT_PROJECTILE_STATIC", "SWAPPER_PROJECTILE", "TELEPORT_PROJECTILE_CLOSER"},
		price               = 150,
		mana                = 25,
		--max_uses          = 80,
		custom_xml_file     = "data/entities/misc/custom_cards/teleport_projectile_short.xml",
		action = function()
			add_projectile_trigger_death("data/entities/projectiles/deck/teleport_projectile_short.xml", 1)
			c.spread_degrees = c.spread_degrees - 2.0
		end
	},
	{
		id                     = "COPITH_DEATH_CROSS_TRAIL",
		name                   = "$actionname_death_cross_trail",
		author                 = "Copi",
		mod                    = "Copi's Things",
		description            = "$actiondesc_death_cross_trail",
		sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/death_cross_trail.png",
		sprite_unidentified    = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
		related_extra_entities = { "mods/copis_things/files/entities/misc/death_cross_trail.xml" },
		type                   = ACTION_TYPE_MODIFIER,
		spawn_level            = "2,4,5,6",
		spawn_probability      = "0.2,0.5,0.7,0.4",
		price                  = 300,
		mana                   = 90,
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 20
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/death_cross_trail.xml,"
			draw_actions(1, true)
		end
	},
	{
		id                     = "COPITH_GLITTERING_TRAIL",
		name                   = "$actionname_glittering_trail",
		author                 = "Copi",
		mod                    = "Copi's Things",
		description            = "$actiondesc_glittering_trail",
		sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/glittering_trail.png",
		sprite_unidentified    = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
		related_extra_entities = { "mods/copis_things/files/entities/misc/glittering_trail.xml" },
		type                   = ACTION_TYPE_MODIFIER,
		spawn_level            = "2,3,4,5,6",
		spawn_probability      = "0.7,0.7,0.5,0.4,0.2",
		price                  = 120,
		mana                   = 10,
		action = function()
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/glittering_trail.xml,"
			draw_actions(1, true)
		end
	},
	{
		id                     = "COPITH_SILVER_BULLET_RAY",
		name                   = "$actionname_silver_bullet_ray",
		author                 = "Copi",
		mod                    = "Copi's Things",
		description            = "$actiondesc_silver_bullet_ray",
		sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/silver_bullet_ray.png",
		related_extra_entities = { "mods/copis_things/files/entities/misc/silver_bullet_ray.xml" },
		type                   = ACTION_TYPE_MODIFIER,
		spawn_level            = "3,4,5",
		spawn_probability      = "0.5,0.7,0.5",
		inject_after           = {"FIREBALL_RAY", "LIGHTNING_RAY", "TENTACLE_RAY", "LASER_EMITTER_RAY"},
		price                  = 300,
		mana                   = 130,
		--max_uses             = 20,
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 30
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/silver_bullet_ray.xml,"
			draw_actions(1, true)
		end
	},
	{
		id                     = "COPITH_SILVER_BULLET_RAY_6",
		name                   = "$actionname_silver_bullet_ray_6",
		author                 = "Copi",
		mod                    = "Copi's Things",
		description            = "$actiondesc_silver_bullet_ray_6",
		sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/silver_bullet_ray_6.png",
		related_extra_entities = { "mods/copis_things/files/entities/misc/silver_bullet_ray.xml" },
		type                   = ACTION_TYPE_MODIFIER,
		spawn_level            = "3,4,5",
		spawn_probability      = "0.5,0.7,0.5",
		inject_after           = {"FIREBALL_RAY_LINE"},
		price                  = 300,
		mana                   = 100,
		--max_uses             = 20,
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 40
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/silver_bullet_ray_6.xml,"
			draw_actions(1, true)
		end
	},
	{
		id                     = "COPITH_SILVER_BULLET_ON_DEATH",
		name                   = "$actionname_silver_bullet_on_death",
		author                 = "Copi",
		mod                    = "Copi's Things",
		description            = "$actiondesc_silver_bullet_on_death",
		sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/silver_bullet_on_death.png",
		related_extra_entities = { "mods/copis_things/files/entities/misc/silver_bullet_on_death.xml" },
		type                   = ACTION_TYPE_MODIFIER,
		spawn_level            = "3,4,5",
		spawn_probability      = "0.5,0.7,0.5",
		inject_after           = {"FIREBALL_RAY_LINE"},
		price                  = 300,
		mana                   = 120,
		--max_uses             = 20,
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 15
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/silver_bullet_on_death.xml,"
			draw_actions(1, true)
		end
	},
	{
		id                     = "COPITH_SILVER_BULLET_RAY_ENEMY",
		name                   = "$actionname_silver_bullet_ray_enemy",
		author                 = "Copi",
		mod                    = "Copi's Things",
		description            = "$actiondesc_silver_bullet_ray_enemy",
		sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/silver_bullet_ray_enemy.png",
		related_extra_entities = { "mods/copis_things/files/entities/misc/hitfx_silver_bullet_ray_enemy.xml" },
		type                   = ACTION_TYPE_MODIFIER,
		spawn_level            = "3,4,5",
		spawn_probability      = "0.5,0.7,0.5",
		inject_after           = {"FIREBALL_RAY_ENEMY", "LIGHTNING_RAY_ENEMY", "TENTACLE_RAY_ENEMY"},
		price                  = 200,
		mana                   = 40,
		--max_uses             = 20,
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 30
			c.extra_entities =
				c.extra_entities .. "mods/copis_things/files/entities/misc/hitfx_silver_bullet_ray_enemy.xml,"
			draw_actions(1, true)
		end
	},
	{
		id                  = "COPITH_ICE_ORB",
		name                = "$actionname_ice_orb",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_ice_orb",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/ice_orb.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/chainsaw_unidentified.png",
		related_projectiles = { "mods/copis_things/files/entities/projectiles/ice_orb.xml" },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "2,3,4,5",                                                      -- SLOW_BULLET
		spawn_probability   = "1,1,1,1",                                                      -- SLOW_BULLET
		price               = 160,
		mana                = 30,
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 12
			current_reload_time = current_reload_time + 5

			if reflecting then
				Reflection_RegisterProjectile("mods/copis_things/files/entities/projectiles/ice_orb.xml")
				return
			end

			BeginProjectile("mods/copis_things/files/entities/projectiles/ice_orb.xml")
			BeginTriggerDeath()
			for i=1, 3 do
				BeginProjectile("mods/copis_things/files/entities/projectiles/ice_orb_fragment.xml")
				EndProjectile()
			end
			register_action(c)
			SetProjectileConfigs()
			EndTrigger()
			EndProjectile()
		end
	},
	{
		id                  = "COPITH_CHARM_FIELD",
		name                = "$actionname_charm_field",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_charm_field",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/charm_field.png",
		related_projectiles = { "data/entities/projectiles/deck/charm_field.xml" },
		type                = ACTION_TYPE_STATIC_PROJECTILE,
		spawn_level         = "0,1,2,3,4,5",                                                                                                                                                                         -- TELEPORTATION_FIELD
		spawn_probability   = "0.3,0.6,0.3,0.3,0.6,0.3",                                                                                                                                                             -- TELEPORTATION_FIELD
		inject_after        = {"BERSERK_FIELD", "POLYMORPH_FIELD", "CHAOS_POLYMORPH_FIELD", "ELECTROCUTION_FIELD", "FREEZE_FIELD", "REGENERATION_FIELD", "TELEPORTATION_FIELD", "LEVITATION_FIELD", "SHIELD_FIELD"},
		price               = 150,
		mana                = 30,
		max_uses            = 15,
		action = function()
			add_projectile("data/entities/projectiles/deck/charm_field.xml")
			c.fire_rate_wait = c.fire_rate_wait + 15
		end
	},
	{
		id                  = "COPITH_MANA_RANDOM",
		name                = "$actionname_mana_random",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_mana_random",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/mana_random.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
		type                = ACTION_TYPE_MODIFIER,
		spawn_level         = "1,2,3,4,5,6",
		spawn_probability   = "0.8,0.8,0.8,0.8,0.8,0.8",
		inject_after        = {"MANA_REDUCE"},
		price               = 300,
		mana                = 0,
		--max_uses          = 150,
		custom_xml_file     = "data/entities/misc/custom_cards/mana_reduce.xml",
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 5
			if reflecting then
				return
			end
			SetRandomSeed(GameGetFrameNum() + 978, GameGetFrameNum() + 663)
			local new_mana = mana + Random( -20, 60)

			if new_mana > mana then
				--
			else
				mana = mana - new_mana
			end
			mana = math.max(0, new_mana)

			draw_actions(1, true)
		end
	},
	{
		id                  = "COPITH_HITFX_WET_2X_DAMAGE_FREEZE",
		name                = "$actionname_hitfx_wet_2x_damage_freeze",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_hitfx_wet_2x_damage_freeze",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/hitfx_wet_2x_damage_freeze.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/freeze_unidentified.png",
		type                = ACTION_TYPE_MODIFIER,
		spawn_level         = "2,3,4,5",
		spawn_probability   = "0.6,0.8,0.6,0.6",
		price               = 160,
		mana                = 15,
		action = function()
			copi_state.bit = bit.bor(copi_state.bit, 64)
			c.fire_rate_wait = c.fire_rate_wait + 12
			draw_actions(1, true)
		end
	},
	{
		id                  = "COPITH_HITFX_BLOODY_2X_DAMAGE_POISONED",
		name                = "$actionname_hitfx_bloody_2x_damage_poisoned",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_hitfx_bloody_2x_damage_poisoned",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/hitfx_bloody_2x_damage_poisoned.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/freeze_unidentified.png",
		type                = ACTION_TYPE_MODIFIER,
		spawn_level         = "2,3,4,5",
		spawn_probability   = "0.6,0.8,0.6,0.6",
		price               = 160,
		mana                = 15,
		action = function()
			copi_state.bit = bit.bor(copi_state.bit, 128)
			c.fire_rate_wait = c.fire_rate_wait + 12
			draw_actions(1, true)
		end
	},
	{
		id                  = "COPITH_HITFX_OILED_2X_DAMAGE_BURN",
		name                = "$actionname_hitfx_oiled_2x_damage_burn",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_hitfx_oiled_2x_damage_burn",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/hitfx_oiled_2x_damage_burn.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/burn_trail_unidentified.png",
		type                = ACTION_TYPE_MODIFIER,
		spawn_level         = "2,3,4,5",
		spawn_probability   = "0.6,0.8,0.6,0.6",
		price               = 160,
		mana                = 15,
		action = function()
			copi_state.bit = bit.bor(copi_state.bit, 256)
			c.fire_rate_wait = c.fire_rate_wait + 12
			draw_actions(1, true)
		end
	},
	{
		id                = "COPITH_BLINDNESS",
		name              = "$actionname_blindness",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_blindness",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/blindness.png",
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "3,5,6",
		spawn_probability = "0.4,0.6,0.3",
		price             = 100,
		mana              = 100,
		max_uses          = 50,
		custom_xml_file   = "data/entities/misc/custom_cards/blindness.xml",
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 12
			c.game_effect_entities =
				c.game_effect_entities ..
				"mods/copis_things/files/entities/misc/status_entities/effect_better_blindness.xml,"
			c.extra_entities = c.extra_entities .. "data/entities/particles/blindness.xml,"
			c.friendly_fire = true
			draw_actions(1, true)
		end
	},
	{
		id                = "COPITH_MATERIAL_LAVA",
		name              = "$action_material_lava",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_material_lava",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/material_lava.png",
		type              = ACTION_TYPE_MATERIAL,
		spawn_level       = "1,2,3,4,5",                                                            -- MATERIAL_WATER
		spawn_probability = "0.4,0.4,0.4,0.4,0.4",                                                  -- MATERIAL_WATER
		inject_after      = {"MATERIAL_OIL", "MATERIAL_BLOOD", "MATERIAL_ACID", "MATERIAL_CEMENT"},
		price             = 110,
		mana              = 0,
		sound_loop_tag    = "sound_spray",
		action = function()
			add_projectile("data/entities/projectiles/deck/material_lava.xml")
			c.game_effect_entities = c.game_effect_entities .. "data/entities/misc/effect_apply_on_fire.xml,"
			c.fire_rate_wait = c.fire_rate_wait - 15
			current_reload_time = current_reload_time - ACTION_DRAW_RELOAD_TIME_INCREASE -
				10 -- this is a hack to get the cement reload time back to 0
		end
	},
	{
		id                = "COPITH_MATERIAL_MAGIC_LIQUID_POLYMORPH",
		name              = "$actionname_material_magic_liquid_polymorph",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_material_magic_liquid_polymorph",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/material_magic_liquid_polymorph.png",
		type              = ACTION_TYPE_MATERIAL,
		spawn_level       = "1,2,3,4,5",                                                                      -- MATERIAL_WATER
		spawn_probability = "0.4,0.4,0.4,0.4,0.4",                                                            -- MATERIAL_WATER
		inject_after      = {"MATERIAL_OIL", "MATERIAL_BLOOD", "MATERIAL_ACID", "MATERIAL_CEMENT"},
		price             = 110,
		mana              = 0,
		sound_loop_tag    = "sound_spray",
		action = function()
			add_projectile("mods/copis_things/files/entities/projectiles/material_magic_liquid_polymorph.xml")
			c.game_effect_entities = c.game_effect_entities .. "data/entities/misc/effect_polymorph.xml,"
			c.fire_rate_wait = c.fire_rate_wait - 15
			current_reload_time = current_reload_time - ACTION_DRAW_RELOAD_TIME_INCREASE -
				10 -- this is a hack to get the cement reload time back to 0
		end
	},
	{
		id                = "COPITH_OPHIUCHUS",
		name              = "$actionname_ophiuchus",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_ophiuchus",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/ophiuchus.png",
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "1,2,3,4,5,6",
		spawn_probability = "0.1,0.1,0.1,0.1,0.6,0.1",
		price             = 500,
		mana              = 120,
		max_uses          = 5,
		never_unlimited   = true,
		action = function()
			copi_state.mana_multiplier = copi_state.mana_multiplier * 2.0
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/particles/healing.xml,mods/copis_things/files/entities/misc/ophiuchus.xml,"
			friendly_fire = true
			c.fire_rate_wait = c.fire_rate_wait + 12
			current_reload_time = current_reload_time + 12
			draw_actions(1, true)
		end
	},
	{
		id                  = "COPITH_NUGGET_SHOT",
		name                = "$actionname_nugget_shot",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_nugget_shot",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/nugget_shot.png",
		related_projectiles = { "mods/copis_things/files/entities/projectiles/nugget_shot.xml" },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "2,3,4,5",
		spawn_probability   = "0.6,0.6,0.6,0.6",
		price               = 1000,
		mana                = 30,
		action = function()
			local shooter = GetUpdatedEntityID()
			local wallet = EntityGetFirstComponent(shooter, "WalletComponent")
			if wallet ~= nil then
				local money = ComponentGetValue2(wallet, "money")
				local cost = 10
				if money >= cost then
					add_projectile("mods/copis_things/files/entities/projectiles/nugget_shot.xml")
					ComponentSetValue2(wallet, "money", money - cost)
				end
			end
		end
	},
	{
		id                  = "COPITH_ASTRAL_VORTEX",
		name                = "$actionname_astral_vortex",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_astral_vortex",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/astral_vortex.png",
		related_projectiles = { "mods/copis_things/files/entities/projectiles/astral_beam.xml", 6 },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "3,4,5,6",
		spawn_probability   = "0.5,1,1,0.5",
		price               = 260,
		mana                = 75,
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 12
			current_reload_time = current_reload_time + 5

			if reflecting then
				Reflection_RegisterProjectile("mods/copis_things/files/entities/projectiles/astral_vortex.xml")
				for i = 1, 6 do
					Reflection_RegisterProjectile("mods/copis_things/files/entities/projectiles/astral_beam.xml")
				end
				return
			end

			BeginProjectile("mods/copis_things/files/entities/projectiles/astral_vortex.xml")
				BeginTriggerTimer(10)
					BeginProjectile("mods/copis_things/files/entities/projectiles/astral_beam.xml")
					EndProjectile()
					register_action(c)
					SetProjectileConfigs()
				EndTrigger()
				BeginTriggerTimer(20)
					BeginProjectile("mods/copis_things/files/entities/projectiles/astral_beam.xml")
					EndProjectile()
					register_action(c)
					SetProjectileConfigs()
				EndTrigger()
				BeginTriggerTimer(30)
					BeginProjectile("mods/copis_things/files/entities/projectiles/astral_beam.xml")
					EndProjectile()
					register_action(c)
					SetProjectileConfigs()
				EndTrigger()
				BeginTriggerTimer(40)
					BeginProjectile("mods/copis_things/files/entities/projectiles/astral_beam.xml")
					EndProjectile()
					register_action(c)
					SetProjectileConfigs()
				EndTrigger()
				BeginTriggerTimer(50)
					BeginProjectile("mods/copis_things/files/entities/projectiles/astral_beam.xml")
					EndProjectile()
					register_action(c)
					SetProjectileConfigs()
				EndTrigger()
			EndProjectile()
		end
	},
	{
		id                  = "COPITH_LASER_EMITTER_SMALL",
		name                = "$actionname_laser_emitter_small",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_laser_emitter_small",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/laser_small.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/laser_unidentified.png",
		related_projectiles = { "mods/copis_things/files/entities/projectiles/orb_laseremitter_small.xml" },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "0,1,2,3",                                                                     -- LASER
		spawn_probability   = "0.6,1,1,0.6",                                                                 -- LASER
		inject_after        = {"LASER_EMITTER", "LASER_EMITTER_FOUR", "LASER_EMITTER_CUTTER" },
		price               = 180,
		mana                = 10,
		action = function()
			add_projectile("mods/copis_things/files/entities/projectiles/orb_laseremitter_small.xml")
			shot_effects.recoil_knockback = shot_effects.recoil_knockback + 10.0
			c.game_effect_entities = c.game_effect_entities .. "data/entities/misc/effect_disintegrated.xml,"
		end
	},
	{
		id                = "COPITH_ACID",
		name              = "$actionname_acid",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_acid",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/acid.png",
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "2,3,4",
		spawn_probability = "0.3,0.3,0.3",
		price             = 120,
		mana              = 20,
		action = function()
			c.material = "acid"
			c.material_amount = c.material_amount + 10
			draw_actions(1, true)
		end
	},
	{
		id                  = "COPITH_CEMENT",
		name                = "$actionname_cement",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_cement",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/cement.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/unstable_gunpowder_unidentified.png",
		type                = ACTION_TYPE_MODIFIER,
		spawn_level         = "2,3,4",
		spawn_probability   = "0.3,0.3,0.3",
		price               = 140,
		mana                = 15,
		--max_uses          = 20,
		custom_xml_file     = "data/entities/misc/custom_cards/unstable_gunpowder.xml",
		action = function()
			c.material = "cement"
			c.material_amount = c.material_amount + 10
			draw_actions(1, true)
		end
	},
	{
		id                  = "COPITH_LIFETIME_RANDOM",
		name                = "$actionname_lifetime_random",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_lifetime_random",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/lifetime_random.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
		type                = ACTION_TYPE_MODIFIER,
		spawn_level         = "3,4,5,6,10",                                                     -- LIFETIME_DOWN
		spawn_probability   = "0.5,0.5,0.5,0.5,0.1",                                            -- LIFETIME_DOWN
		inject_after        = {"LIFETIME", "LIFETIME_DOWN", "NOLLA"},
		price               = 90,
		mana                = 10,
		--max_uses          = 150,
		action = function()
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/lifetime_random.xml,"
			draw_actions(1, true)
		end
	},
	{
		id                = "COPITH_DELAY_2",
		name              = "$actionname_delay_2",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_delay_2",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/delay_2.png",
		type              = ACTION_TYPE_DRAW_MANY,
		spawn_level       = "0,1,2,3,4,5,6",
		spawn_probability = "0.7,0.7,0.7,0.7,0.7,0.7,0.7",
		inject_after      = {"BURST_2", "BURST_3", "BURST_4", "BURST_8", "BURST_X"},
		price             = 150,
		mana              = 0,
		--max_uses        = 100,
		action = function()
			if reflecting then
				draw_actions(2, true)
				return
			end

			local firerate = math.max(c.fire_rate_wait, 9)
			local old_c = c
			c = {}
			shot_effects = {}
			--reset_modifiers(c);

			BeginProjectile("mods/copis_things/files/entities/projectiles/separator_cast.xml")
			BeginTriggerDeath()
			BeginProjectile("mods/copis_things/files/entities/projectiles/burst_fire.xml")
			BeginTriggerTimer(1)
			reset_modifiers( c );
			for index, value in pairs(old_c) do
				c[index] = value
			end
			old_c = c
			draw_actions(1, true)
			register_action(c)
			SetProjectileConfigs()
			EndTrigger()
			BeginTriggerTimer(firerate + 1)
			reset_modifiers( c );
			for index, value in pairs(old_c) do
				c[index] = value
			end
			old_c = c
			draw_actions(1, true)
			register_action(c)
			SetProjectileConfigs()
			EndTrigger()
			EndProjectile()
			c.lifetime_add = firerate + 1
			register_action(c)
			SetProjectileConfigs()
			EndTrigger()
			EndProjectile()

			c = old_c
		end
	},
	{
		id                = "COPITH_DELAY_3",
		name              = "$actionname_delay_3",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_delay_3",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/delay_3.png",
		type              = ACTION_TYPE_DRAW_MANY,
		spawn_level       = "0,1,2,3,4,5,6",
		spawn_probability = "0.5,0.5,0.5,0.5,0.5,0.5,0.5",
		inject_after      = {"BURST_2", "BURST_3", "BURST_4", "BURST_8", "BURST_X"},
		price             = 150,
		mana              = 0,
		--max_uses        = 100,
		action = function()
			if reflecting then
				draw_actions(3, true)
				return
			end

			local firerate = math.max(c.fire_rate_wait, 9)
			local old_c = c
			c = {}
			shot_effects = {}
			--reset_modifiers(c);

			BeginProjectile("mods/copis_things/files/entities/projectiles/separator_cast.xml")
			BeginTriggerDeath()
			BeginProjectile("mods/copis_things/files/entities/projectiles/burst_fire.xml")
			BeginTriggerTimer(1)
			reset_modifiers( c );
			for index, value in pairs(old_c) do
				c[index] = value
			end
			old_c = c
			draw_actions(1, true)
			register_action(c)
			SetProjectileConfigs()
			EndTrigger()
			BeginTriggerTimer(firerate + 1)
			reset_modifiers( c );
			for index, value in pairs(old_c) do
				c[index] = value
			end
			old_c = c
			draw_actions(1, true)
			register_action(c)
			SetProjectileConfigs()
			EndTrigger()
			BeginTriggerTimer(firerate * 2 + 1)
			reset_modifiers( c );
			for index, value in pairs(old_c) do
				c[index] = value
			end
			old_c = c
			draw_actions(1, true)
			register_action(c)
			SetProjectileConfigs()
			EndTrigger()
			EndProjectile()
			c.lifetime_add = firerate * 2 + 1
			register_action(c)
			SetProjectileConfigs()
			EndTrigger()
			EndProjectile()

			c = old_c
		end
	},
	{
		id                = "COPITH_DELAY_X",
		name              = "$actionname_delay_x",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_delay_x",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/delay_x.png",
		type              = ACTION_TYPE_DRAW_MANY,
		spawn_level       = "5,6,10",
		spawn_probability = "0.2,0.2,0.5",
		inject_after      = {"BURST_2", "BURST_3", "BURST_4", "BURST_8", "BURST_X"},
		price             = 500,
		mana              = 50,
		max_uses          = 30,
		action = function()
			if reflecting then
				return
			end

			local firerate = math.max(c.fire_rate_wait, 9)
			local old_c = c
			c = {}
			shot_effects = {}
			--reset_modifiers(c);

			BeginProjectile("mods/copis_things/files/entities/projectiles/separator_cast.xml")
			BeginTriggerDeath()
			local n = 0
			BeginProjectile("mods/copis_things/files/entities/projectiles/burst_fire.xml")
			while (#deck > 0) do
				BeginTriggerTimer(firerate * n + 1)
				reset_modifiers( c );
				for index, value in pairs(old_c) do
					c[index] = value
				end
				old_c = c
				draw_actions(1, true)
				register_action(c)
				SetProjectileConfigs()
				EndTrigger()
				n = n + 1
			end
			EndProjectile()
			c.lifetime_add = firerate * n + 1
			register_action(c)
			SetProjectileConfigs()
			EndTrigger()
			EndProjectile()

			c = old_c
		end
	},
	{
		id                     = "COPITH_CHAOS_RAY",
		name                   = "$actionname_chaos_ray",
		author                 = "Copi",
		mod                    = "Copi's Things",
		description            = "$actiondesc_chaos_ray",
		sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/chaos_ray.png",
		sprite_unidentified    = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
		related_extra_entities = { "mods/copis_things/files/entities/misc/chaos_ray.xml" },
		type                   = ACTION_TYPE_MODIFIER,
		spawn_level            = "3,4,5",
		spawn_probability      = "0.3,0.5,0.3",
		inject_after           = {"FIREBALL_RAY_LINE"},
		price                  = 260,
		mana                   = 140,
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 15
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/chaos_ray.xml,"
			draw_actions(1, true)
		end
	},
	{
		id                = "COPITH_ORDER_DECK",
		name              = "$actionname_order_deck",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_order_deck",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/order_deck.png",
		type              = ACTION_TYPE_PASSIVE,
		spawn_level       = "0,1,2,3,4",
		spawn_probability = "1,1,1,1,1",
		price             = 100,
		mana              = 7,
		custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/order_deck.xml",
		action = function()
			draw_actions(1, true)
		end
	},
	{
		id                  = "COPITH_MANA_EFFICENCY",
		name                = "$actionname_mana_efficency",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_mana_efficency",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/mana_efficiency.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
		type                = ACTION_TYPE_MODIFIER,
		spawn_level         = "3,4,5,6",
		spawn_probability   = "0.2,0.2,0.2,0.2",
		inject_after        = {"MANA_REDUCE"},
		price               = 150,
		mana                = 0,
		action = function()
			copi_state.mana_multiplier = copi_state.mana_multiplier * 0.5
			draw_actions(1, true)
		end
	},
	{
		id                  = "COPITH_ULT_DAMAGE",
		name                = "$actionname_ult_damage",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_ult_damage",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/ult_damage.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
		type                = ACTION_TYPE_MODIFIER,
		spawn_level         = "2,3,4,5,6,10",
		spawn_probability   = "0.12,0.12,0.12,0.24,0.24,0.36",
		price               = 500,
		mana                = 20,
		custom_xml_file     = "mods/copis_things/files/entities/misc/custom_cards/ult_damage.xml",
		action = function()
			copi_state.mana_multiplier = copi_state.mana_multiplier * 3.0
			c.damage_projectile_add = c.damage_projectile_add + 0.08
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/ult_damage.xml,"
			draw_actions(1, true)
		end
	},
	{
		id                  = "COPITH_ULT_DRAW_MANY",
		name                = "$actionname_ult_draw_many",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_ult_draw_many",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/ult_draw_many.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/slow_bullet_timer_unidentified.png",
		type                = ACTION_TYPE_DRAW_MANY,
		spawn_level         = "2,3,4,5,6,10",
		spawn_probability   = "0.12,0.12,0.12,0.24,0.24,0.36",
		price               = 500,
		mana                = 25,
		max_uses            = 10,
		custom_xml_file     = "mods/copis_things/files/entities/misc/custom_cards/ult_draw_many.xml",
		recursive           = true,
		never_ac            = true,
		action = function(recursion_level, iteration)
			if reflecting then
				return
			end
			if (recursion_level or iteration) ~= nil then
				return
			end

			local n = 1
			while (#deck > 0) do
				n = n + 1
				draw_actions(1, true)
			end

			c.spread_degrees			= c.spread_degrees			+ (n * 2.5)
			c.fire_rate_wait			= c.fire_rate_wait			+ (n * 6)
			c.screenshake				= c.screenshake				+ (n * 1)
			c.damage_critical_chance	= c.damage_critical_chance	+ (n * 2)
			c.lifetime_add				= c.lifetime_add			+ (n * 1)
			c.damage_projectile_add		= c.damage_projectile_add	+ (n * 0.05)
			c.speed_multiplier			= c.speed_multiplier		+ (n * 0.2)
			c.gore_particles			= c.gore_particles			+ (n * 2)
			c.bounces					= c.bounces					+ math.floor(n * 0.25)
			if n >= 20 then
				c.extra_entities = c.extra_entities .. "data/entities/particles/tinyspark_white.xml,"
				c.ragdoll_fx = 3
			elseif n >= 10 then
				c.extra_entities = c.extra_entities .. "data/entities/particles/tinyspark_white_weak.xml,"
				c.ragdoll_fx = 4
				c.explosion_radius = c.explosion_radius + math.floor(n * 0.25)
			end
			shot_effects.recoil_knockback = shot_effects.recoil_knockback + (n * 1)
		end
	},
	{
		id                  = "COPITH_ULT_LIFETIME",
		name                = "$actionname_ult_lifetime",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_ult_lifetime",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/ult_lifetime.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
		type                = ACTION_TYPE_MODIFIER,
		spawn_level         = "2,3,4,5,6,10",
		spawn_probability   = "0.12,0.12,0.12,0.24,0.24,0.36",
		inject_after        = {"LIFETIME", "LIFETIME_DOWN", "NOLLA"},
		price               = 150,
		mana                = 30,
		custom_xml_file     = "mods/copis_things/files/entities/misc/custom_cards/ult_lifetime.xml",
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 64
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/ult_lifetime.xml,"
			draw_actions(1, true)
		end
	},
	{
		id                  = "COPITH_ULT_CONTROL",
		name                = "$actionname_ult_control",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_ult_control",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/ult_control.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
		type                = ACTION_TYPE_MODIFIER,
		spawn_level         = "2,3,4,5,6,10",
		spawn_probability   = "0.12,0.12,0.12,0.24,0.24,0.36",
		inject_after        = {"HOMING", "HOMING_SHORT", "HOMING_ROTATE", "HOMING_SHOOTER", "AUTOAIM", "HOMING_ACCELERATING", "HOMING_CURSOR", "HOMING_AREA"},
		subtype             = { homing = true },
		price               = 80,
		mana                = 10,
		pandorium_ignore    = true,
		custom_xml_file     = "mods/copis_things/files/entities/misc/custom_cards/ult_control.xml",
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 32
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/ult_control.xml,"
			draw_actions(1, true)
		end
	},
	{
		id                  = "COPITH_ULT_RECHARGE",
		name                = "$actionname_ult_recharge",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_ult_recharge",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/ult_recharge.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
		type                = ACTION_TYPE_MODIFIER,
		spawn_level         = "2,3,4,5,6,10",
		spawn_probability   = "0.12,0.12,0.12,0.24,0.24,0.36",
		inject_after        = {"RECHARGE"},
		price               = 140,
		mana                = 30,
		custom_xml_file     = "mods/copis_things/files/entities/misc/custom_cards/ult_recharge.xml",
		action = function()
			if reflecting then
				copi_state.mana_multiplier = copi_state.mana_multiplier * 2.0
				c.fire_rate_wait = c.fire_rate_wait / 3
				current_reload_time = current_reload_time / 3
				draw_actions(1, true)
				return
			end
			copi_state.mana_multiplier = copi_state.mana_multiplier * 2.0
			c.fire_rate_wait = math.min(c.fire_rate_wait / 3, c.fire_rate_wait - 16)
			current_reload_time = math.min(current_reload_time / 3, current_reload_time - 16)
			draw_actions(1, true)
		end
	},
	{
		id                  = "COPITH_ULT_PROTECTION",
		name                = "$actionname_ult_protection",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_ult_protection",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/ult_protection.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
		type                = ACTION_TYPE_MODIFIER,
		spawn_level         = "0,1,2,3,4,5,6",
		spawn_probability   = "0.5,0.5,0.5,0.5,0.5,0.5,0.5",
		price               = 200,
		mana                = 23,
		custom_xml_file     = "mods/copis_things/files/entities/misc/custom_cards/ult_protection.xml",
		action = function()
			copi_state.mana_multiplier = copi_state.mana_multiplier * 3.0
			c.fire_rate_wait = c.fire_rate_wait + 17
			current_reload_time = current_reload_time + 17
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/ult_protection.xml,"
			draw_actions(1, true)
		end
	},
	{
		id                  = "COPITH_BALLOON",
		name                = "$actionname_balloon",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_balloon",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/balloon.png",
		related_projectiles = { "mods/copis_things/files/entities/projectiles/balloon.xml" },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "0,1,2,3,4,5,6",
		spawn_probability   = "0.6,0.6,0.6,0.4,0.2,0.2,0.2",
		price               = 90,
		mana                = 12,
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 12
			current_reload_time = current_reload_time + 12
			add_projectile("mods/copis_things/files/entities/projectiles/balloon.xml")
		end
	},
	{
		id                = "COPITH_HOMING_SEEKER",
		name              = "$actionname_homing_seeker",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_homing_seeker",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/homing_seeker.png",
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "0,1,2,3,4,5,6",
		spawn_probability = "0.1,0.2,0.3,0.4,0.5,0.4,0.3",
		inject_after      = {"HOMING", "HOMING_SHORT", "HOMING_ROTATE", "HOMING_SHOOTER", "AUTOAIM", "HOMING_ACCELERATING", "HOMING_CURSOR", "HOMING_AREA"},
		subtype           = { homing = true },
		price             = 280,
		mana              = 22,
		action = function()
			c.bounces = c.bounces + 1
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/homing_seeker.xml,"
			c.speed_multiplier = c.speed_multiplier * 0.65
			draw_actions(1, true)
		end
	},
	{
		id                = "COPITH_PERSISTENT_SHOT",
		name              = "$actionname_persistent_shot",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_persistent_shot",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/persistent_shot.png",
		type              = ACTION_TYPE_DRAW_MANY,
		spawn_level       = "0,1,2,3,4",
		spawn_probability = "0.4,0.4,0.4,0.4,0.4",
		price             = 160,
		mana              = 17,
		action = function()
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/persistent_shot.xml,"
			draw_actions(2, true)
		end
	},
	{
		id                = "COPITH_HYPER_BOUNCE",
		name              = "$actionname_hyper_bounce",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_hyper_bounce",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/hyper_bounce.png",
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "2,3,4",
		spawn_probability = "0.8,0.8,0.8",
		subtype           = 
		{
			bounce = true,
		},
		price = 300,
		mana  = 15,
		action = function()
			c.bounces = c.bounces + 100
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/hyper_bounce.xml,"
			draw_actions(1, true)
		end
	},
	{
		id                = "COPITH_ULTRAKILL",
		name              = "$actionname_ultrakill",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_ultrakill",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/ultrakill.png",
		type              = ACTION_TYPE_PASSIVE,
		spawn_level       = "1,2,3,4,5",
		spawn_probability = "0.2,0.3,0.2,0.1,0.1",
		price             = 280,
		mana              = 5,
		skip_mana         = true,
		custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/ultrakill.xml",
		action = function()
			-- does nothing to the projectiles
			draw_actions(1, true)
		end
	},
	{
		id                = "COPITH_WOOD_BRUSH",
		name              = "$actionname_wood_brush",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_wood_brush",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/wood_brush.png",
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "1,2,3,4",
		spawn_probability = "0.3,0.3,0.3,0.3",
		price             = 300,
		mana              = 30,
		action = function()
			c.speed_multiplier = c.speed_multiplier * 0.75
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/wood_brush.xml,"
			draw_actions(1, true)
		end
	},
	{
		id                     = "COPITH_HOMING_ANTI_SHOOTER",
		name                   = "$actionname_homing_anti_shooter",
		author                 = "Copi",
		mod                    = "Copi's Things",
		description            = "$actiondesc_homing_anti_shooter",
		sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/homing_anti_shooter.png",
		related_extra_entities = {
			"mods/copis_things/files/entities/misc/homing_anti_shooter.xml,data/entities/particles/tinyspark_white_weak.xml"
		},
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "1,2,3,4,5,6",
		spawn_probability = "0.1,0.1,0.1,0.1,0.1,6",
		inject_after      = {"HOMING", "HOMING_SHORT", "HOMING_ROTATE", "HOMING_SHOOTER", "AUTOAIM", "HOMING_ACCELERATING", "HOMING_CURSOR", "HOMING_AREA"},
		subtype           = { homing = true },
		price             = 100,
		mana              = 12,
		action = function()
			c.extra_entities =
				c.extra_entities ..
				"mods/copis_things/files/entities/misc/homing_anti_shooter.xml,data/entities/particles/tinyspark_white_weak.xml,"
			draw_actions(1, true)
		end
	},
	{
		id                = "COPITH_ALCOHOL_SHOT",
		name              = "$actionname_alcohol_shot",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_alcohol_shot",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/inebriation.png",
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "1,2,3,4,5",
		spawn_probability = "0.4,0.4,0.4,0.4,0.4",
		price             = 70,
		mana              = 10,
		action = function()
			c.game_effect_entities = c.game_effect_entities .. "data/entities/misc/effect_drunk.xml,"
			draw_actions(1, true)
		end
	},
	{
		id                = "COPITH_SPREAD_DAMAGE",
		name              = "$actionname_spread_damage",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_spread_damage",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/spread_damage.png",
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "2,3,4,5,6",
		spawn_probability = "0.5,0.6,0.7,0.5,0.5",
		price             = 150,
		mana              = 10,
		action = function()
			copi_state.mana_multiplier = copi_state.mana_multiplier * 2.0
			if not c.extra_entities:find("mods/copis_things/files/entities/misc/spread_damage_unique.xml,") then
				c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/spread_damage_unique.xml,"
			end
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/spread_damage.xml,"
			draw_actions(1, true)
		end
	},
	{
		id                = "COPITH_SUMMON_JAR_URINE",
		name              = "$actionname_summon_jar_urine",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "Jar-based Karate",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/summon_jar_urine.png",
		type              = ACTION_TYPE_UTILITY,
		spawn_level       = "2,3,4,5,6,10",
		spawn_probability = "0.1,0.033,0.050,0.033,0.025,0.2",
		price             = 200,
		mana              = 45,
		max_uses          = 30,
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 10
			current_reload_time = current_reload_time + 20
			add_projectile("data/entities/items/pickup/jar_of_urine.xml")
		end
	},
	{
		id                = "COPITH_DAMAGE_BOUNCE",
		name              = "$actionname_damage_bounce",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_damage_bounce",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/damage_bounce.png",
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "2,3,4,5,6",
		spawn_probability = "0.3,0.4,0.5,0.6,0.6",
		inject_after      = {"HEAVY_SHOT", "LIGHT_SHOT"},
		subtype           = 
			{
				bounce = true,
			},
		price = 150,
		mana  = 15,
		action = function()
			c.bounces = c.bounces + 3
			c.damage_projectile_add = c.damage_projectile_add + 0.1
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/damage_bounce.xml,"
			if not c.extra_entities:find("mods/copis_things/files/entities/misc/bounce_tracker.xml,") then
				c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/bounce_tracker.xml,"
			end
			draw_actions(1, true)
		end
	},
	{
		id                = "COPITH_DIE",
		name              = "$actionname_die",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_die",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/die.png",
		type              = ACTION_TYPE_UTILITY,
		spawn_level       = "6,10",
		spawn_probability = "0.2,1",
		price             = 250,
		mana              = 0,
		action            = events.april_fools and function ()
			if reflecting then return end
			local players   = EntityGetWithTag( "player_unit" ) or {}
			for   i         = 1, #players do
			local entity_id = players[i]
			local x,         y,  r, sx, sy = EntityGetTransform(entity_id)
				EntityLoad(table.concat{"data/entities/particles/image_emitters/player_disappear_effect_", (sx<0 and "left" or "right"), ".xml"}, x, y) -- gfx
				EntityInflictDamage(entity_id, 99999999999999999999999999999999999999999999999999999999999999999, "DAMAGE_PHYSICS_BODY_DAMAGED", "death.", "DISINTEGRATED", 0, 0, entity_id, x, y, 10)
				GamePrintImportant("April Fooled")
				EntityKill(entity_id)
			end
		end or function()
			if reflecting then return end
			local entity_id = GetUpdatedEntityID()
			local x,         y, r, sx, sy = EntityGetTransform(entity_id)
			EntityLoad(table.concat{"data/entities/particles/image_emitters/player_disappear_effect_", (sx<0 and "left" or "right"), ".xml"}, x, y) -- gfx
			EntityInflictDamage(entity_id, 99999999999999999999999999999999999999999999999999999999999999999, "DAMAGE_PHYSICS_BODY_DAMAGED", "death.", "DISINTEGRATED", 0, 0, entity_id, x, y, 10)
			EntityKill(entity_id)
		end
	},
	{
		id                  = "COPITH_ENERGY_SHIELD_DIRECTIONAL",
		name                = "$actionname_energy_shield_directional",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_energy_shield_directional",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/energy_shield_directional.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/energy_shield_sector_unidentified.png",
		type                = ACTION_TYPE_PASSIVE,
		spawn_level         = "0,1,2,3,4,5",
		spawn_probability   = "0.05,0.6,0.6,0.6,0.6,0.6",
		inject_after        = {"ENERGY_SHIELD", "ENERGY_SHIELD_SECTOR"},
		price               = 160,
		mana                = 0,
		custom_xml_file     = "mods/copis_things/files/entities/misc/custom_cards/energy_shield_directional.xml",
		action = function()
			-- does nothing to the projectiles
			draw_actions(1, true)
		end
	},
	{
		id                  = "COPITH_CLEANING_TOOL",
		name                = "$actionname_cleaning_tool",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_cleaning_tool",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/cleaning_tool.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/energy_shield_sector_unidentified.png",
		type                = ACTION_TYPE_PASSIVE,
		spawn_level         = "0,1,2,3,4,5",
		spawn_probability   = "0.01,0.2,0.3,0.2,0.2,0.2",
		price               = 160,
		mana                = 0,
		custom_xml_file     = "mods/copis_things/files/entities/misc/custom_cards/cleaning_tool.xml",
		action = function()
			-- does nothing to the projectiles
			draw_actions(1, true)
		end
	},
	{
		id                = "COPITH_COIN",
		name              = "$actionname_coin",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "Toss a coin in the air. Requires 10 gold. Maybe you can shoot it?",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/ricoinshot.png",
		type              = ACTION_TYPE_UTILITY,
		spawn_level       = "1, 2, 3, 4, 5, 6",
		spawn_probability = "0.6, 0.3, 0.1,	0.1, 0.1, 0.1",
		price             = 25,
		mana              = 0,
		action = function()
			if not reflecting then
				local shooter = GetUpdatedEntityID()
				local wallet_component = EntityGetFirstComponentIncludingDisabled(shooter, "WalletComponent")
				if wallet_component ~= nil then
					local money = ComponentGetValue2(wallet_component, "money")
					if money >= 10 then
						ComponentSetValue2(wallet_component, "money", money - 10)
						add_projectile("mods/copis_things/files/entities/projectiles/coin.xml")
					end
				end
			end
			c.fire_rate_wait = c.fire_rate_wait + 10
			current_reload_time = current_reload_time + 20
		end
	},
	{
		id                = "COPITH_ALT_FIRE_COIN",
		name              = "$actionname_alt_fire_coin",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "Toss a coin in the air when you alt fire. Requires 10 gold. Maybe you can shoot it?",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/alt_fire_ricoinshot.png",
		type              = ACTION_TYPE_PASSIVE,
		spawn_level       = "1, 2, 3, 4, 5, 6",
		spawn_probability = "0.8, 0.7, 0.5,	0.3, 0.1, 0.1",
		price             = 30,
		mana              = 0,
		custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/alt_fire_coin.xml",
		action = function()
			draw_actions(1, true)
		end
	},
	{
		id                     = "COPITH_VERTICAL_ARC",
		name                   = "$actionname_vertical_arc",
		author                 = "Copi",
		mod                    = "Copi's Things",
		description            = "$actiondesc_vertical_arc",
		sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/vertical_arc.png",
		sprite_unidentified    = "data/ui_gfx/gun_actions/sinewave_unidentified.png",
		related_extra_entities = { "mods/copis_things/files/entities/misc/vertical_arc.xml" },
		type                   = ACTION_TYPE_MODIFIER,
		spawn_level            = "1,3,5",
		spawn_probability      = "0.4,0.4,0.4",
		price                  = 20,
		mana                   = 0,
		--max_uses             = 150,
		action = function()
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/vertical_arc.xml,"
			draw_actions(1, true)
			c.damage_projectile_add = c.damage_projectile_add + 0.3
			c.fire_rate_wait		= c.fire_rate_wait - 6
		end,
	},
	{
		id                     = "COPITH_ARC_CONCRETE",
		name                   = "$actionname_arc_concrete",
		author                 = "Copi",
		mod                    = "Copi's Things",
		description            = "Creates arcs of concrete between projectiles. Make sure not to get stuck! (requires 2 projectile spells)",
		sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/arc_concrete.png",
		sprite_unidentified    = "data/ui_gfx/gun_actions/arc_fire_unidentified.png",
		related_extra_entities = { "mods/copis_things/files/entities/misc/arc_concrete.xml" },
		type                   = ACTION_TYPE_MODIFIER,
		spawn_level            = "1,2,3,4,5",
		spawn_probability      = "0.4,0.4,0.4,0.4,0.4",
		inject_after           = {"ARC_ELECTRIC", "ARC_FIRE", "ARC_GUNPOWDER", "ARC_POISON"},
		price                  = 160,
		--max_uses             = 15,
		mana                   = 15,
		action = function()
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/arc_concrete.xml,"
			draw_actions(1, true)
		end,
	},
	{
		id                = "COPITH_MANA_ENGINE",
		name              = "$actionname_mana_engine",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_mana_engine",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/mana_engine.png",
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "1,2,3,4,5,6",
		spawn_probability = "0.1,0.2,0.3,0.4,0.5,0.6",
		inject_after      = {"MANA_REDUCE"},
		price             = 220,
		mana              = -80,
		skip_mana         = true,
		action = function()
			if reflecting then
				return
			end
			local caster = GetUpdatedEntityID()
			local controls_component = EntityGetFirstComponentIncludingDisabled(caster, "ControlsComponent");
			if controls_component ~= nil then
				LastShootingStart = LastShootingStart or 0
				Revs = Revs or 0
				local shooting_start = ComponentGetValue2(controls_component, "mButtonFrameFire");
				local shooting_now = ComponentGetValue2(controls_component, "mButtonDownFire");

				if not shooting_now then
					Revs = 0
				else
					if LastShootingStart ~= shooting_start then
						Revs = 0
					else
						Revs = Revs + 1
						-- I have no clue what this bs scaling is I threw it together in desmso DM me on discord Human#6606 if you have a better func to use
						local mana_add = math.min(80, math.ceil((Revs / 5) ^ 1.5) * 4)
						local delay_add = math.min(40, Revs ^ (1 / 3))
						mana = mana + mana_add
						c.fire_rate_wait = c.fire_rate_wait + delay_add
					end
				end
				LastShootingStart = shooting_start
				draw_actions(1, true)
			end
		end,
	},
	{
		id                = "COPITH_RECHARGE_ENGINE",
		name              = "$actionname_recharge_engine",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_recharge_engine",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/recharge_engine.png",
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "1,2,3,4,5,6",
		spawn_probability = "0.8,0.8,0.8,0.8,0.8,0.8",
		inject_after      = {"RECHARGE"},
		price             = 220,
		mana              = 20,
		action = function()
			if reflecting then
				return
			end
			local caster = GetUpdatedEntityID()
			local controls_component = EntityGetFirstComponentIncludingDisabled(caster, "ControlsComponent");
			if controls_component ~= nil then
				LastShootingStart = LastShootingStart or 0
				Revs = Revs or 0
				local shooting_start = ComponentGetValue2(controls_component, "mButtonFrameFire");
				local shooting_now = ComponentGetValue2(controls_component, "mButtonDownFire");

				if not shooting_now then
					Revs = 0
				else
					if LastShootingStart ~= shooting_start then
						Revs = 0
					else
						Revs = Revs + 1
						-- I have no clue what this bs scaling is I threw it together in desmso DM me on discord Human#6606 if you have a better func to use
						local reload_reduce = math.min(80, Revs ^ (1 / 2))
						current_reload_time = current_reload_time - reload_reduce
						c.fire_rate_wait = c.fire_rate_wait - reload_reduce
						c.spread_degrees = c.spread_degrees + math.min(Revs ^ (1 / 4), 75)
					end
				end
				LastShootingStart = shooting_start
				draw_actions(1, true)
			end
		end,
	},
	{
		id                = "COPITH_DAMAGE_ENGINE",
		name              = "$actionname_damage_engine",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_damage_engine",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/damage_engine.png",
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "1,2,3,4,5,6",
		spawn_probability = "0.8,0.8,0.8,0.8,0.8,0.8",
		price             = 220,
		mana              = 10,
		action = function()
			if reflecting then
				c.damage_fire_add = c.damage_fire_add + 0.08
				return
			end
			local caster = GetUpdatedEntityID()
			local controls_component = EntityGetFirstComponentIncludingDisabled(caster, "ControlsComponent");
			if controls_component ~= nil then
				LastShootingStart = LastShootingStart or 0
				Revs = Revs or 0
				local shooting_start = ComponentGetValue2(controls_component, "mButtonFrameFire");
				local shooting_now = ComponentGetValue2(controls_component, "mButtonDownFire");

				if not shooting_now then
					Revs = 0
				else
					if LastShootingStart ~= shooting_start then
						Revs = 0
					else
						Revs = Revs + 1
						-- I have no clue what this bs scaling is I threw it together in desmso DM me on discord Human#6606 if you have a better func to use
						c.damage_fire_add = c.damage_fire_add + math.min(0.64, Revs / 100)
						if math.random(0, 100) < math.min(Revs, 200) / 2 then
							GetGameEffectLoadTo(caster, "ON_FIRE", false)
						end
					end
				end
				LastShootingStart = shooting_start
				draw_actions(1, true)
			end
		end,
	},
	{
		id                = "COPITH_SHIELD_ENGINE",
		name              = "$actionname_shield_engine",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_shield_engine",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/shield_engine.png",
		type              = ACTION_TYPE_PASSIVE,
		spawn_level       = "1,2,3,4,5,6",
		spawn_probability = "0.8,0.8,0.8,0.8,0.8,0.8",
		price             = 220,
		mana              = 4,
		custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/shield_engine.xml",
		action = function()
			if reflecting then
				return
			end
			local caster = GetUpdatedEntityID()
			local controls_component = EntityGetFirstComponentIncludingDisabled(caster, "ControlsComponent");
			if controls_component ~= nil then
				LastShootingStart = LastShootingStart or 0
				Revs = Revs or 0
				local shooting_start = ComponentGetValue2(controls_component, "mButtonFrameFire");
				local shooting_now = ComponentGetValue2(controls_component, "mButtonDownFire");

				if not shooting_now then
					Revs = 0
				else
					if LastShootingStart ~= shooting_start then
						Revs = 0
					else
						Revs = Revs + 1
					end
				end
				LastShootingStart = shooting_start
				GlobalsSetValue("PLAYER_REVS", tostring(Revs))
				draw_actions(1, true)
			end
		end,
	},
	{
		id                = "COPITH_RAINBOW_TRAIL",
		name              = "$actionname_rainbow_trail",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_rainbow_trail",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/rainbow_trail.png",
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "0,1,2,3,4,5,6",
		spawn_probability = "0.8,0.6,0.4,0.2,0.2,0.2,0.2",
		price             = 10,
		mana              = 0,
		action = function()
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/rainbow_trail.xml,"
			draw_actions(1, true)
		end,
	},
	--[[
	{
		id                  = "COPITH_TARGET_TRIGGER",
		name                = "Target with expiration trigger",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "A target which fires a projectile when it is destroyed.",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/target_death_trigger.png",
		related_projectiles = { "--mods/copis_things/files/entities/projectiles/target.xml" },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "0,1,2,3,4,5,6",
		spawn_probability   = "1,1,1,1,1,1,1",
		price               = 90,
		mana                = 2,
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 12
			current_reload_time = current_reload_time + 12
			if reflecting then
				Reflection_RegisterProjectile( "--mods/copis_things/files/entities/projectiles/target.xml" )
				return
			end

			BeginProjectile( "--mods/copis_things/files/entities/projectiles/target.xml" )
				BeginTriggerDeath()
					draw_shot( create_shot( 1 ), true )
				EndTrigger()
			EndProjectile()
		end
	},]]
	{
		id                = "COPITH_CONFETTI_TRAIL",
		name              = "$actionname_confetti_trail",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_confetti_trail",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/confetti_trail.png",
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "0,1,2,3,4,5,6",
		spawn_probability = events.birthday and "1,1,1,1,1,1,1" or "0.8,0.6,0.4,0.2,0.2,0.2,0.2",
		price             = 10,
		mana              = 0,
		action = function()
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/confetti_trail.xml,"
			draw_actions(1, true)
		end
	},
	{
		id                = "COPITH_SWORD_FORMATION",
		name              = "$actionname_sword_formation",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_sword_formation",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/sword_formation.png",
		type              = ACTION_TYPE_DRAW_MANY,
		spawn_level       = "0,1,2,3,4,5,6",
		spawn_probability = "0.5,0.6,0.3,0.2,0.2,0.2,0.2",
		price             = 10,
		mana              = 0,
		action = function()

			if not reflecting then
				c.lifetime_add = math.max(c.lifetime_add, 2)

				if c.caststate == nil then
					-- Relies on gun.lua haxx refer to "gun_append.lua" if you want to use data transfer haxx
					c.action_description = table.concat(
						{
							(c.action_description or ""),
							"\nCASTSTATE|",
							GlobalsGetValue("GLOBAL_CAST_STATE", "0"),
						}
					)
					c.caststate = true
				end
				c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/sword_parser.xml,"

				if c.formation == nil then
					add_projectile("mods/copis_things/files/entities/misc/sword_separator.xml")
					c.formation = "sword"
				end
			end

			draw_actions(5, true)
		end
	},
	{
		id                = "COPITH_LINK_SHOT",
		name              = "$actionname_link_shot",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_link_shot",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/link_shot.png",
		type              = ACTION_TYPE_DRAW_MANY,
		spawn_level       = "0,1,2,3,4,5,6",
		spawn_probability = "0.2,0.2,0.2,0.2,0.2,0.2,0.2",
		price             = 10,
		mana              = 0,
		action = function()

			if not reflecting then

				if c.caststate == nil then
					-- Relies on gun.lua haxx refer to "gun_append.lua" if you want to use data transfer haxx
					c.action_description = table.concat(
						{
							(c.action_description or ""),
							"\nCASTSTATE|",
							GlobalsGetValue("GLOBAL_CAST_STATE", "0"),
						}
					)
					c.caststate = true
				end
				c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/link_shot.xml,"

			end

			draw_actions(2, true)
		end
	},
	{
		-- Todo optimize
		id                = "COPITH_BARRIER_ARC",
		name              = "$actionname_barrier_arc",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "Creates arcs of barriers between projectiles (requires 2 projectile spells)",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/barrier_arc.png",
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "2,3,4,5,6",
		spawn_probability = "0.4,0.4,0.4,0.4,0.8",
		price             = 10,
		mana              = 0,
		action = function()

			if not reflecting then
				if c.caststate == nil then
					-- Relies on gun.lua haxx refer to "gun_append.lua" if you want to use data transfer haxx
					c.action_description = table.concat(
						{
							(c.action_description or ""),
							"\nCASTSTATE|",
							GlobalsGetValue("GLOBAL_CAST_STATE", "0"),
						}
					)
					c.caststate = true
				end
			end
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/barrier_arc.xml,"

			draw_actions(1, true)
		end
	},
	{
		id                  = "COPITH_LIQUID_EATER",
		name                = "$actionname_liquid_eater",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_liquid_eater",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/liquid_eater.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
		type                = ACTION_TYPE_MODIFIER,
		spawn_level         = "1,2,4,5,6",
		spawn_probability   = "0.6,0.6,0.4,0.2,0.1",
		inject_after        = {"MATTER_EATER"},
		price               = 180,
		mana                = 60,
		action 		= function()
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/liquid_eater.xml,"
			draw_actions( 1, true )
		end,
	},
	{
		id                = "COPITH_BURST_FIRE",
		name              = "$actionname_burst_fire",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_burst_fire",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/burst_fire.png",
		type              = ACTION_TYPE_OTHER,
		spawn_level       = "0,1,2,3,4,5,6",
		spawn_probability = "0.2,0.2,0.2,0.2,0.2,0.2,0.2",
		inject_after      = {"DIVIDE_2", "DIVIDE_3", "DIVIDE_4", "DIVIDE_10"},
		price             = 10,
		mana              = 0,
		action = function()
			if reflecting then
				return
			end
			local burst_wait = (c.fire_rate_wait + math.ceil( gun.reload_time / 5 )) / 3
			local old_c = c
			c = {}
			reset_modifiers( c )

			copi_state.mana_multiplier = copi_state.mana_multiplier * 2.0
			local deck_snapshot = peek_draw_actions( 1, true )
			BeginProjectile( "mods/copis_things/files/entities/projectiles/trigger_projectile.xml" )
				BeginTriggerDeath()
					BeginProjectile( "mods/copis_things/files/entities/projectiles/burst_projectile.xml" )
						BeginTriggerTimer( 1 )
							reset_modifiers( c )
							for k,v in pairs( old_c ) do
								c[k] = v
							end
							c.spread_degrees = c.spread_degrees + 2
							GunUtils.temporary_deck( function( deck, hand, discarded ) draw_actions( 1, true ); end, GunUtils.deck_from_actions( deck_snapshot ), {}, {} )
							register_action( c )
							SetProjectileConfigs()
						EndTrigger()

						BeginTriggerTimer( burst_wait )
							reset_modifiers( c )
							for k,v in pairs( old_c ) do
								c[k] = v
							end
							c.spread_degrees = c.spread_degrees + 2
							GunUtils.temporary_deck( function( deck, hand, discarded ) draw_actions( 1, true ); end, GunUtils.deck_from_actions( deck_snapshot ), {}, {} )
							register_action( c )
							SetProjectileConfigs()
						EndTrigger()

						BeginTriggerTimer( burst_wait * 2 )
							reset_modifiers( c )
							for k,v in pairs( old_c ) do
								c[k] = v
							end
							c.spread_degrees = c.spread_degrees + 2
							GunUtils.temporary_deck( function( deck, hand, discarded ) draw_actions( 1, true ); end, GunUtils.deck_from_actions( deck_snapshot ), {}, {} )
							register_action( c )
							SetProjectileConfigs()
						EndTrigger()
					EndProjectile()
					reset_modifiers( c )
					c.lifetime_add = c.lifetime_add + burst_wait * 3
					register_action( c )
					SetProjectileConfigs()

				EndTrigger()
			EndProjectile()
			copi_state.mana_multiplier = copi_state.mana_multiplier / 2.0
			c = old_c
		end
	},
	{
		id                = "COPITH_TRANSMISSION_CAST",
		name              = "$actionname_transmission_cast",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_transmission_cast",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/transmission_cast.png",
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "0,1,2,4,5,6",
		spawn_probability = "0.6,0.6,0.6,0.4,0.4,0.4",
		inject_after      = {"TELEPORT_PROJECTILE", "TELEPORT_PROJECTILE_SHORT", "TELEPORT_PROJECTILE_STATIC", "SWAPPER_PROJECTILE", "TELEPORT_PROJECTILE_CLOSER"},
		price             = 40,
		mana              = 30,
		action = function()
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/transmission_cast.xml,"
			draw_actions(1, true)
		end,
	},
	{
		id                     = "COPITH_CIRCLE_BOOST",
		name                   = "$actionname_circle_boost",
		author                 = "Copi",
		mod                    = "Copi's Things",
		description            = "$actiondesc_circle_boost",
		sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/circle_boost.png",
		sprite_unidentified    = "data/ui_gfx/gun_actions/freeze_unidentified.png",
		related_extra_entities = { "mods/copis_things/files/entities/projectiles/circle_boost.xml" },
		type                   = ACTION_TYPE_STATIC_PROJECTILE,
		spawn_level            = "0,1,2,3",
		spawn_probability      = "1,1,1,1",
		inject_after           = {"BERSERK_FIELD", "POLYMORPH_FIELD", "CHAOS_POLYMORPH_FIELD", "ELECTROCUTION_FIELD", "FREEZE_FIELD", "REGENERATION_FIELD", "TELEPORTATION_FIELD", "LEVITATION_FIELD", "SHIELD_FIELD"},
		price                  = 200,
		mana                   = 30,
		max_uses               = -1,
		action = function()
			if not reflecting then
				add_projectile("mods/copis_things/files/entities/projectiles/circle_boost.xml")
			end
			draw_actions(1, true)
		end
	},
	{
		id                = "COPITH_TELEPORT",
		name              = "$actionname_teleport",
		description       = "$actiondesc_teleport",
		author            = "Copi",
		mod               = "Copi's Things",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/teleport.png",
		type              = ACTION_TYPE_UTILITY,
		spawn_level       = "1, 2, 3, 4, 5, 6",
		spawn_probability = "0.2, 0.2, 0.1,	0.1, 0.1, 0.1",
		price             = 25,
		mana              = 60,
		max_uses          = 5,
		action = function()
			if not reflecting then
				--add_projectile("mods/copis_things/files/entities/projectiles/effect_teleport.xml")
				local shooter = GetUpdatedEntityID()
				if EntityGetIsAlive(shooter) then
					local effect_entity = EntityCreateNew("COPI_TELEPORT_EFFECT")
					EntityAddComponent2(effect_entity, "GameEffectComponent", {
						effect="TELEPORTATION",
						frames=1,
						teleportation_probability=0,
						teleportation_delay_min_frames=0,
						exclusivity_group=42069001,
					})
					EntityAddComponent2(effect_entity, "InheritTransformComponent", {})
					EntityAddChild(shooter, effect_entity)
				end
			end
			c.fire_rate_wait = c.fire_rate_wait + 30
			current_reload_time = current_reload_time + 60
		end
	},
	{	
		id                = "COPITH_TELEPORT_BAD",
		name              = "$actionname_teleport_bad",
		description       = "$actiondesc_teleport_bad",
		author            = "Copi",
		mod               = "Copi's Things",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/teleport_bad.png",
		type              = ACTION_TYPE_UTILITY,
		spawn_level       = "1, 2, 3, 4, 5, 6",
		spawn_probability = "0.2, 0.2, 0.1,	0.1, 0.1, 0.1",
		price             = 25,
		mana              = 59,
		action = function()
			if not reflecting then
				--add_projectile("mods/copis_things/files/entities/projectiles/effect_teleport_bad.xml")
				local shooter = GetUpdatedEntityID()
				if EntityGetIsAlive(shooter) then
					local effect_entity = EntityCreateNew("COPI_TELEPORT_EFFECT")
					EntityAddComponent2(effect_entity, "GameEffectComponent", {
						effect="UNSTABLE_TELEPORTATION",
						frames=1,
						teleportation_probability=0,
						teleportation_delay_min_frames=0,
						exclusivity_group=42069001,
					})
					EntityAddComponent2(effect_entity, "InheritTransformComponent", {})
					EntityAddChild(shooter, effect_entity)
				end
			end
			c.fire_rate_wait = c.fire_rate_wait + 30
			current_reload_time = current_reload_time + 60
		end
	},
	{
		id                = "COPITH_HOMING_BOUNCE",
		name              = "$actionname_homing_bounce",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_homing_bounce",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/homing_bounce.png",
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "1,2,3,4,5,6",
		spawn_probability = "0.5,0.3,0.4,0.5,0.6,0.6",
		inject_after      = {"HOMING", "HOMING_SHORT", "HOMING_ROTATE", "HOMING_SHOOTER", "AUTOAIM", "HOMING_ACCELERATING", "HOMING_CURSOR", "HOMING_AREA"},
		{
			homing = true,
			bounce = true,
		},
		price = 150,
		mana  = 25,
		action = function()
			c.bounces = c.bounces + 3
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/homing_bounce.xml,"
			if not c.extra_entities:find("mods/copis_things/files/entities/misc/bounce_tracker.xml,") then
				c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/bounce_tracker.xml,"
			end
			draw_actions(1, true)
		end
	},
	{
		id                = "COPITH_HOMING_BOUNCE_CURSOR",
		name              = "$actionname_homing_bounce_cursor",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_homing_bounce_cursor",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/homing_bounce_cursor.png",
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "1,2,3,4,5,6",
		spawn_probability = "0.5,0.3,0.4,0.5,0.6,0.6",
		inject_after      = {"HOMING", "HOMING_SHORT", "HOMING_ROTATE", "HOMING_SHOOTER", "AUTOAIM", "HOMING_ACCELERATING", "HOMING_CURSOR", "HOMING_AREA"},
		subtype           = 
			{
				homing = true,
				bounce = true,
			},
		price = 150,
		mana  = 25,
		action = function()
			c.bounces = c.bounces + 3
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/homing_bounce_cursor.xml,"
			if not c.extra_entities:find("mods/copis_things/files/entities/misc/bounce_tracker.xml,") then
				c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/bounce_tracker.xml,"
			end
			draw_actions(1, true)
		end
	},
	{
		id                = "COPITH_HOMING_INTERVAL",
		name              = "$actionname_homing_interval",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_homing_interval",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/homing_interval.png",
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "1,2,3,4,5,6",
		spawn_probability = "0.5,0.3,0.4,0.5,0.6,0.6",
		inject_after      = {"HOMING", "HOMING_SHORT", "HOMING_ROTATE", "HOMING_SHOOTER", "AUTOAIM", "HOMING_ACCELERATING", "HOMING_CURSOR", "HOMING_AREA"},
		subtype           = { homing = true },
		price             = 150,
		mana              = 30,
		action = function()
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/homing_interval.xml,"
			draw_actions(1, true)
		end
	},
	{
		id                = "COPITH_HOMING_MACROSS",
		name              = "$actionname_homing_macross",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_homing_macross",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/homing_macross.png",
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "1,2,3,4,5,6",
		spawn_probability = "0.5,0.3,0.4,0.5,0.6,0.6",
		inject_after      = {"HOMING", "HOMING_SHORT", "HOMING_ROTATE", "HOMING_SHOOTER", "AUTOAIM", "HOMING_ACCELERATING", "HOMING_CURSOR", "HOMING_AREA"},
		subtype           = { homing = true },
		price             = 150,
		mana              = 40,
		action = function()
			c.speed_multiplier = c.speed_multiplier * 0.75
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/homing_macross.xml,"
			draw_actions(1, true)
		end
	},
	{
		--[[
			Credits: 
			Inspiration: Azoth
		]]
		id                = "COPITH_POLYMORPH",
		name              = "$actionname_polymorph",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_polymorph",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/polymorph.png",
		type              = ACTION_TYPE_UTILITY,
		spawn_level       = "1, 2, 3, 4, 5, 6",
		spawn_probability = "0.2, 0.2, 0.1,	0.1, 0.1, 0.1",
		price             = 25,
		mana              = 30,
		action = function()

			if not reflecting then
				local shooter = GetUpdatedEntityID()
				if EntityGetIsAlive(shooter) then
					local effect = GetGameEffectLoadTo( shooter, "POLYMORPH", true )
					if effect ~= nil then ComponentSetValue2( effect, "frames", 600 ) end
				end
			end
			c.fire_rate_wait = c.fire_rate_wait + 30
			current_reload_time = current_reload_time + 60
		end
	},
	{
		--[[
			Credits: 
			Particle: Evaisa
		]]
		id                = "COPITH_SUS_TRAIL",
		name              = "$actionname_sus_trail",
		description       = "$actiondesc_sus_trail",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/sus_trail.png",
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "0,1,2,3,4,5,6",
		spawn_probability = "0.1,0.1,0.3,0.2,0.2,0.2,0.2",
		price             = 10,
		mana              = 0,
		action = function()
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/sus_trail.xml,"
			draw_actions(1, true)
		end,
	},
	{
		id                = "COPITH_MUSIC_PLAYER",
		name              = "$actionname_music_player",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_music_player",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/music_player.png",
		type              = ACTION_TYPE_PASSIVE,
		spawn_level       = "1,2,3,4,5,6",
		spawn_probability = "0.1,0.5,0.5,0.5,0.5,0.5",
		inject_after      = {"TORCH", "TORCH_ELECTRIC"},
		price             = 160,
		mana              = 0,
		custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/music_player.xml",
		action = function()
			draw_actions(1, true)
		end
	},--[[
	{
		id                    = "COPITH_SRS",
		name                  = "Serious Cannonball",
		author                = "Copi",
		mod                   = "Copi's Things",
		description           = "A heavy cannonball which can be charged as you hold fire!",
		sprite                = "mods/copis_things/files/ui_gfx/gun_actions/SRS.png",
		--related_projectiles = { "mods/copis_things/files/entities/projectiles/SRS.xml" },
		type                  = ACTION_TYPE_PROJECTILE,
		spawn_level           = "1,2,3,4,5,6",
		spawn_probability     = "0.6,0.6,0.4,0.2,0.2,0.2",
		price                 = 90,
		mana                  = 40,
		action = function()
			if reflecting then
				Reflection_RegisterProjectile("mods/copis_things/files/entities/projectiles/SRS.xml")
			else
				local found = false
				local player_projs = EntityGetWithTag("player_projectiles") or {}
				for i = 1, #player_projs do
					if EntityGetName(player_projs[i]) == "SRS_handler" then
						local pcomp = EntityGetFirstComponent(player_projs[i], "ProjectileComponent")
						if pcomp then
							local mWhoShot = ComponentGetValue2(pcomp, "mWhoShot")
							if mWhoShot == GetUpdatedEntityID() then
								found = true
								break
							end
						end
					end
				end
				if found then
					BeginProjectile("mods/copis_things/files/entities/projectiles/SRS_booster.xml")
					EndProjectile()
				else
					BeginProjectile("mods/copis_things/files/entities/projectiles/SRS_handler.xml")
						BeginTriggerDeath()
							BeginProjectile("mods/copis_things/files/entities/projectiles/SRS.xml")
							EndProjectile()
							register_action(c)
							SetProjectileConfigs()
						EndTrigger()
					EndProjectile()
				end
			end
			c.fire_rate_wait = c.fire_rate_wait + 12
			current_reload_time = current_reload_time + 12
		end
	},]]
	{
		id                  = "COPITH_GRAPPLING_HOOK",
		name                = "$actionname_grappling_hook",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_grappling_hook",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/grappling_hook.png",
		related_projectiles = { "mods/copis_things/files/entities/projectiles/grappling_hook.xml" },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "0,1,2",
		spawn_probability   = "1,1,0.5",
		inject_after        = {"BULLET", "BULLET_TRIGGER", "BULLET_TIMER"},
		price               = 120,
		mana                = 12,
		action = function()
			add_projectile("mods/copis_things/files/entities/projectiles/grappling_hook.xml")
			c.fire_rate_wait = c.fire_rate_wait + 2
		end
	},
	{
		--[[
			Credits: 
			Inspiration: Shattered Pixel Dungeon
		]]
		id                  = "COPITH_SPECTRAL_HOOK",
		name                = "$actionname_spectral_hook",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_spectral_hook",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/spectral_hook.png",
		related_projectiles = { "mods/copis_things/files/entities/projectiles/spectral_hook.xml" },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "0,1,2,3,4",
		spawn_probability   = "0.2,3,0.3,0.5,1",
		inject_after        = {"COPITH_GRAPPLING_HOOK"},
		price               = 120,
		mana                = 45,
		action = function()
			add_projectile("mods/copis_things/files/entities/projectiles/spectral_hook.xml")
			current_reload_time = current_reload_time + 24
		end
	},
	{
		id                = "COPITH_GRAPPLING_HOOK_SHOT",
		name              = "$actionname_grappling_hook_shot",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_grappling_hook_shot",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/grappling_hook_shot.png",
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "1,2,3",
		spawn_probability = "0.5,0.6,0.7",
		price             = 150,
		mana              = 10,
		action = function()
			if not c.extra_entities:find("mods/copis_things/files/entities/misc/grappling_hook_shot.xml,") then
				c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/grappling_hook_shot.xml,"
			else
				c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/grappling_hook_shot_adder.xml,"
			end
			draw_actions(1, true)
		end
	},
	{
		id                     = "COPITH_CIRCLE_ANCHOR",
		name                   = "$actionname_circle_anchor",
		author                 = "Copi",
		mod                    = "Copi's Things",
		description            = "$actiondesc_circle_anchor",
		sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/circle_anchor.png",
		sprite_unidentified    = "data/ui_gfx/gun_actions/freeze_unidentified.png",
		related_extra_entities = { "mods/copis_things/files/entities/projectiles/circle_anchor.xml" },
		type                   = ACTION_TYPE_STATIC_PROJECTILE,
		spawn_level            = "0,1,2,3",
		spawn_probability      = "0.6,0.6,0.6,0.6",
		inject_after           = {"BERSERK_FIELD", "POLYMORPH_FIELD", "CHAOS_POLYMORPH_FIELD", "ELECTROCUTION_FIELD", "FREEZE_FIELD", "REGENERATION_FIELD", "TELEPORTATION_FIELD", "LEVITATION_FIELD", "SHIELD_FIELD"},
		price                  = 200,
		mana                   = 30,
		max_uses               = -1,
		action = function()
			if not reflecting then
				add_projectile("mods/copis_things/files/entities/projectiles/circle_anchor.xml")
			end
			draw_actions(1, true)
		end
	},--[[ TODO: Orbital Mechanics
	{
		id                     = "COPITH_CIRCLE_ORBIT",
		name                   = "Circle of Cyclicity",
		author                 = "Copi",
		mod                    = "Copi's Things",
		description            = "A field of rotational magic",
		sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/circle_orbit.png",
		sprite_unidentified    = "data/ui_gfx/gun_actions/freeze_unidentified.png",
		related_extra_entities = { "mods/copis_things/files/entities/projectiles/circle_orbit.xml" },
		type                   = ACTION_TYPE_STATIC_PROJECTILE,
		spawn_level            = "0,1,2,3",
		spawn_probability      = "0.6,0.6,0.6,0.6",
		inject_after           = {"BERSERK_FIELD", "POLYMORPH_FIELD", "CHAOS_POLYMORPH_FIELD", "ELECTROCUTION_FIELD", "FREEZE_FIELD", "REGENERATION_FIELD", "TELEPORTATION_FIELD", "LEVITATION_FIELD", "SHIELD_FIELD"},
		price                  = 200,
		mana                   = 30,
		max_uses               = -1,
		action = function()
			if not reflecting then
				add_projectile("mods/copis_things/files/entities/projectiles/circle_orbit.xml")
			end
			draw_actions(1, true)
		end
	},]]
	{
		id                     = "COPITH_GRAPPLING_HOOK_RAY_ENEMY",
		name                   = "$actionname_grappling_hook_ray_enemy",
		author                 = "Copi",
		mod                    = "Copi's Things",
		description            = "$actiondesc_grappling_hook_ray_enemy",
		sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/grappling_hook_ray_enemy.png",
		related_extra_entities = { "mods/copis_things/files/entities/misc/hitfx_grappling_hook_ray_enemy.xml" },
		type                   = ACTION_TYPE_MODIFIER,
		spawn_level            = "1,2,5",
		spawn_probability      = "0.5,0.7,0.5",
		inject_after           = {"FIREBALL_RAY_ENEMY", "LIGHTNING_RAY_ENEMY", "TENTACLE_RAY_ENEMY"},
		price                  = 200,
		mana                   = 30,
		--max_uses             = 20,
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 30
			c.extra_entities =
				c.extra_entities .. "mods/copis_things/files/entities/misc/hitfx_grappling_hook_ray_enemy.xml,"
			draw_actions(1, true)
		end
	},
	{
		id                = "COPITH_ALT_FIRE_GRAPPLING_HOOK",
		name              = "$actionname_alt_fire_grappling_hook",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_alt_fire_grappling_hook",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/alt_fire_grappling_hook.png",
		type              = ACTION_TYPE_PASSIVE,
		spawn_level       = "1,2,3,4,5",
		spawn_probability = "1,0.5,0.2,0.1,0.1",
		price             = 280,
		mana              = 12,
		skip_mana         = true,
		custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/alt_fire_grappling_hook.xml",
		action = function()
			if reflecting then
				Reflection_RegisterProjectile("mods/copis_things/files/entities/projectiles/grappling_hook.xml")
			end
			-- does nothing to the projectiles
			draw_actions(1, true)
		end
	},
	{
		--[[
			Credits: 
			Inspiration: Chemical Curiosities (Chaotic Pandorium)
		]]
		id                     = "COPITH_TRUE_CHAOS_RAY",
		name                   = "$actionname_true_chaos_ray",
		author                 = "Copi",
		mod                    = "Copi's Things",
		description            = "$actiondesc_true_chaos_ray",
		sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/true_chaos_ray.png",
		sprite_unidentified    = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
		related_extra_entities = { "mods/copis_things/files/entities/misc/chaos_ray.xml" },
		type                   = ACTION_TYPE_MODIFIER,
		spawn_level            = "5,6,10",
		spawn_probability      = "0.2,0.2,0.4",
		inject_after           = {"FIREBALL_RAY_LINE"},
		price                  = 300,
		mana                   = 300,
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 30
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/true_chaos_ray.xml,"
			draw_actions(1, true)
		end
	},--[[
	{
		id                  = "COPITH_CHRONO_CALIBER",
		name                = "Chrono Caliber",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "A fast projectile which grows in power the less often it is fired",
		sprite              = "--mods/copis_things/files/ui_gfx/gun_actions/chrono_caliber.png",
		related_projectiles = { "--mods/copis_things/files/entities/projectiles/chrono_caliber.xml" },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "0,1,2",
		spawn_probability   = "2,1,0.5",
		--inject_after      = {"BULLET", "BULLET_TRIGGER", "BULLET_TIMER"},
		price               = 120,
		mana                = 7,
		action = function()
			local projectile = "--mods/copis_things/files/entities/projectiles/chrono_caliber.xml"
			if not reflecting then
				Reflection_RegisterProjectile(projectile)
			else
				local card = GunUtils.current_card()
				if card ~= nil then
					add_projectile("mods/copis_things/files/entities/projectiles/dart.xml")
					c.fire_rate_wait = c.fire_rate_wait + 2
				end
			end
		end
	},]]
	{
		id                     = "COPITH_HITFX_LARPA",
		name                   = "$actionname_hitfx_larpa",
		author                 = "Copi",
		mod                    = "Copi's Things",
		description            = "$actiondesc_hitfx_larpa",
		sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/hitfx_larpa.png",
		sprite_unidentified    = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
		related_extra_entities = { "mods/copis_things/files/entities/misc/hitfx_larpa.xml" },
		type                   = ACTION_TYPE_MODIFIER,
		spawn_level            = "6,10",
		spawn_probability      = "0.2,0.3",
		inject_after           = {"FIREBALL_RAY_LINE"},
		price                  = 300,
		mana                   = 150,
		max_uses               = 3,
		action = function()
			if not current_action then return end
			if current_action.id == "COPITH_HITFX_LARPA" then
				copi_state.mana_multiplier = copi_state.mana_multiplier * 2.0
				c.fire_rate_wait = c.fire_rate_wait + 60
				current_reload_time = current_reload_time + 120
				c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/hitfx_larpa.xml,"
				draw_actions(1, true)
			end
		end
	},
	--[[ TODO: Figure out recast so I can make it drain mana properly, and cost mana and whatnot, and handle card deletions with currentcard change
		-- Worst case; just add slots and move the spells into wand then back out, but this can probably be exploited. Bad idea actually, fuck that
	{
		id                     = "COPITH_INVENTORY_WAND",
		name                   = "Spell Bag",
		author                 = "Copi",
		mod                    = "Copi's Things",
		description            = "Casts every spell from your inventory, in order. Uncopyable.",
		sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/hitfx_larpa.png",
		sprite_unidentified    = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
		related_extra_entities = { "mods/copis_things/files/entities/misc/hitfx_larpa.xml" },
		type                   = ACTION_TYPE_OTHER,
		spawn_level            = "6,10",
		spawn_probability      = "0.1,0.2",
		price                  = 300,
		mana                   = 150,
		max_uses               = 3,
		action = function()
			if current_action.id == "COPITH_INVENTORY_WAND" and not reflecting then
				local caster = GetUpdatedEntityID()
				local children = EntityGetAllChildren(caster) or {}
				local spells = {}
				-- Get spells inventory
				for i=1,#children do
					if (EntityGetName(children[i]) == "inventory_full") then
						local lookup = GunUtils.lookup_spells()
						-- Gather all spells in inventory
						local inventory_items = EntityGetAllChildren(children[i]) or {}
						for j=1,#inventory_items do
							if EntityHasTag(inventory_items[j], "card_action") then
								local iac = EntityGetFirstComponentIncludingDisabled( inventory_items[j], "ItemActionComponent" ) ---@cast iac integer
								local action = lookup[ComponentGetValue2( iac, "action_id" )]
								if action ~= nil then
									action.action()
								end
							end
						end
						break
					end
				end
			end
		end
	},]]
	-- This breaks shit
	-- I only just realized now how much more profanity my mod has since moving on to vD.5 hmmmmmmm...
	-- Must be my decline into madness...
	-- Eh whatever
	--[[{
		id = "COPITH_AFFIX",
		name = "Affix",
		author = "Copi",
		mod = "Copi's Things",
		description = "The fuck does this do",
		sprite = "--mods/copis_things/files/ui_gfx/gun_actions/affix.png",
		related_projectiles = { "mods/copis_things/files/entities/misc/affix.xml" },
		type = ACTION_TYPE_MODIFIER,
		spawn_level = "0,1,2",  -- idk how to balance this shit genuinely PLEASE if you have any degree of a sense of balance help me out with all these spawn probs and levels
		spawn_probability = "1,1,0.5",
		price = 120,
		mana = 0,
		action = function()
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/affix.xml,"
			draw_actions(1, true)
		end
	},]]--[[ THIS SPELL IS A MASSIVE FUCKING BUGGY MESS.]]
	{
		id                = "COPITH_DUPLICATE_ACTION",
		name              = "$actionname_duplicate_action",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_duplicate_action",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/duplicate_action.png",
		type              = ACTION_TYPE_OTHER,
		spawn_level       = "0,1,2,3,4,5,6,10",
		spawn_probability = "0.2,0.3,0.4,0.3,0.2,0.1,0.2,0.5",
		inject_after      = {"DIVIDE_2", "DIVIDE_3", "DIVIDE_4", "DIVIDE_10"},
		price             = 256,
		mana              = 40,
		custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/wandbuilding.xml",
		action = function()
			if not reflecting then
				local drew = deck[1]
				if drew then
					if meta_manager(drew, "COPITH_DUPLICATE_ACTION") then
						local lookup = GunUtils.lookup_spells()
						drew = actions[lookup["COPITH_ACTION_INVERSION"]['index']]
					end
					drew['uses_remaining'] = drew['uses_remaining'] or -1
					hand[#hand] = drew
				end
			end
		end
	},--[[ THIS SPELL IS A MASSIVE FUCKING BUGGY MESS.]]
	{
		id                = "COPITH_SPINDOWN_SPELL",
		name              = "$actionname_spindown_spell",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_spindown_spell",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/spindown_spell.png",
		type              = ACTION_TYPE_OTHER,
		spawn_level       = "0,1,2,3,4,5,6,10",
		spawn_probability = "0.2,0.3,0.4,0.3,0.2,0.1,0.2,0.5",
		inject_after      = {"DIVIDE_2", "DIVIDE_3", "DIVIDE_4", "DIVIDE_10"},
		price             = 256,
		mana              = 40,
		custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/wandbuilding.xml",
		action = function()
			if not reflecting then
				local drew = deck[1]
				if drew then
					if not drew['spun'] then
						local action = nil
						local lookup = GunUtils.lookup_spells()
						if meta_manager(drew, "COPITH_SPINDOWN_SPELL") then
							action = actions[lookup["COPITH_ACTION_INVERSION"]['index']]
						else
							local index	 = lookup[drew['id']]['index']
							local spun	  = ((index-2)%#actions)+1
							action		  = actions[spun]
						end
						if HasFlagPersistent(action.spawn_requires_flag) or action.id == "COPITH_ACTION_INVERSION" then
							deck[1]['id']					= action.id
							deck[1]['uses_remaining']		= math.min(action.max_uses or -1, drew['uses_remaining'] or -1)
							deck[1]['related_projectiles']	= action.related_projectiles
							deck[1]['name']					= action.name
							deck[1]['action']				= action.action
							deck[1]['spun']					= true
						else
							GamePrint("This spell must be unlocked!")
						end
					end
				end
				draw_actions(1, true)
			end
		end
	},--[[ THIS SPELL IS A MASSIVE FUCKING BUGGY MESS.]]
	{
		id                = "COPITH_DUPLICATE_ACTION_2",
		name              = "$actionname_duplicate_action_2",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_duplicate_action_2",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/duplicate_action_2.png",
		type              = ACTION_TYPE_OTHER,
		spawn_level       = "0,1,2,3,4,5,6,10",
		spawn_probability = "0.2,0.3,0.4,0.3,0.2,0.1,0.2,0.5",
		inject_after      = {"DIVIDE_2", "DIVIDE_3", "DIVIDE_4", "DIVIDE_10"},
		price             = 256,
		mana              = 40,
		custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/wandbuilding.xml",
		action = function()
			if (not reflecting) and (not current_action.permanently_attached) then  -- ACs make the game angry I guess
				local drew = deck[1]
				if not drew then return end
				if not drew['duplicate_action_2'] then  -- prevent adding a copy each cast, like the AC refresh exploit
					if meta_manager(drew, "COPITH_DUPLICATE_ACTION_2") then   -- Ignore this part, it's for a little secret when you cast the spell on itself
						local lookup = GunUtils.lookup_spells()
						drew = actions[lookup["COPITH_ACTION_INVERSION"]['index']]
					end
					drew['duplicate_action_2'] = true
					drew['uses_remaining'] = drew['uses_remaining'] or -1
					table.insert(deck, 1, drew)
				end
				draw_actions(1, true)
			end
		end
	},
	{
		id                = "COPITH_DUPLICATE_ACTION_3",
		name              = "$actionname_duplicate_action_3",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_duplicate_action_3",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/duplicate_action_3.png",
		type              = ACTION_TYPE_OTHER,
		spawn_level       = "0,1,2,3,4,5,6,10",
		spawn_probability = "0.2,0.3,0.4,0.3,0.2,0.1,0.2,0.5",
		inject_after      = {"DIVIDE_2", "DIVIDE_3", "DIVIDE_4", "DIVIDE_10"},
		price             = 256,
		mana              = 40,
		custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/wandbuilding.xml",
		action = function()
			if (not reflecting) and (not current_action.permanently_attached) then
				local drew = deck[1]
				if not drew then return end
				if not drew['duplicate_action_3'] then
					if meta_manager(drew, "COPITH_DUPLICATE_ACTION_3") then
						local lookup = GunUtils.lookup_spells()
						drew = actions[lookup["COPITH_ACTION_INVERSION"]['index']]
					end
					drew['duplicate_action_3'] = true
					drew['uses_remaining'] = drew['uses_remaining'] or -1
					for i=1,2 do table.insert(deck, 1, drew) end
				end
				draw_actions(1, true)
			end
		end
	},--[[ THIS SPELL IS A MASSIVE FUCKING BUGGY MESS.]]
	{
		id                = "COPITH_IMPRINT",
		name              = "$actionname_imprint",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_imprint",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/imprint.png",
		type              = ACTION_TYPE_OTHER,
		spawn_level       = "0,1,2,3,4,5,6,10",
		spawn_probability = "0.2,0.3,0.4,0.3,0.2,0.1,0.2,0.5",
		inject_after      = {"DIVIDE_2", "DIVIDE_3", "DIVIDE_4", "DIVIDE_10"},
		price             = 256,
		mana              = 40,
		custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/wandbuilding.xml",
		action = function()
			-- this WILL break lol lmao
			if not reflecting then
				local drew = deck[1]
				if drew then
					if not drew['spun'] then
						local action = nil
						if meta_manager(drew, "COPITH_IMPRINT") then   -- Ignore this part, it's for a little secret when you cast the spell on itself
							local lookup = GunUtils.lookup_spells()
							action = actions[lookup["COPITH_ACTION_INVERSION"]['index']]
						else
							local iter = tonumber(GlobalsGetValue( "fungal_shift_iteration", "0" )) or 0
							local id_sum = 0
							for i=1,drew['id']:len() do
								id_sum = id_sum + drew['id']:sub(i,i):byte()
							end

							-- Action is determined by drew action id and fungal shift iteration, so you can trip balls to shuffle your imprints
							SetRandomSeed(id_sum, iter)
							action = actions[Random(1,#actions)]
						end
						if HasFlagPersistent(action.spawn_requires_flag) or action.id == "COPITH_ACTION_INVERSION" then
							deck[1]['id']					= action.id
							deck[1]['uses_remaining']		= math.min(action.max_uses or -1, drew['uses_remaining'] or -1)
							deck[1]['related_projectiles']	= action.related_projectiles
							deck[1]['name']					= action.name
							deck[1]['action']				= action.action
							deck[1]['spun']					= true
						else
							GamePrint("This spell must be unlocked!")
						end
					end
				end
				draw_actions(1, true)
			end
		end
	},--[[ THIS SPELL IS A MASSIVE FUCKING BUGGY MESS.]]
	{
		id                  = "COPITH_ACTION_INVERSION",
		name                = "$actionname_action_inversion",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_action_inversion",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/action_inversion.png",
		type                = ACTION_TYPE_OTHER,
		spawn_level         = "0,1,2,3,4,5,6,10",
		spawn_probability   = "0.2,0.3,0.4,0.3,0.2,0.1,0.2,0.5",
		inject_after        = {"DIVIDE_2", "DIVIDE_3", "DIVIDE_4", "DIVIDE_10"},
		spawn_requires_flag = "copis_things_meta_spell_action",
		price               = 256,
		mana                = 5,
		custom_xml_file     = "mods/copis_things/files/entities/misc/custom_cards/wandbuilding.xml",
		action = function()
			-- this spell was a fucking multi hour migraine marathon. fuck. probably not even worth the effort too.
			-- I pray this works. Have spent literally all day working on it.
			if not reflecting then
				local drew = deck[1]
				if drew then
					meta_manager(drew, "COPITH_ACTION_INVERSION")

					-- Discard the next spell
					table.insert( discarded, table.remove( deck, 1 ) )
					local lookup	= GunUtils.lookup_spells()
					local index		= lookup[drew['id']]['index']
					local action	= actions[index]
					local c_mod		= {}
					local c_old		= c

					c = {}
					reset_modifiers(c)
					-- arbitrary trigger meant to never collide, to separate c and prevent projectile creation, only to evaluate c
					BeginProjectile("mods/copis_things/files/entities/projectiles/separator_cast.xml")
						BeginTriggerHitWorld()

							-- 10/29/24 Copi:
							-- Experimenting with unshackling this a little at the reccomendation of Noby, if this causes the mod to get FUBAR I can revert it

							--[[GunUtils.temporary_deck(
								-- func run on the deck
								function( deck, hand, discarded )

									for key, value in pairs(c_old) do
										c[key] = value
									end

									-- invert mana cost
									copi_state.mana_multiplier = copi_state.mana_multiplier * -1
									-- prevent drawing
									force_stop_draws = true
									dont_draw_actions = true
									draw_action(true)
									c_mod = c
									dont_draw_actions = false
									copi_state.mana_multiplier = copi_state.mana_multiplier * -1
								end,
								-- hand, deck, discard
								GunUtils.deck_from_actions( {action} ),
								{},
								{}
							)]]

							
							
							for key, value in pairs(c_old) do
								c[key] = value
							end

							-- invert mana cost
							copi_state.mana_multiplier = copi_state.mana_multiplier * -1
							-- prevent drawing
							force_stop_draws  = true
							dont_draw_actions = true
							draw_action(true)
							c_mod                      = c
							dont_draw_actions          = false
							copi_state.mana_multiplier = copi_state.mana_multiplier * -1

						EndTrigger()
					EndProjectile()

					c = c_old

					-- undo c delta (number and bool)
					for key, value in pairs(c) do
						local  t     = type(value)
						if     t    == "number" then
						c     [key]  = c[key] + (c[key] - c_mod[key])
						elseif t    == "boolean" then
						c     [key]  = c[key] and not c_mod[key]
						elseif key  == "extra_entities" then
							-- remove extra entities
							for seg in string.gmatch(c_mod['extra_entities'], "([^,]+)[,$]") do
								c['extra_entities'] = c['extra_entities']:gsub((seg..","), '', 1)
							end
						end
					end

				end
				draw_actions(1, true)
			end
		end
	},
	{
		id                = "COPITH_BALANCE",
		name              = "$actionname_balance",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_balance",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/balance.png",
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "1,2,3,4,5,6",
		spawn_probability = "0.8,0.8,0.8,0.8,0.8,0.8",
		inject_after      = {"RECHARGE"},
		price             = 220,
		mana              = 5,
		action = function()
			local avg = (c.fire_rate_wait+current_reload_time)/2
			c.fire_rate_wait = avg
			current_reload_time = avg
			draw_actions(1, true)
		end,
	},
	{
		id                = "COPITH_ZENITH_DISC",
		name              = "$actionname_zenith_disc",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "Summons a no-nonsense sawblade.",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/zenith_disc.png",
		type              = ACTION_TYPE_PROJECTILE,
		spawn_level       = "6,10",
		spawn_probability = "0.2,0.2",
		inject_after      = {"DISC_BULLET", "DISC_BULLET_BIG", "DISC_BULLET_BIGGER"},
		price             = 100,
		mana              = 140,
		action = function()
			c.spread_degrees = c.spread_degrees + 5.0
			add_projectile("mods/copis_things/files/entities/projectiles/zenith_disc.xml")
		end
	},
	{
		id                  = "COPITH_GILDED_AXE",
		name                = "$actionname_gilded_axe",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_gilded_axe",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/gilded_axe.png",
		related_projectiles = { "mods/copis_things/files/entities/projectiles/gilded_axe.xml" },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "0,1,2,3,4",                                                       -- THIS IS IN URGENT NEED OF BALANCING.
		spawn_probability   = "2,1,0.5,0.5,0.5",                                                 -- THIS IS IN URGENT NEED OF BALANCING.
		inject_after        = {"DISC_BULLET", "DISC_BULLET_BIG", "DISC_BULLET_BIGGER"},
		price               = 120,
		mana                = 20,
		action = function()
			add_projectile("mods/copis_things/files/entities/projectiles/gilded_axe.xml")
			c.fire_rate_wait = c.fire_rate_wait + 4
			current_reload_time = current_reload_time + 12
		end
	},
	{
		id                  = "COPITH_STARLIGHT_AXE",
		name                = "$actionname_starlight_axe",
		description         = "$actiondesc_starlight_axe",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/starlight_axe.png",
		author              = "Copi",
		mod                 = "Copi's Things",
		related_projectiles = { "mods/copis_things/files/entities/projectiles/starlight_axe.xml" },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "0,1,2,3,4",                                                          -- THIS IS IN URGENT NEED OF BALANCING.
		spawn_probability   = "2,2,0.5,0.5,0.5",                                                    -- THIS IS IN URGENT NEED OF BALANCING.
		inject_after        = {"DISC_BULLET", "DISC_BULLET_BIG", "DISC_BULLET_BIGGER"},
		price               = 120,
		mana                = 35,
		action =				function()
			add_projectile("mods/copis_things/files/entities/projectiles/starlight_axe.xml")
			c.fire_rate_wait = c.fire_rate_wait + 8
			current_reload_time = current_reload_time + 24
		end
	},
	--[[
		I wanted to add a special case where it's added to projectiles with damagemodels like fish and pollen, but that's too much work
	]]
	{
		id                = "COPITH_TRIGGER_DAMAGE_RECEIVED",
		name              = "$actionname_trigger_damage_received",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_trigger_damage_received",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/trigger_damage_received.png",
		type              = ACTION_TYPE_OTHER,
		spawn_level       = "0,1,2,3,4,5",                                                            -- THIS IS IN URGENT NEED OF BALANCING.
		spawn_probability = "0.5,0.3,0.5,0.2,0.1,0.1",                                                -- THIS IS IN URGENT NEED OF BALANCING.
		price             = 130,
		mana              = -10,
		action = function()
			-- Only run post-init and if there's something to catch
			if not reflecting and deck[1] then
				-- Attempt to add damage taken checker if non existent
				local shooter = GetUpdatedEntityID()
				local luacs = EntityGetComponent(shooter, "LuaComponent") or {}
				local found = false
				local path = "mods/copis_things/files/scripts/projectiles/trigger_damage_received.lua"
				for i=1, #luacs do
					if ComponentGetValue2(luacs[i], "script_damage_received") == path then
						found = true
						break
					end
				end
				if not found then
					EntityAddComponent2( shooter, "LuaComponent", { script_damage_received = path, })
				end

				-- Separate cast to negate modifiers
				BeginProjectile( "mods/copis_things/files/entities/projectiles/trigger_projectile.xml" )
					BeginTriggerDeath()
						-- This does the magic
						BeginProjectile( "mods/copis_things/files/entities/projectiles/trigger_damage_received.xml" )
							BeginTriggerDeath()
								-- The shot to fire from within
								draw_shot(create_shot(1), true)
							EndTrigger()
						EndProjectile()
					EndTrigger()
				EndProjectile()
			end
			c.fire_rate_wait = c.fire_rate_wait + 40
		end
	},--[[
	{
		id                = "COPITH_REVENGE_RECHARGE",
		name              = "$actionname_revenge_recharge",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_revenge_recharge",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/revenge_recharge.png",
		type              = ACTION_TYPE_PASSIVE,
		spawn_level       = "1,2,3,4,5,6",                                                             -- URGENTLY NEEDS REBALANCING
		spawn_probability = "0.5,0.2,0.2,0.2,0.1,0.1",                                                 -- URGENTLY NEEDS REBALANCING
		price             = 200,
		mana              = 0,
		custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/revenge_recharge.xml",
		action = function()
			draw_actions(1, true)
		end
	},]]
	-- I'd make this reel enemies through portals, but that's too much effort for now
	{
		id                  = "COPITH_RIPHOOK",
		name                = "$actionname_riphook",
		description         = "$actiondesc_riphook",
		author              = "Copi",
		mod                 = "Copi's Things",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/riphook.png",
		related_projectiles = { "mods/copis_things/files/entities/projectiles/riphook.xml" },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "0,1,2",                                                        -- idk how to balance this shit genuinely PLEASE if you have any degree of a sense of balance help me out with all these spawn probs and levels
		spawn_probability   = "1,1,0.5",
		inject_after        = {"BULLET", "BULLET_TRIGGER", "BULLET_TIMER"},
		price               = 120,
		mana                = 35,
		action = function()
			add_projectile("mods/copis_things/files/entities/projectiles/riphook.xml")
			c.fire_rate_wait = c.fire_rate_wait + 2
		end
	},
	{
		id                = "COPITH_ALT_FIRE_RIPHOOK",
		name              = "$actionname_alt_fire_riphook",
		description       = "$actiondesc_alt_fire_riphook",
		author            = "Copi",
		mod               = "Copi's Things",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/alt_fire_riphook.png",
		type              = ACTION_TYPE_PASSIVE,
		spawn_level       = "0,1,2",                                                                   -- idk how to balance this shit genuinely PLEASE if you have any degree of a sense of balance help me out with all these spawn probs and levels
		spawn_probability = "1,1,0.5",
		price             = 280,
		mana              = 35,
		skip_mana         = true,
		custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/alt_fire_riphook.xml",
		action = function()
			if reflecting then
				Reflection_RegisterProjectile("mods/copis_things/files/entities/projectiles/riphook.xml")
			end
			-- does nothing to the projectiles
			draw_actions(1, true)
		end
	},
	{
		id                     = "COPITH_FIRESPHERE",
		name                   = "$actionname_firesphere",
		author                 = "Copi",
		mod                    = "Copi's Things",
		description            = "$actiondesc_firesphere",
		sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/firesphere.png",
		sprite_unidentified    = "data/ui_gfx/gun_actions/freeze_unidentified.png",
		related_extra_entities = { "mods/copis_things/files/entities/projectiles/firesphere.xml" },
		type                   = ACTION_TYPE_STATIC_PROJECTILE,
		spawn_level            = "2,3,4",
		spawn_probability      = "1,0.8,0.6",
		price                  = 200,
		mana                   = 60,
		max_uses               = -1,
		action = function()
			add_projectile("mods/copis_things/files/entities/projectiles/firesphere.xml")
			draw_actions(1, true)
			c.fire_rate_wait = c.fire_rate_wait + 30
			current_reload_time = current_reload_time + 15
		end
	},
	{
		id                = "COPITH_ALT_FIRE_BOMB",
		name              = "$actionname_alt_fire_bomb",
		description       = "$actiondesc_alt_fire_bomb",
		author            = "Copi",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/alt_fire_bomb.png",
		type              = ACTION_TYPE_PASSIVE,
		spawn_level       = "0,1,2,3,4,5,6",
		spawn_probability = "1,1,1,1,1,1,1",
		price             = 250,
		mana              = 25,
		skip_mana         = true,
		max_uses          = 3,
		custom_uses_logic = true,
		custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/alt_fire_bomb.xml",
		action = function()
			draw_actions(1, true)
		end
	},--[[ THIS SPELL IS A MASSIVE FUCKING BUGGY MESS.]]
	{
		id                = "COPITH_LOOP_CAST",
		name              = "$actionname_loop_cast",
		description       = "$actiondesc_loop_cast",
		author            = "Copi",
		mod               = "Copi's Things",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/loop_cast.png",
		type              = ACTION_TYPE_OTHER,
		spawn_level       = "0,1,2,3,4,5,6,10",
		spawn_probability = "0.1,0.1,0.2,0.2,0.2,0.1,0.2,0.4",
		inject_after      = {"DIVIDE_2", "DIVIDE_3", "DIVIDE_4", "DIVIDE_10"},
		price             = 256,
		mana              = 40,
		custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/wandbuilding.xml",
		action = function()
			current_reload_time = current_reload_time + 12
			c.fire_rate_wait	= c.fire_rate_wait + 12
			if reflecting then
				draw_actions(1, true)
				return
			end
			if #deck > 0 then
				local kill_signal = false
				local deck_snapshot = peek_draw_actions( 1, true )
				for i=1, gun.deck_capacity do
					GunUtils.temporary_deck(
						function( deck, hand, discarded )
							local a = draw_action
							draw_action = function (...)
								local success = a(...)
								if not success then kill_signal = true end
								return success
							end
							draw_actions( 1, true )
							draw_action = a
						end,
						GunUtils.deck_from_actions( deck_snapshot ), {}, {}
					)
					if kill_signal then break end
				end
			end
		end
	},--[[ cant figure out the silly spell 
	{
		id                = "COPITH_FLIP_EVERY_OTHER",
		name              = "$actionname_flip_every_other",
		description       = "$actiondesc_flip_every_other",
		author            = "Copi",
		mod               = "Copi's Things",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/flip_every_other.png",
		type              = ACTION_TYPE_PASSIVE,
		spawn_level       = "0,1,2,3,4",                                                               -- URGENTLY NEEDS REBALANCING
		spawn_probability = "0.5,0.5,0.5,0.5,0.5",                                                     -- URGENTLY NEEDS REBALANCING
		inject_after      = {"DIVIDE_2", "DIVIDE_3", "DIVIDE_4", "DIVIDE_10"},
		price             = 256,
		mana              = 0,
		custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/flip_every_other.xml",
		action = function()
			draw_actions(1, true)
		end
	},]]--[[ cant make this look right
	{
		id                  = "COPITH_CRIMSON_DAGGER",
		name                = "$actionname_crimson_dagger",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_crimson_dagger",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/crimson_dagger.png",
		related_projectiles = { "mods/copis_things/files/entities/projectiles/crimson_dagger.xml" },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "0,1,2,3,4",                                                           -- THIS IS IN URGENT NEED OF BALANCING.
		spawn_probability   = "2,1,0.5,0.5,0.5",                                                     -- THIS IS IN URGENT NEED OF BALANCING.
		inject_after        = {"DISC_BULLET", "DISC_BULLET_BIG", "DISC_BULLET_BIGGER"},
		price               = 120,
		mana                = 20,
		action              = function()
			add_projectile("mods/copis_things/files/entities/projectiles/crimson_dagger.xml")
			c.fire_rate_wait = c.fire_rate_wait + 4
			current_reload_time = current_reload_time + 12
		end
	},]]
	{
		id                  = "COPITH_ICE_CUBE",
		name                = "$actionname_ice_cube",
		description         = "$actiondesc_ice_cube",
		author              = "Copi",
		mod                 = "Copi's Things",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/ice_cube.png",
		related_projectiles = { "mods/copis_things/files/entities/projectiles/ice_cube.xml" },
		type                = ACTION_TYPE_STATIC_PROJECTILE,
		spawn_level         = "2,3,4,5",                                                       -- SUMMON_ROCK
		spawn_probability   = "0.3,0.5,0.5,0.1",                                               -- SUMMON_ROCK
		price               = 227,
		mana                = 50,
		max_uses            = 25,
		action              = function()
			add_projectile("mods/copis_things/files/entities/projectiles/ice_cube.xml")
			c.fire_rate_wait = c.fire_rate_wait + 45
		end
	},
	{
		id                = "COPITH_MANA_DELTA",
		name              = "$actionname_mana_delta",
		description       = "$actiondesc_mana_delta",
		author            = "Copi",
		mod               = "Copi's Things",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/mana_delta.png",
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "1,2,3,4,5,6",
		spawn_probability = "0.2,0.2,0.8,0.3,0.4,0.5",
		inject_after      = {"MANA_REDUCE"},
		price             = 220,
		mana              = -120,
		skip_mana         = true,
		action              = function()
			current_reload_time = current_reload_time + 15
			if not reflecting then
				local delta = math.min(120, (GameGetFrameNum() - (LastShootingStart or 0)) * 2)
				mana = mana + delta
				draw_actions(1, true)
				LastShootingStart = GameGetFrameNum()
			end
		end,
	},
	{
		id                  = "COPITH_PAIN_RAY",
		name                = "$actionname_pain_ray",
		description         = "$actiondesc_pain_ray",
		author              = "Copi",
		mod                 = "Copi's Things",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/pain_ray.png",
		related_projectiles = { "mods/copis_things/files/entities/projectiles/pain_ray.xml" },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "1,2,3,4",                                                       -- SUMMON_ROCK
		spawn_probability   = "0.8,1,0.5,0.5",                                                 -- SUMMON_ROCK
		price               = 100,
		mana                = 50,
		action              = function()
			if not reflecting then
				add_projectile("mods/copis_things/files/entities/projectiles/pain_ray.xml")
			end
			c.fire_rate_wait = c.fire_rate_wait + 30
			current_reload_time = current_reload_time + 30
		end
	},
	{
		id                  = "COPITH_HOLY_RAY",
		name                = "$actionname_holy_ray",
		description         = "$actiondesc_holy_ray",
		author              = "Copi",
		mod                 = "Copi's Things",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/holy_ray.png",
		related_projectiles = { "mods/copis_things/files/entities/projectiles/holy_ray.xml" },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "2,3,4,5",
		spawn_probability   = "0.2,0.75,0.5,0.5",
		price               = 100,
		mana                = 50,
		action = function()
			add_projectile("mods/copis_things/files/entities/projectiles/holy_ray.xml")
			c.fire_rate_wait = c.fire_rate_wait + 60
			current_reload_time = current_reload_time + 15
		end
	},
	{
		id                  = "COPITH_INFERNAL_STREAK",
		name                = "$actionname_infernal_streak",
		description         = "$actiondesc_infernal_streak",
		author              = "Copi",
		mod                 = "Copi's Things",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/infernal_streak.png",
		related_projectiles = { "mods/copis_things/files/entities/projectiles/infernal_streak.xml" },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "1,2,3,4",                                                              -- SUMMON_ROCK
		spawn_probability   = "0.8,1,0.5,0.5",                                                        -- SUMMON_ROCK
		price               = 100,
		mana                = 50,
		action              = function()
			add_projectile("mods/copis_things/files/entities/projectiles/infernal_streak.xml")
			c.fire_rate_wait = c.fire_rate_wait + 60
			current_reload_time = current_reload_time + 15
		end
	},
	{	
		--[[
			Credits: 
			Concept: Conga Lyne
		]]
		id                = "COPITH_AVERAGE_MANA",
		name              = "$actionname_average_mana",
		description       = "$actiondesc_average_mana",
		author            = "Copi",
		mod               = "Copi's Things",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/average_mana.png",
		type              = ACTION_TYPE_PASSIVE,
		spawn_level       = "0,1,2,3,4",                                                           -- URGENTLY NEEDS REBALANCING
		spawn_probability = "0.5,0.5,0.5,0.5,0.5",                                                 -- URGENTLY NEEDS REBALANCING
		price             = 256,
		mana              = 0,
		custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/average_mana.xml",
		action            = function()
			draw_actions(1, true)
		end
	},
	{
		id                = "COPITH_AMMO_BOX",
		name              = "$actionname_ammo_box",
		description       = "$actiondesc_ammo_box",
		author            = "Copi",
		mod               = "Copi's Things",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/ammo_box.png",
		type              = ACTION_TYPE_PASSIVE,
		spawn_level       = "0,1,2,3,4",                                                       -- URGENTLY NEEDS REBALANCING
		spawn_probability = "0.5,0.5,0.5,0.5,0.5",                                             -- URGENTLY NEEDS REBALANCING
		price             = 256,
		mana              = 0,
		max_uses          = 25,
		custom_uses_logic = true,
		custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/ammo_box.xml",
		action            = function()
			draw_actions(1, true)
		end
	},
	{
		id                = "COPITH_AMMO_FROM_HP",
		name              = "$actionname_ammo_from_hp",
		description       = "$actiondesc_ammo_from_hp",
		author            = "Copi",
		mod               = "Copi's Things",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/ammo_from_hp.png",
		type              = ACTION_TYPE_PASSIVE,
		spawn_level       = "0,1,2,3,4",                                                           -- URGENTLY NEEDS REBALANCING
		spawn_probability = "0.5,0.5,0.5,0.5,0.5",                                                 -- URGENTLY NEEDS REBALANCING
		price             = 256,
		mana              = 0,
		custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/ammo_from_hp.xml",
		action            = function()
			draw_actions(1, true)
		end
	},
	--[[{
		id                     = "COPITH_LARPA_BUT_GOOD",
		name                   = "$actionname_larpa_but_good",
		description            = "$actiondesc_larpa_but_good",
		author                 = "Copi",
		mod                    = "Copi's Things",
		sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/larpa_but_good.png",
		related_extra_entities = { "mods/copis_things/files/entities/misc/larpa_but_good.xml" },
		type                   = ACTION_TYPE_MODIFIER,
		spawn_level            = "2,3,4,5,10",
		spawn_probability      = "0.1,0.2,0.3,0.4,0.2",
		inject_after           = {"LARPA_CHAOS", "LARPA_DOWNWARDS", "LARPA_UPWARDS", "LARPA_CHAOS_2", "LARPA_DEATH"},
		price                  = 260,
		mana                   = 100,
		--max_uses             = 20,
		action                 = function()
		c.fire_rate_wait       = c.fire_rate_wait + 15
		current_reload_time    = current_reload_time + 30
		c.extra_entities       = c.extra_entities .. "mods/copis_things/files/entities/misc/larpa_but_good.xml,"
			draw_actions(1, true)
		end
	},]]
	{
		id                = "COPITH_GATE_MANA",
		name              = "$actionname_gate_mana",
		description       = "$actiondesc_gate_mana",
		author            = "Copi",
		mod               = "Copi's Things",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/gate_mana.png",
		type              = ACTION_TYPE_OTHER,
		spawn_level       = "0,1,2,3,4,5,6,10",
		spawn_probability = "0.2,0.3,0.4,0.3,0.2,0.1,0.2,0.5",
		price             = 256,
		mana              = 0,
		action            = function()
			---@diagnostic disable-next-line: lowercase-global
			if not reflecting then
				local this_wand = GunUtils.current_wand(GetUpdatedEntityID())
				local ability = EntityGetFirstComponentIncludingDisabled(this_wand, "AbilityComponent")	--[[@cast ability integer]]
				local mana_max = ComponentGetValue2(ability, "mana_max")
				if mana < mana_max then
					current_reload_time = 0
					for i=1,#hand do discarded[#discarded+1] = hand[i] end hand = {}
					for i=1,#deck do discarded[#discarded+1] = deck[i] end deck = {}
					if not force_stop_draws then
						force_stop_draws = true
						move_discarded_to_deck()
						order_deck()
					end
				else
					draw_actions(1, true)
				end
			end
		end
	},
	{
		id                = "COPITH_GATE_HP",
		name              = "$actionname_gate_hp",
		description       = "$actiondesc_gate_hp",
		author            = "Copi",
		mod               = "Copi's Things",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/gate_hp.png",
		type              = ACTION_TYPE_OTHER,
		spawn_level       = "0,1,2,3,4,5,6,10",
		spawn_probability = "0.2,0.3,0.4,0.3,0.2,0.1,0.2,0.4",
		price             = 256,
		mana              = 0,
		custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/wandbuilding.xml",
		action            = function()
			---@diagnostic disable-next-line: lowercase-global
			if not reflecting then
				local shooter = GetUpdatedEntityID()
				local dmc = EntityGetFirstComponent(shooter, "DamageModelComponent")	--[[@cast dmc number]]
				local hp = ComponentGetValue2(dmc, "hp")
				local max_hp = ComponentGetValue2(dmc, "max_hp")
				if hp < max_hp/4 then
					current_reload_time = 0
					for i=1,#hand do discarded[#discarded+1] = hand[i] end hand = {}
					for i=1,#deck do discarded[#discarded+1] = deck[i] end deck = {}
					if not force_stop_draws then
						force_stop_draws = true
						move_discarded_to_deck()
						order_deck()
					end
				else
					draw_actions(1, true)
				end
			end
		end
	},
	{
		--[[
			Credits: 
			Inspiration: Dungeons and Dragons 5e
		]]
		id                = "COPITH_GLYPH_OF_BULLSHIT",
		name              = "$actionname_glyph_of_bullshit",
		author            = "Copi",
		mod               = "Copi's Things",
		description       = "$actiondesc_glyph_of_bullshit",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/glyph_of_bullshit_t.png",
		type              = ACTION_TYPE_OTHER,
		spawn_level       = "0,1,2,3,4,5",                                                         -- THIS IS IN URGENT NEED OF BALANCING.
		spawn_probability = "0.5,0.3,0.5,0.2,0.1,0.1",                                             -- THIS IS IN URGENT NEED OF BALANCING.
		price             = 130,
		mana              = 15,
		custom_xml_file   = "mods/copis_things/files/entities/misc/custom_cards/wandbuilding.xml",
		action            = function()
			if reflecting then
				Reflection_RegisterProjectile("mods/copis_things/files/entities/projectiles/glyph_of_bullshit_explosion.xml")
			else
				local capture = deck[1]
				-- Separate cast to negate modifiers
				BeginProjectile( "mods/copis_things/files/entities/projectiles/trigger_projectile.xml" )
					BeginTriggerDeath()
						-- This does the magic
						BeginProjectile( "mods/copis_things/files/entities/projectiles/glyph_of_bullshit.xml" )
							BeginTriggerHitWorld()
								if not capture then
									add_projectile("mods/copis_things/files/entities/projectiles/glyph_of_bullshit_explosion.xml")
								else
									-- The shot to fire from within
									draw_shot(create_shot(1), true)
								end
							EndTrigger()
						EndProjectile()
					EndTrigger()
				EndProjectile()
				c.fire_rate_wait = c.fire_rate_wait + 40
			end
		end
	},--[[ woe be upon ye
	{
		id                = "COPITH_SILENCER",
		name              = "$actionname_silencer",
		description       = "$actiondesc_silencer",
		author            = "Copi",
		mod               = "Copi's Things",
		sprite            = "mods/copis_things/files/ui_gfx/gun_actions/silencer.png",
		type              = ACTION_TYPE_MODIFIER,
		spawn_level       = "1,2,3,4,5,6",                                             -- THIS IS IN URGENT NEED OF BALANCING.
		spawn_probability = "0.2,0.2,0.4,0.2,0.2,0.2",                                 -- THIS IS IN URGENT NEED OF BALANCING.
		price             = 25,
		mana              = 0,
		action             = function()
		c.extra_entities   = c.extra_entities .. "mods/copis_things/files/entities/misc/silencer.xml,"
		c.fire_rate_wait   = c.fire_rate_wait - 8
		c.speed_multiplier = c.speed_multiplier * 1.2
		c.screenshake      = math.max(0, c.screenshake - 2.5)
			draw_actions( 1, true )
		end
	},]]
	--[[
	{
		id                  = "COPITH_LIGHT_BULLET_WITH_AMNESIA",
		name                = "$actionname_light_bullet_with_amnesia",
		description         = "$actiondesc_light_bullet_with_amnesia",
		author              = "Copi",
		mod                 = "Copi's Things",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/light_bullet_with_amnesia.png",
		related_projectiles = { "mods/copis_things/files/entities/projectiles/infernal_streak.xml" },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "1,2,3,4",                                                                  -- SUMMON_ROCK
		spawn_probability   = "0.8,1,0.5,0.5",                                                            -- SUMMON_ROCK
		price               = 100,
		mana                = 50,
		action              = function()
			add_projectile("mods/copis_things/files/entities/projectiles/infernal_streak.xml")
			c.fire_rate_wait = c.fire_rate_wait + 60
			current_reload_time = current_reload_time + 15
		end
	},]]
	{
		--[[
			Credits: 
			Inspiration: Risk of Rain 2
		]]
		id                     = "COPITH_ROR2COLLAPSE",
		name                   = "$actionname_ror2collapse",
		author                 = "Copi",
		mod                    = "Copi's Things",
		description            = "$actiondesc_ror2collapse",
		sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/ror2collapse.png",
		sprite_unidentified    = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
		related_extra_entities = { "mods/copis_things/files/entities/misc/hitfx_collapse.xml" },
		type                   = ACTION_TYPE_MODIFIER,
		spawn_level            = "2,3,4",
		spawn_probability      = "0.6,0.3,0.4",
		inject_after           = {"FIREBALL_RAY_LINE"},
		price                  = 300,
		mana                   = 10,
		action                 = function()
			c.fire_rate_wait = c.fire_rate_wait + 12
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/hitfx_collapse.xml,"
			draw_actions(1, true)
		end
	},
	{
		id                     = "COPITH_REDIRECT_THIS",
		name                   = "$actionname_redirect_this",
		description            = "$actiondesc_redirect_this",
		author                 = "Copi",
		mod                    = "Copi's Things",
		sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/redirect_this.png",
		sprite_unidentified    = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
		related_extra_entities = { "mods/copis_things/files/entities/misc/redirect_this.xml" },
		type                   = ACTION_TYPE_MODIFIER,
		spawn_level            = "0,1,2,3",
		spawn_probability      = "0.2,0.3,0.4,0.2",
		price                  = 60,
		mana                   = 5,
		action                 = function()
		c.fire_rate_wait = c.fire_rate_wait + 12
		c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/redirect_this.xml,"
			draw_actions(1, true)
		end
	},
	{
		id                     = "COPITH_REDIRECT_THIS_RARE",
		name                   = "$actionname_redirect_this_rare",
		description            = "$actiondesc_redirect_this_rare",
		author                 = "Copi",
		mod                    = "Copi's Things",
		sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/redirect_this_rare.png",
		sprite_unidentified    = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
		related_extra_entities = { "mods/copis_things/files/entities/misc/redirect_this_rare.xml" },
		type                   = ACTION_TYPE_MODIFIER,
		spawn_level            = "1,2,3",
		spawn_probability      = "0.1,0.05,0.05",
		price                  = 80,
		mana                   = 20,
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 24
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/redirect_this_rare.xml,"
			draw_actions(1, true)
		end
	},
	{
		id                  = "COPITH_HYDROJET",
		name                = "$actionname_hydrojet",
		author              = "Copi",
		mod                 = "Copi's Things",
		description         = "$actiondesc_hydrojet",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/hydrojet.png",
		related_projectiles = { "mods/copis_things/files/entities/projectiles/hydrojet.xml" },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "0,1,2",
		spawn_probability   = "0.35,0.25,0.25",
		price               = 120,
		mana                = 6,
		action = function()
			add_projectile("mods/copis_things/files/entities/projectiles/hydrojet.xml")
			c.speed_multiplier = c.speed_multiplier * 1.1
			c.fire_rate_wait = c.fire_rate_wait - 14
			draw_actions(1, true)
		end
	},
	{
		id                  = "COPITH_VILE_EYE",
		name                = "$actionname_vile_eye",
		description         = "$actiondesc_vile_eye",
		author              = "Copi",
		mod                 = "Copi's Things",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/vile_eye.png",
		related_projectiles = { "mods/copis_things/files/entities/projectiles/vile_eye.xml" },
		type                = ACTION_TYPE_OTHER,
		spawn_level         = "0,4,5,10",
		spawn_probability   = "0.01,0.25,0.25,0.25",
		price               = 120,
		mana                = 50,
		action = function()
			local entity_id = GetUpdatedEntityID()
			local dmc = EntityGetFirstComponent( entity_id, "DamageModelComponent" )
			if dmc then
				local hp = ComponentGetValue2( dmc, "hp" )
				if hp > 0.24 then
					ComponentSetValue2( dmc, "hp", hp - 0.2 )
					add_projectile("mods/copis_things/files/entities/projectiles/vile_eye.xml")
					c.fire_rate_wait = c.fire_rate_wait + 32
					current_reload_time = current_reload_time + 32
				end
			end
		end
	},
	{
		id                  = "COPITH_BOMB_SMALL",
		name                = "$actionname_bomb_small",
		description         = "$actiondesc_bomb_small",
		author              = "Copi",
		mod                 = "Copi's Things",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/bomb_small.png",
		related_projectiles = { "mods/copis_things/files/entities/projectiles/bomb_small.xml" },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "0,1,2,3,4,5,6",
		spawn_probability   = "0.5,0.2,0.2,0.2,0.25,0.25,0.1",
		price               = 120,
		mana                = 15,
		max_uses            = 7,
		action = function()
			add_projectile("mods/copis_things/files/entities/projectiles/bomb_small.xml")
			add_projectile("mods/copis_things/files/entities/projectiles/bomb_small.xml")
			add_projectile("mods/copis_things/files/entities/projectiles/bomb_small.xml")
			c.fire_rate_wait = c.fire_rate_wait + 60
		end
	},
	{
		id                  = "COPITH_STUN_BOMBS",
		name                = "$actionname_stun_bombs",
		description         = "$actiondesc_stun_bombs",
		author              = "Copi",
		mod                 = "Copi's Things",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/stun_bombs.png",
		related_projectiles = { "mods/copis_things/files/entities/projectiles/stun_bombs.xml" },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "0,1,2,3",
		spawn_probability   = "0.25,0.1,0.1,0.1",
		price               = 120,
		mana                = 10,
		max_uses            = 15,
		action = function()
			add_projectile("mods/copis_things/files/entities/projectiles/stun_bombs.xml")
			add_projectile("mods/copis_things/files/entities/projectiles/stun_bombs.xml")
			add_projectile("mods/copis_things/files/entities/projectiles/stun_bombs.xml")
			c.fire_rate_wait = c.fire_rate_wait + 60
		end
	},
	-- ALMOST works. Either using a temp deck and it skips all spells after it (???) or it does an AC wand refresh haxx
	--[[{
		id 						= "COPITH_INVENTORY_WAND",
		name 					= "$actionname_inventory_wand",
		description 			= "$actiondesc_inventory_wand",
		author 					= "Copi",
		mod 					= "Copi's Things",
		sprite 					= "mods/copis_things/files/ui_gfx/gun_actions/inventory_wand.png",
		sprite_unidentified 	= "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
		type 					= ACTION_TYPE_OTHER,
		spawn_level 			= "6,10",
		spawn_probability 		= "0.1,0.4",
		price 					= 300,
		mana 					= 150,
		max_uses 				= 3,
		custom_xml_file			= "mods/copis_things/files/entities/misc/custom_cards/wandbuilding.xml",
		action = function()
			if reflecting then return end
			local caster = GetUpdatedEntityID()
			local inv2comp = EntityGetFirstComponentIncludingDisabled(caster, "Inventory2Component")
			if not inv2comp then return end
			local slots = ComponentGetValue2(inv2comp, "full_inventory_slots_x") * ComponentGetValue2(inv2comp, "full_inventory_slots_y")
			local children = EntityGetAllChildren(caster) or {}
			-- Get spells inventory
			for i=1,#children do
				if (EntityGetName(children[i]) == "inventory_full") then
					local lookup = GunUtils.lookup_spells()
					-- Gather all spells in inventory
					local inventory_items = EntityGetAllChildren(children[i]) or {}
					local old_deck = deck
					local deck = {}
					for j=1,#inventory_items do
						if EntityHasTag(inventory_items[j], "card_action") then
							local iac = EntityGetFirstComponentIncludingDisabled( inventory_items[j], "ItemActionComponent" ) ---@cast iac integer
							local action = lookup[ComponentGetValue2( iac, "action_id" )]
							if action ~= nil then
								deck[#deck+1] = action
							end
						end
					end

					while (#deck > 0) do draw_actions(1, true) end

					deck = old_deck

					for key, value in pairs(deck) do
						print(tostring(key), tostring(value.id))
					end
					break
				end
			end
		end
	},]]

	{
		id                  = "COPITH_ELECTRIC_TELEPORT",
		name                = "$actionname_electric_teleport",
		description         = "$actiondesc_electric_teleport",
		author              = "Copi",
		mod                 = "Copi's Things",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/electric_teleport.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/rocket_unidentified.png",
		related_projectiles = {"mods/copis_things/files/entities/projectiles/electric_teleport.xml"},
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "2,3,4",
		spawn_probability   = "1,0.5,0.5",
		price               = 100,
		mana                = 30,
		action = function()
			add_projectile("mods/copis_things/files/entities/projectiles/electric_teleport.xml")
		end,
	},
	{
		id                  = "COPITH_CLOUD_DISC_BULLET",
		name                = "$actionname_cloud_disc_bullet",
		description         = "$actiondesc_cloud_disc_bullet",
		author              = "Copi",
		mod                 = "Copi's Things",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/cloud_disc_bullet.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/cloud_water_unidentified.png",
		related_projectiles = {"mods/copis_things/files/entities/projectiles/cloud_disc_bullet.xml"},
		type                = ACTION_TYPE_STATIC_PROJECTILE,
		spawn_level         = "0,1,2,3,4,5",                                                          -- CLOUD_THUNDER
		spawn_probability   = "0.3,0.3,0.2,0.3,0.4,0.5",                                              -- CLOUD_THUNDER
		price               = 100,
		mana                = 120,
		action = function()
			add_projectile("mods/copis_things/files/entities/projectiles/cloud_disc_bullet.xml")
			c.fire_rate_wait = c.fire_rate_wait + 30
		end,
	},
	{
		id                  = "COPITH_POLY_PROPANE_TANK",
		name                = "$actionname_poly_propane_tank",
		description         = "$actiondesc_poly_propane_tank",
		author              = "Copi",
		mod                 = "Copi's Things",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/poly_propane_tank.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/bomb_unidentified.png",
		related_projectiles = {"mods/copis_things/files/entities/projectiles/poly_propane_tank.xml"},
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "2,3,4,5,6",                                                                -- PROPANE_TANK
		spawn_probability   = "0.5,0.5,0.6,0.5,0.6",                                                      -- PROPANE_TANK
		price               = 200,
		mana                = 120,
		max_uses            = 10,
		custom_xml_file     = "mods/copis_things/files/entities/misc/custom_cards/poly_propane_tank.xml",
		action = function()
			add_projectile("mods/copis_things/files/entities/projectiles/poly_propane_tank.xml")
			c.fire_rate_wait = c.fire_rate_wait + 120
		end,
	},
	{
		id                  = "COPITH_SLOTS_TO_SPEED",
		name                = "$actionname_slots_to_speed",
		description         = "$actiondesc_slots_to_speed",
		author              = "Copi",
		mod                 = "Copi's Things",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/slots_to_speed.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/bomb_unidentified.png",
		type                = ACTION_TYPE_PASSIVE,
		spawn_level         = "0,1,2",                                                                 -- URGENTLY NEEDS REBALANCING
		spawn_probability   = "0.5,0.5,0.1",                                                           -- URGENTLY NEEDS REBALANCING
		price               = 200,
		mana                = 0,
		custom_xml_file     = "mods/copis_things/files/entities/misc/custom_cards/slots_to_speed.xml",
		action = function()
			draw_actions(1, true)
		end,
	},
	{
		id                  = "COPITH_AERODISC",
		name                = "$actionname_aerodisc",
		description         = "$actiondesc_aerodisc",
		author              = "Copi",
		mod                 = "Copi's Things",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/aerodisc.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/bomb_unidentified.png",
		related_projectiles = {"mods/copis_things/files/entities/projectiles/aerodisc.xml"},
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "2,3,4",                                                       -- PROPANE_TANK
		spawn_probability   = "0.5,0.5,0.6",                                                 -- PROPANE_TANK
		price               = 200,
		mana                = 12,
		action = function()
			add_projectile("mods/copis_things/files/entities/projectiles/aerodisc.xml")
			c.fire_rate_wait = c.fire_rate_wait + 120
		end,
	},
	{
		id                  = "COPITH_COWARD_BOLT_DEATH_TRIGGER",
		name                = "$actionname_coward_bolt_death_trigger",
		description         = "$actiondesc_coward_bolt_death_trigger",
		author              = "Copi",
		mod                 = "Copi's Things",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/coward_bolt_death_trigger.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/bomb_unidentified.png",
		related_projectiles = {"mods/copis_things/files/entities/projectiles/coward_bolt.xml"},
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "0,1,2",
		spawn_probability   = "0.5,1,0.5",
		price               = 200,
		mana                = -4,
		action = function()
			add_projectile_trigger_death("mods/copis_things/files/entities/projectiles/coward_bolt.xml", 1)
			c.fire_rate_wait = c.fire_rate_wait + 6
			c.spread_degrees = c.spread_degrees - 18
		end,
	},
	--[[
	{
		id                  = "COPITH_DAMAGE_BANE_ROBOT",
		name                = "$actionname_damage_bane_robot",
		description         = "$actiondesc_damage_bane_robot",
		author              = "Copi",
		mod                 = "Copi's Things",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/damage_bane_robot.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
		type                = ACTION_TYPE_OTHER,
		spawn_level         = "1,2,3,4,5", -- DAMAGE
		spawn_probability   = "0.1,0.1,0.1,0.1,0.1", -- DAMAGE
		price               = 140,
		mana                = 5,
		custom_xml_file		= "data/entities/misc/custom_cards/damage.xml",
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 12
			--c.action_type = c.action_type + 1
			--c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/damage_bane_.xml,"
			add_projectile("mods/copis_things/files/entities/projectiles/dart.xml")
			draw_actions(1, true)
		end
	},]]
	{
		id                  = "COPITH_NETTLES",
		name                = "$actionname_nettles",
		description         = "$actiondesc_nettles",
		author              = "Copi",
		mod                 = "Copi's Things",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/nettles.png",
		related_projectiles = { "mods/copis_things/files/entities/projectiles/nettles.xml" },
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "0,1,2",
		spawn_probability   = "1.25,0.75,0.33",
		inject_after        = {"BULLET", "BULLET_TRIGGER", "BULLET_TIMER"},
		price               = 120,
		mana                = 5,
		action = function()
			if reflecting then
				c.fire_rate_wait = c.fire_rate_wait - 2
				Reflection_RegisterProjectile("mods/copis_things/files/entities/projectiles/nettles.xml")
				Reflection_RegisterProjectile("mods/copis_things/files/entities/projectiles/nettles.xml")
				return
			end
			for i=1, math.random(2,3) do
				add_projectile("mods/copis_things/files/entities/projectiles/nettles.xml")
			end
			c.fire_rate_wait = c.fire_rate_wait - 2
		end
	},--[[
	{
		id                  = "COPITH_AREA_OF_EFFECT",
		name                = "$actionname_area_of_effect",
		description         = "$actiondesc_area_of_effect",
		author              = "Copi",
		mod                 = "Copi's Things",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/nettles.png",
		related_projectiles = { "mods/copis_things/files/entities/projectiles/nettles.xml" },
		type                = ACTION_TYPE_STATIC_PROJECTILE,
		spawn_level         = "0,1,2",
		spawn_probability   = "0.75,0.5,0.25",
		price               = 120,
		mana                = 5,
		action = function()
			add_projectile("mods/copis_things/files/entities/projectiles/nettles.xml")
			c.fire_rate_wait = c.fire_rate_wait - 2
		end
	},]]
	{
		id                     = "COPITH_COLD_HEARTED",
		name                   = "$actionname_cold_hearted",
		description            = "$actiondesc_cold_hearted",
		author                 = "Copi",
		mod                    = "Copi's Things",
		sprite                 = "mods/copis_things/files/ui_gfx/gun_actions/cold_hearted.png",
		sprite_unidentified    = "data/ui_gfx/gun_actions/freeze_unidentified.png",
		type                   = ACTION_TYPE_MODIFIER,
		spawn_level            = "1,2,3",                                                -- FREEZE
		spawn_probability      = "1,1,0.9",                                            -- FREEZE
		price                  = 140,
		mana                   = 15,
		action = function()
			copi_state.bit = bit.bor(copi_state.bit, 512)
			draw_actions( 1, true )
		end,
	},--[[
	{
		id                  = "COPITH_HOLIEST_BOMB",
		name                = "$actionname_holiest_bomb",
		description         = "$actiondesc_holiest_bomb",
		author              = "Copi",
		mod                 = "Copi's Things",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/holiest_bomb.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/bomb_unidentified.png",
		related_projectiles = {"mods/copis_things/files/entities/projectiles/poly_propane_tank.xml"},
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "2,3,4,5,6",                                                                -- PROPANE_TANK
		spawn_probability   = "0.5,0.5,0.6,0.5,0.6",                                                      -- PROPANE_TANK
		price               = 200,
		mana                = 120,
		max_uses            = 10,
		custom_xml_file     = "mods/copis_things/files/entities/misc/custom_cards/poly_propane_tank.xml",
		action = function()
			add_projectile("mods/copis_things/files/entities/projectiles/poly_propane_tank.xml")
			c.fire_rate_wait = c.fire_rate_wait + 120
		end,
	},]]

	-- IDEALLY keep at end of list.
	{ -- rare esoteric bullshit
		id                  = "COPITH_RANDOM_PROJECTILE_REAL",
		name                = "$actionname_random_projectile_real",
		description         = "$actiondesc_random_projectile_real",
		author              = "Copi",
		mod                 = "Copi's Things",
		sprite              = "mods/copis_things/files/ui_gfx/gun_actions/random_projectile_real.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/rocket_unidentified.png",
		related_projectiles = {"mods/copis_things/files/entities/projectiles/random_projectile_real.xml"},
		type                = ACTION_TYPE_PROJECTILE,
		spawn_level         = "1,2,3,4,5,6,7,10",
		spawn_probability   = "0,0,0,0,0,0,0,0.01",
		price               = 34,
		mana                = 21,
		pandorium_ignore    = true,
		custom_xml_file     = "mods/copis_things/files/entities/misc/custom_cards/random_projectile_real.xml",
		action = function()
			if reflecting then return end
			for i=1, math.random(1,3) do
				add_projectile("mods/copis_things/files/entities/projectiles/random_projectile_real.xml")
			end
		end,
	},
	--[[{
		id = "COPITH_DELAYED_DAMAGE",
		name = "$actionname_ror2collapse",
		author = "Copi",
		mod = "Copi's Things",
		description = "$actiondesc_ror2collapse",
		sprite = "mods/copis_things/files/ui_gfx/gun_actions/delayed_damage.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
		related_extra_entities = { "mods/copis_things/files/entities/misc/hitfx_collapse.xml" },
		type = ACTION_TYPE_MODIFIER,
		spawn_level = "2,3,4",
		spawn_probability = "0.6,0.3,0.4",
		inject_after = {"FIREBALL_RAY_LINE"},
		price = 300,
		mana = 10,
		action = function()
			c.fire_rate_wait = c.fire_rate_wait + 12
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/hitfx_delayed_damage.xml,"
			draw_actions(1, true)
		end
	},]]
}

if ModSettingGet("CopisThings.inject_spells") then
	-- Based on Conga Lyne's implementation
	for insert_index = 1, #actions_to_insert do
		local action_to_insert = actions_to_insert[insert_index]
		-- Check if spells to inject after are defined
		if action_to_insert.inject_after ~= nil then
			-- Loop over actions
			local found = false
			for actions_index = #actions, 1, -1 do
				local action = actions[actions_index]
				-- Loop over inject after options
				for inject_index = 1, #action_to_insert.inject_after do
					if action.id == action_to_insert.inject_after[inject_index] then
						found = true
						break
					end
				end
				if found then
					table.insert(actions, actions_index + 1, action_to_insert)  -- I hate table insert; push over the other spells and insert at index+1 later
					break
				end
				if actions_index == 1 then
					--Insert here as a failsafe incase the matchup ID can't be found.. some other mod might delete the spell we're trying to insert at
					actions[#actions + 1] = action_to_insert
				end
			end
		else
			actions[#actions + 1] = action_to_insert
		end
	end
else
	local len = #actions -- SPEEDY loop
	for i = 1, #actions_to_insert do
		actions[len+i] = actions_to_insert[i]
	end
end

--[[ Not a shared state, cannot easily handle this. We're somewhere in the high 200s? I think?
-- erm... shut up?
if PrintCount == nil then
	print("COPI SPELLS: ".. tostring(#actions_to_insert))
	PrintCount = false
end]]

if events.april_fools then
	-- Fix noita:
	if ModSettingGet("CopisThings.do_april_fools") then
		local actions_new = {}
		for i=1, #actions do
			if actions[i].author ~= nil then
				actions_new[#actions_new+1] = actions[i]
			end
		end
		---@diagnostic disable-next-line: lowercase-global
		actions = actions_new
	end
end

-- Handle dev build spells
if DebugGetIsDevBuild() then
	actions[#actions + 1] = {
		id = "COPITH_DEBUG",
		name = "Debug",
		author = "Copi",
		mod = "Copi's Things",
		description = "Prints cast state data",
		sprite = "mods/copis_things/files/ui_gfx/gun_actions/dev_meta.png",
		type = ACTION_TYPE_OTHER,
		spawn_level = "0",
		spawn_probability = "0",
		price = 0,
		mana = 0,
		action = function()
			if not reflecting then
				c.debug = true
			end
			draw_actions(1, true)
		end
	}
	actions[#actions + 1] = {
		id = "COPITH_TEST",
		name = "TEST",
		author = "Copi",
		mod = "Copi's Things",
		description = "TEST",
		sprite = "mods/copis_things/files/ui_gfx/gun_actions/dev_meta.png",
		type = ACTION_TYPE_OTHER,
		spawn_level = "0",
		spawn_probability = "0",
		price = 0,
		mana = 0,
		action = function()
			--c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/test.xml,"
			c.physics_impulse_coeff = c.physics_impulse_coeff + 5
			draw_actions(1, true)
		end
	}
end

-- Holy fuck that's one hell of a file :/