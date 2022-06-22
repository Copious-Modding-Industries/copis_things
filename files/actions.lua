local to_insert = {
	{
		id					= "COPIS_THINGS_DEV",
		name				= "Dev",
		author		= "Copi",
		description			= "Spell for testing ideas, comment out in final release",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/dev.png",
		type				= ACTION_TYPE_OTHER,
		spawn_level			= "0,0",
		spawn_probability	= "0,0",
		price				= 0,
		mana				= 0,
		action				= function()
			add_projectile("mods/copis_things/files/entities/projectiles/longleg_projectile.xml")
			--add_projectile_repeating_trigger_timer("data/entities/projectiles/deck/light_bullet.xml", 30, 1)
			--[[add_projectile("mods/copis_things/files/entities/projectiles/boring_bomb.xml")
			 bore scene load
			SetRandomSeed( GameGetFrameNum(), GameGetFrameNum() + 953 )
			add_projectile( "mods/copis_things/files/entities/buildings/breach_".. tostring(Random(1,2)) .."_building.xml")
			]]
		end,
	},

	-- PSYCHIC SHOT
	{
		id          		= "COPIS_THINGS_PSYCHIC_SHOT",
		name 				= "Psychic shot",
		author		= "Copi",
		description 		= "Causes the projectile to be controlled telekinetically",
		sprite 				= "mods/copis_things/files/ui_gfx/gun_actions/psychic_shot.png",
		type 				= ACTION_TYPE_MODIFIER,
		spawn_level			 = "2,3,4,5,6",
		spawn_probability	 = "0.3,0.4,0.5,0.6,0.6",
		price 				= 150,
		mana 				= 15,
		action				= function()
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/psychic_shot.xml,"
			draw_actions( 1, true )
		end
	},

	-- STAB
	{
		id					= "COPIS_THINGS_STAB",
		name				= "Stab",
		author		= "Copi",
		description			= "A short ranged melee thrust",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/stab.png",
		related_projectiles	= {"mods/copis_things/files/entities/projectiles/stab.xml"},
		type				= ACTION_TYPE_PROJECTILE,
		spawn_level			= "0,0,0,0",
		spawn_probability	= "0,0,0,0",
		price				= 0,
		mana				= 0,
		action				= function()
			add_projectile("mods/copis_things/files/entities/projectiles/stab.xml")
			c.fire_rate_wait = c.fire_rate_wait + 7
			c.screenshake = c.screenshake + 0.7
			c.spread_degrees = c.spread_degrees - 2.0
			c.damage_critical_chance = c.damage_critical_chance + 15
		end,
	},

	-- SWORD THROW
	{
		id					= "COPIS_THINGS_TWISTED_SWORD_THROW",
		name				= "Sword throw",
		author		= "Copi",
		description			= "Throw a rapidly spinning sword clone",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/twisted_throw.png",
		related_projectiles	= {"mods/copis_things/files/entities/projectiles/twisted_throw.xml"},
		type				= ACTION_TYPE_PROJECTILE,
		spawn_level			= "0,0,0,0",
		spawn_probability	= "0,0,0,0",
		price				= 0,
		mana				= 0,
	action				= function()
			add_projectile("mods/copis_things/files/entities/projectiles/twisted_throw.xml")
			c.screenshake = c.screenshake + 0.7
			c.spread_degrees = c.spread_degrees - 2.0
			c.damage_critical_chance = c.damage_critical_chance + 15
			c.fire_rate_wait = c.fire_rate_wait + 40
			shot_effects.recoil_knockback = shot_effects.recoil_knockback + 30.0
			c.damage_projectile_add = c.damage_projectile_add + 0.2
		end,
	},

	-- LUNGE
	{
		id          = "COPIS_THINGS_LUNGE",
		name 		= "Lunge",
		author		= "Copi",
		description = "Launch yourself forwards with a burst of speed",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/lunge.png",
		type 		= ACTION_TYPE_UTILITY,
		spawn_level = "2,4",
		spawn_probability = "0.6,0.6",
		price = 100,
		mana = 5,
		action = function()
			local player = EntityGetWithTag( "player_unit" )[1]
			local pos_x, pos_y = EntityGetTransform( player )
			local mouse_x, mouse_y = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(player, "ControlsComponent"), "mMousePosition")
			if (mouse_x == nil or mouse_y == nil) then return end
			local aim_x = mouse_x - pos_x
			local aim_y = mouse_y - pos_y
			local len = math.sqrt((aim_x^2) + (aim_y^2))
			local force_x = 1000
			local force_y = 1000
			ComponentSetValue2( EntityGetFirstComponent(player, "CharacterDataComponent"), "mVelocity",
			(aim_x/len*force_x), (aim_y/len*force_y))
		end,
	},

	{
		id          = "COPIS_THINGS_SHADOWTENTACLE",
		name 		= "Shadow Apparition",
		author		= "Copi",
		description = "Release a lash of pure darkness which spreads from it's victims",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/shadowtentacle.png",
		related_projectiles	= {"mods/copis_things/files/projectiles/shadowtentacle.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		spawn_level			= "0,0,0,0",
		spawn_probability	= "0,0,0,0",
		price = 170,
		mana = 30,
		action				= function()
			add_projectile("mods/copis_things/files/entities/projectiles/shadow_lash.xml")
			c.fire_rate_wait = c.fire_rate_wait - 5
		end
	},

	-- BLOOD TENTACLE
	{
		id          = "BLOODTENTACLE",
		name 		= "$action_bloodtentacle",
		author		= "Copi",
		description = "$actiondesc_bloodtentacle",
		spawn_requires_flag = "card_unlocked_pyramid",
		sprite 		= "data/ui_gfx/gun_actions/bloodtentacle.png",
		related_projectiles	= {"data/entities/projectiles/deck/bloodtentacle.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		spawn_level			               = "3,4,5,6", -- TENTACLE
		spawn_probability	               = "0.2,0.5,1,1", -- TENTACLE
		price = 170,
		mana = 30,
		--max_uses = 40,
		action				= function()
			add_projectile("data/entities/projectiles/deck/bloodtentacle.xml")
			c.fire_rate_wait = c.fire_rate_wait + 20
		end,
	},

	{
		id          = "COPIS_THINGS_SUNSABER_DARK",
		name 		= "Dark Sunsaber",
		author		= "Copi",
		description = "A blade forged from the dark sun",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/sunsaber_dark.png",
		related_projectiles	= {"mods/copis_things/files/entities/projectiles/sunsaber_dark.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		spawn_level			               = "0,0",
		spawn_probability	               = "0,0",
		price = 150,
		mana = 0,
		sound_loop_tag = "sound_digger",
		action				= function()
			add_projectile("mods/copis_things/files/entities/projectiles/sunsaber_dark.xml")
			c.fire_rate_wait = c.fire_rate_wait - 35
			current_reload_time = current_reload_time - ACTION_DRAW_RELOAD_TIME_INCREASE - 10
		end,
	},

	{
		id					= "COPIS_THINGS_SWORD_BLADE",
		name				= "Sword Blade",
		author		= "Copi",
		description			= "Your sword's sharp edge deals damage as it hits foes!",
		sprite      	   = "mods/copis_things/files/ui_gfx/gun_actions/sword_blade.png",
		type        		= ACTION_TYPE_PASSIVE,
		spawn_level       = "0,0",
		spawn_probability	= "0,0",
		price				= 0,
		mana				= 0,
		custom_xml_file = "mods/copis_things/files/entities/projectiles/sword_blade.xml",
		action = function()
		end
	},

	{
		id          = "COPIS_THINGS_SUMMON_TABLET",
		name 		= "Summon Emerald Tablet",
		author		= "Copi",
		description = "Summon an emerald tablet",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/summon_tablet.png",
		related_projectiles	= {"mods/copis_things/files/entities/projectiles/tablet.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		spawn_level			               = "0,1,2,3,4,5,6", -- SUMMON_ROCK
		spawn_probability	               = "0.8,0.8,0.8,0.8,0.8,0.8,0.8", -- SUMMON_ROCK
		price = 160,
		mana = 100, 
		max_uses    = 3, 
		--custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/summon_rock.xml",
		action				= function()
			add_projectile("mods/copis_things/files/entities/projectiles/tablet.xml")
		end,
	},

	{
		id          = "COPIS_THINGS_PROJECTION_CAST",
		name 		= "Projection cast",
		author		= "Copi",
		description = "Projects your cast to where your mind focuses",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/projection_cast.png",
		type 		= ACTION_TYPE_UTILITY,
		spawn_level						  = "6,10",
		spawn_probability				  = "0.2,1",
		price = 250,
		mana = 50,
		action				= function()
			add_projectile_trigger_death("mods/copis_things/files/entities/projectiles/projection_cast.xml", 1)
			c.fire_rate_wait = c.fire_rate_wait + 10
			c.spread_degrees = c.spread_degrees - 6
		end,
	},

	{
		id          = "COPIS_THINGS_SLOW",
		name 		= "Speed Down",
		author		= "Copi",
		description = "Decreases the speed at which a projectile flies through the air",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/slow.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level			= "1,		2,		3,		4",
		spawn_probability	= "0.8,		0.8,	0.8,	0.8",
		price = 50,
		mana = -3,
		--max_uses = 100,
		custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/slow.xml",
		action				= function()
			c.speed_multiplier = c.speed_multiplier * 0.6
			c.spread_degrees = c.spread_degrees - 8
			draw_actions( 1, true )
		end,
	},

	{
		id          = "COPIS_THINGS_CLAIRVOYANCE",
		name 		= "Clairvoyance",
		author		= "Copi",
		description = "Allows you to project your vision",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/clairvoyance.png",
		type 		= ACTION_TYPE_PASSIVE,
		spawn_level			               = "1,2,3,4,5,6", -- TINY_GHOST
		spawn_probability	               = "0.1,0.5,1,1,1,1", -- TINY_GHOST
		price = 160,
		mana = 0,
		custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/clairvoyance.xml",
		action				= function()
			draw_actions( 1, true )
		end,
	},

	{
		id          = "COPIS_THINGS_PEACEFUL_SHOT",
		name 		= "Peaceful Shot",
		author		= "Copi",
		description = "Sharply reduces the damage of a projectile",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/peaceful_shot.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level			               = "1,2,3", -- SPEED
		spawn_probability	               = "1,0.5,0.5", -- SPEED
		price = 100,
		mana = -15,
		action				= function()
			c.speed_multiplier = c.speed_multiplier * 0.8
			c.gore_particles   = c.gore_particles - 5
			c.fire_rate_wait   = c.fire_rate_wait - 5
			c.damage_projectile_add = c.damage_projectile_add - 1
			c.spread_degrees = c.spread_degrees - 5
			draw_actions( 1, true )
		end,
	},

	{
		id          = "COPIS_THINGS_ANCHORED_SHOT",
		name 		= "Anchored Shot",
		author		= "Copi",
		description = "Anchors a projectile where it was fired",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/anchored_shot.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level			               = "1,2,3", -- SPEED
		spawn_probability	               = "1,0.5,0.5", -- SPEED
		price = 100,
		mana = 10,
		action				= function()
			--c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/stasis_shot.xml"
			c.speed_multiplier = c.speed_multiplier * 0.05
			c.spread_degrees = c.spread_degrees - 10
			c.lifetime_add 		= c.lifetime_add + 250
			c.fire_rate_wait = c.fire_rate_wait + 26
			draw_actions( 1, true )
		end,
	},

	{
		id          = "COPIS_THINGS_LEVITY_SHOT",
		name 		= "Levity Shot",
		author		= "Copi",
		description = "Nullifies a projectile's gravity",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/levity_shot.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level			               = "1,2,3", -- SPEED
		spawn_probability	               = "1,0.5,0.5", -- SPEED
		price = 100,
		mana = 5,
		action				= function()
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/levity_shot.xml,"
			c.speed_multiplier = c.speed_multiplier * 0.9
			c.spread_degrees = c.spread_degrees - 10
			draw_actions( 1, true )
		end,
	},

	{
		id          = "COPIS_THINGS_BOUNCE_100",
		name 		= "Hundredfold Bounce",
		author		= "Copi",
		description = "Causes a projectile to bounce many times",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/bounce_100.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level			               = "2,3,4,5,6", -- BOUNCE
		spawn_probability	               = "1,1,0.4,0.2,0.2", -- BOUNCE
		price = 100,
		mana = 10,
		action				= function()
			c.bounces = c.bounces + 100
			c.speed_multiplier = c.speed_multiplier * 1.2
			c.spread_degrees = c.spread_degrees - 10
			draw_actions( 1, true )
		end,
	},

	{
		id          = "COPIS_THINGS_SEPARATOR_CAST",
		name 		= "Separator cast",
		author		= "Copi",
		description = "Casts a projectile independent of any modifiers before it, like in a multicast",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/separator_cast.png",
		type 		= ACTION_TYPE_UTILITY,
		spawn_level			               = "2,		3,		4,		5", -- BOUNCE
		spawn_probability	               = "0.3,		0.3,	0.3,	0.3",
		price = 210,
		mana = 0,
		action				= function()
			if reflecting then return; end
			add_projectile_trigger_death( "mods/copis_things/files/entities/projectiles/separator_cast.xml" , 1);
			--[[
            local old_c = c;
			c = {};
			reset_modifiers( c );
            BeginProjectile( "mods/copis_things/files/entities/projectiles/separator_cast.xml" );
                BeginTriggerDeath();
                    for k,v in pairs(old_c) do
                        c[k] = v;
                    end
                    draw_actions( 1, true );
                    register_action( c );
                    SetProjectileConfigs();
                EndTrigger();
            EndProjectile();
            c = old_c;
			]]
		end,
	},

	{
		id          = "COPIS_THINGS_SPREAD",
		name 		= "Spread",
		author		= "Copi",
		description = "Adds spread to a projectile",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/spread.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level			               = "1,2,3,4,5,6", -- SPREAD_REDUCE
		spawn_probability	               = "0.8,0.8,0.8,0.8,0.8,0.8", -- SPREAD_REDUCE
		price = 100,
		mana = -5,
		action				= function()
			c.spread_degrees = c.spread_degrees + 30.0
			c.fire_rate_wait   = c.fire_rate_wait - 5
			draw_actions( 1, true )
		end,
	},

	{
		id					= "COPIS_THINGS_JSR_BLAST",
		name				= "JSR Blast",
		author		= "Copi",
		description			= "Fire a pulse of energy",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/jsr_blast.png",
		related_projectiles	= {"data/entities/projectiles/laser_bouncy.xml"},
		type				= ACTION_TYPE_PROJECTILE,
		spawn_level			= "0,0,0,0",
		spawn_probability	= "0,0,0,0",
		price				= 0,
		mana				= 0,
		action				= function()
				add_projectile("data/entities/projectiles/laser_bouncy.xml")
				c.spread_degrees = c.spread_degrees - 2.0
				c.damage_projectile_add = c.damage_projectile_add - 0.25
		end,
	},

	{
		id					= "COPIS_THINGS_DART",
		name				= "Dart",
		author		= "Copi",
		description			= "An accelerating magical dart that pierces soft materials",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/dart.png",
		related_projectiles	= {"mods/copis_things/files/entities/projectiles/dart.xml"},
		type				= ACTION_TYPE_PROJECTILE,
		spawn_level			= "0,1,2",
		spawn_probability	= "2,1,0.5",
		price				= 120,
		mana				= 7,
		action				= function()
				add_projectile("mods/copis_things/files/entities/projectiles/dart.xml")
				c.fire_rate_wait = c.fire_rate_wait + 2;
		end,
	},

	{
		id          = "COPIS_THINGS_DIE",
		name 		= "Die",
		author		= "Copi",
		description = "Reverses the flow of mana in your body, giving you a quick and painless death.",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/die.png",
		type 		= ACTION_TYPE_UTILITY,
		spawn_level						  = "6,10",
		spawn_probability				  = "0.2,1",
		price = 250,
		mana = 0,
		action				= function()
			local entity_id = EntityGetWithTag("player_unit")[1]
			if entity_id ~= nil and entity_id ~= 0 then
				local damage_model_component = EntityGetFirstComponent(entity_id, "DamageModelComponent")
				ComponentSetValue2(damage_model_component, "hp", 0)
				ComponentSetValue2(damage_model_component, "air_needed", true)
				ComponentSetValue2(damage_model_component, "air_in_lungs", 0)
			end
		end,
	},
	{
		id          = "COPIS_THINGS_TEMPORARY_CIRCLE",
		name 		= "Summon Circle",
		author		= "Copi",
		description = "Summons a shortlived hollow circle",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/temporary_circle.png",
		related_projectiles	= {"mods/copis_things/files/entities/projectiles/deck/temporary_wall.xml"},
		type 		= ACTION_TYPE_UTILITY,
		spawn_level			               = "0,1,2,4,5,6", -- WALL_SQUARE
		spawn_probability	               = "0.1,0.1,0.3,0.4,0.2,0.1", -- WALL_SQUARE
		price = 100,
		mana = 40,
		max_uses = 20,
		action				= function()
			add_projectile("mods/copis_things/files/entities/projectiles/temporary_circle.xml")
			c.fire_rate_wait = c.fire_rate_wait + 40
		end,
	},
	{
		id          = "COPIS_THINGS_LARPA_FORWARDS",
		name 		= "Forwards Larpa",
		author		= "Copi",
		description = "Makes a projectile cast copies of itself forwards",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/forwards_larpa.png",
		related_extra_entities = { "mods/copis_things/files/entities/misc/forwards_larpa.xml" },
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level			               = "2,3,4,5,10", -- FIREBALL_RAY
		spawn_probability	               = "0.1,0.2,0.3,0.4,0.2", -- FIREBALL_RAY
		price = 260,
		mana = 100,
		--max_uses = 20,
		action				= function()
			c.fire_rate_wait = c.fire_rate_wait + 15
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/forwards_larpa.xml,"
			draw_actions( 1, true )
		end,
	},
	{
		id						= "COPIS_THINGS_HOMING_LIGHT",
		name					= "Soft Homing",
		author		= "Copi",
		description				= "Guides a projectile weakly towards your foes",
		sprite					= "mods/copis_things/files/ui_gfx/gun_actions/homing_light.png",
		related_extra_entities	= { "mods/copis_things/files/entities/misc/homing_light.xml,data/entities/particles/tinyspark_white_weak.xml" },
		type					= ACTION_TYPE_MODIFIER,
		spawn_level				= "1,2,3,4,5,6", -- HOMING
		spawn_probability		= "0.4,0.8,1,0.4,0.1,0.1", -- HOMING
		price					= 100,
		mana					= 25,
		action					= function()
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/homing_light.xml,data/entities/particles/tinyspark_white_weak.xml,"
			draw_actions( 1, true )
		end,
	},
	-- PSYCHIC GRIP
	{
		id					= "COPIS_THINGS_PSYCHIC_GRIP",
		name 				= "Psychic Grip",
		author		= "Copi",
		description 		= "Locks a projectile in front of your wand",
		sprite 				= "mods/copis_things/files/ui_gfx/gun_actions/psychic_grip.png",
		type 				= ACTION_TYPE_MODIFIER,
		spawn_level			= "2,3,4,5,6",
		spawn_probability	= "0.3,0.4,0.5,0.6,0.6",
		price 				= 150,
		mana 				= 15,
		action				= function()
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/psychic_grip.xml,"
			draw_actions( 1, true )
		end
	},

	-- WISPY SHOT
	{
		id          		= "COPIS_THINGS_WISPY_SHOT",
		name 				= "Wispy Shot",
		author		= "Copi",
		description 		= "Imbues a projectile with a wispy spirit",
		sprite 				= "mods/copis_things/files/ui_gfx/gun_actions/wispy_shot.png",
		type 				= ACTION_TYPE_MODIFIER,
		spawn_level			 = "2,3,4,5,6",
		spawn_probability	 = "0.3,0.4,0.5,0.6,0.6",
		price 				= 150,
		mana 				= 15,
		action				= function()
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/wispy_shot.xml,"
			draw_actions( 1, true )
			c.lifetime_add 		= c.lifetime_add + 1500
			c.fire_rate_wait = c.fire_rate_wait + 20
		end
	},

	{
		id          = "COPIS_THINGS_GUNNER_SHOT",
		name 		= "Gunner Shot",
		author		= "Copi",
		description = "Makes a projectile rapidly fire weak shots at nearby foes",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/gunner_shot.png",
		related_extra_entities = { "mods/copis_things/files/entities/misc/gunner_shot.xml" },
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level			               = "2,3,4,5,10", -- FIREBALL_RAY
		spawn_probability	               = "0.1,0.2,0.3,0.4,0.2", -- FIREBALL_RAY
		price = 260,
		mana = 100,
		--max_uses = 20,
		action				= function()
		c.fire_rate_wait = c.fire_rate_wait + 15
		c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/gunner_shot.xml,"
		draw_actions( 1, true )
	end,
	},

	{
		id          = "COPIS_THINGS_GUNNER_SHOT_STRONG",
		name 		= "Strong Gunner Shot",
		author		= "Copi",
		description = "Makes a projectile occasionally shoot powerful shots at nearby foes",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/gunner_shot_strong.png",
		related_extra_entities = { "mods/copis_things/files/entities/misc/gunner_shot_strong.xml" },
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level			               = "2,3,4,5,10", -- FIREBALL_RAY
		spawn_probability	               = "0.1,0.2,0.3,0.4,0.2", -- FIREBALL_RAY
		price = 260,
		mana = 100,
		--max_uses = 20,
		action				= function()
		c.fire_rate_wait = c.fire_rate_wait + 15
		c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/gunner_shot_strong.xml,"
		draw_actions( 1, true )
	end,
	},

	{
		id          = "COPIS_THINGS_GUNNER_SHOT_CURSOR",
		name 		= "Controlled Gunner Shot",
		author		= "Copi",
		description = "Makes a projectile rapidly fire weak shots at the cursor while holding RMB",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/gunner_shot_cursor.png",
		related_extra_entities = { "mods/copis_things/files/entities/misc/gunner_shot_cursor.xml" },
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level			               = "2,3,4,5,10", -- FIREBALL_RAY
		spawn_probability	               = "0.1,0.2,0.3,0.4,0.2", -- FIREBALL_RAY
		price = 260,
		mana = 100,
		--max_uses = 20,
		action				= function()
		c.fire_rate_wait = c.fire_rate_wait + 15
		c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/gunner_shot_cursor.xml,"
		draw_actions( 1, true )
	end,
	},

	{
		id          = "COPIS_THINGS_SOIL_TRAIL",
		name 		= "Soil Trail",
		author		= "Copi",
		description = "Gives a projectile a trail of soil",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/soil_trail.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level			               = "2,3,4", -- POISON_TRAIL
		spawn_probability	               = "0.3,0.3,0.3", -- POISON_TRAIL
		price = 160,
		mana = 10,
		action				= function()
			c.trail_material = c.trail_material .. "soil,"
			c.trail_material_amount = c.trail_material_amount + 9
			draw_actions( 1, true )
		end,
	},

	{
		id          = "COPIS_THINGS_CONCRETEBALL",
		name 		= "Chunk of concrete",
		author		= "Copi",
		description = "The power of industry!",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/chunk_of_concrete.png",
		related_projectiles	= {"mods/copis_things/files/entities/projectiles/chunk_of_concrete.xml"},
		type 		= ACTION_TYPE_MATERIAL,
		spawn_level			               = "1,2,3,5", -- SOILBALL
		spawn_probability	               = "1,1,1,1", -- SOILBALL
		price = 10,
		mana = 5,
		action				= function()
			add_projectile("mods/copis_things/files/entities/projectiles/chunk_of_concrete.xml")
		end,
	},

	{
		id					= "COPIS_THINGS_SPECIAL_DATARANDAL",
		name				= "Datarandal",
		author		= "Copi",
		description			= "The personal weapon of choice of the great warrior mage Copisinpäällikkö.",
		sprite      	   = "mods/copis_things/files/ui_gfx/gun_actions/datarandal.png",
		type        		= ACTION_TYPE_PASSIVE,
		spawn_level       = "0,0",
		spawn_probability	= "0,0",
		price				= 0,
		mana				= 0,
		custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/datarandal.xml",
		action = function()
		end
	},

	{
		id					= "COPIS_THINGS_BUBBLEBOMB",
		name				= "Bubblebomb",
		author		= "Copi",
		description			= "Testing",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/bubblebomb.png",
		type				= ACTION_TYPE_PROJECTILE,
		spawn_level			= "0,0",
		spawn_probability	= "0,0",
		price				= 9,
		mana				= 0,
		action				= function()
		add_projectile("mods/copis_things/files/entities/projectiles/bubblebomb.xml")
		end,
	},

	{
		id					= "COPIS_THINGS_BUBBLEBOMB_DEATH_TRIGGER",
		name				= "Bubblebomb with death trigger",
		author		= "Copi",
		description			= "Testing",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/bubblebomb_death_trigger.png",
		type				= ACTION_TYPE_PROJECTILE,
		spawn_level			= "0,0",
		spawn_probability	= "0,0",
		price				= 9,
		mana				= 0,
		action				= function()
		add_projectile_trigger_death("mods/copis_things/files/entities/projectiles/bubblebomb.xml", 1)
		end,
	},

	{
		id					= "COPIS_THINGS_ZENITH_DISC",
		name				= "Zenith disc",
		author		= "Copi",
		description			= "Summons a no nonsense sawblade.",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/zenith_disc.png",
		type				= ACTION_TYPE_PROJECTILE,
		spawn_level			= "0,0",
		spawn_probability	= "0,0",
		price				= 9,
		mana				= 0,
		action				= function()
		c.spread_degrees = c.spread_degrees + 5.0
		add_projectile("mods/copis_things/files/entities/projectiles/zenith_disc.xml")
		end,
	},

	{
		id					= "COPIS_THINGS_EVISCERATOR_DISC",
		name				= "Eviscerator",
		author		= "Copi",
		description			= "Please, don't cast this.",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/eviscerator.png",
		type				= ACTION_TYPE_PROJECTILE,
		spawn_level			= "0,0",
		spawn_probability	= "0,0",
		price				= 9,
		mana				= 0,
		action				= function()
		c.spread_degrees = c.spread_degrees + 5.0
		add_projectile("mods/copis_things/files/entities/projectiles/eviscerator.xml")
		end,
	},





	{
		id					= "COPIS_THINGS_SUMMON_HAMIS",
		name				= "Summon Hämis",
		author		= "Copi",
		description			= "Praise Hämis.",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/summon_hamis.png",
		type				= ACTION_TYPE_UTILITY,
		spawn_level			= "0,0",
		spawn_probability	= "0,0",
		price				= 0,
		mana				= 10,
		action				= function()
		add_projectile("data/entities/animals/longleg.xml")
		c.fire_rate_wait = c.fire_rate_wait + 10
		end,
	},

	{
		id					= "COPIS_THINGS_SILVER_BULLET",
		name				= "Silver bullet",
		author		= "Copi",
		description			= "A small bullet created from arcane silver",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/silver_bullet.png",
		related_projectiles	= {"mods/copis_things/files/entities/projectiles/silver_bullet.xml"},
		type				= ACTION_TYPE_PROJECTILE,
		spawn_level			= "2,3,4",
		spawn_probability	= "1,1,0.5",
		price				= 220,
		mana				= 20,
		max_uses			= 30,
		action				= function()
			add_projectile("mods/copis_things/files/entities/projectiles/silver_bullet.xml")
            c.fire_rate_wait = c.fire_rate_wait - 12;
		end,
	},

	{
		id					= "COPIS_THINGS_SILVER_MAGNUM",
		name				= "Silver magnum",
		author		= "Copi",
		description			= "A large bullet created from arcane silver",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/silver_magnum.png",
		related_projectiles	= {"mods/copis_things/files/entities/projectiles/silver_magnum.xml"},
		type				= ACTION_TYPE_PROJECTILE,
		spawn_level			= "2,			3,			4",
		spawn_probability	= "1.00,		0.66,		0.33",
		price				= 330,
		mana				= 35,
		max_uses			= 12,
		action				= function()
				add_projectile("mods/copis_things/files/entities/projectiles/silver_magnum.xml")
				c.fire_rate_wait = c.fire_rate_wait - 6;
			end,
	},

	{
		id					= "COPIS_THINGS_SILVER_BULLET_DEATH_TRIGGER",
		name				= "Silver bullet with expiration trigger",
		author		= "Copi",
		description			= "A small bullet created from arcane silver that casts another spell upon expiring",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/silver_bullet_death_trigger.png",
		related_projectiles	= {"mods/copis_things/files/entities/projectiles/silver_bullet.xml"},
		type				= ACTION_TYPE_PROJECTILE,
		spawn_level			= "4,			5,			6",
		spawn_probability	= "1.00,		0.50,		0.20",
		price				= 220,
		mana				= 25,
		action				= function()
			add_projectile_trigger_death("mods/copis_things/files/entities/projectiles/silver_bullet.xml")
            c.fire_rate_wait = c.fire_rate_wait - 12;
		end,
	},

	{
		id					= "COPIS_THINGS_SILVER_MAGNUM_DEATH_TRIGGER",
		name				= "Silver magnum with expiration trigger",
		author		= "Copi",
		description			= "A large bullet created from arcane silver that casts another spell upon expiring",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/silver_magnum_death_trigger.png",
		related_projectiles	= {"mods/copis_things/files/entities/projectiles/silver_magnum.xml"},
		type				= ACTION_TYPE_PROJECTILE,
		spawn_level			= "2,			3,			4",
		spawn_probability	= "1.00,		0.66,		0.33",
		price				= 330,
		mana				= 40,
		action				= function()
			add_projectile_trigger_death("mods/copis_things/files/entities/projectiles/silver_magnum.xml")
			c.fire_rate_wait = c.fire_rate_wait - 6;
		end,
	},

	{
		id          = "COPIS_THINGS_PLANK_HORIZONTAL",
		name 		= "Build Wooden Platform",
		author		= "Copi",
		description = "Construct a horizontal wooden platform",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/plank_horizontal.png",
		type 		= ACTION_TYPE_UTILITY,
		spawn_level			               = "0,1,2,4,5,6", -- WALL_SQUARE
		spawn_probability	               = "0.1,0.1,0.3,0.4,0.2,0.1", -- WALL_SQUARE
		price = 100,
		mana = 40,
		max_uses = 3,
		custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/plank_horizontal.xml",
		action				= function()
			local entity_id = EntityGetWithTag("player_unit")[1]
			if entity_id ~= nil and entity_id ~= 0 then
				local mouse_x, mouse_y = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(entity_id, "ControlsComponent"), "mMousePosition")
				EntityLoad("mods/copis_things/files/entities/buildings/plank_horizontal_building.xml", mouse_x, mouse_y)
				c.fire_rate_wait = c.fire_rate_wait + 5
				current_reload_time = current_reload_time + 15
			end

		end,
	},

	{
		id          = "COPIS_THINGS_PLANK_CUBE",
		name 		= "Build Wooden Cube",
		author		= "Copi",
		description = "Construct a wooden cube",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/plank_cube.png",
		type 		= ACTION_TYPE_UTILITY,
		spawn_level			               = "0,1,2,4,5,6", -- WALL_SQUARE
		spawn_probability	               = "0.1,0.1,0.3,0.4,0.2,0.1", -- WALL_SQUARE
		price = 100,
		mana = 40,
		max_uses = 12,
		custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/plank_cube.xml",
		action				= function()
			local entity_id = EntityGetWithTag("player_unit")[1]
			if entity_id ~= nil and entity_id ~= 0 then
				local mouse_x, mouse_y = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(entity_id, "ControlsComponent"), "mMousePosition")
				function round(n, to)
					return math.floor(n/to + 0.5) * to
				end
				EntityLoad("mods/copis_things/files/entities/buildings/plank_cube_building.xml", round(mouse_x,16), round(mouse_y,16))
				c.fire_rate_wait = c.fire_rate_wait + 5
				current_reload_time = current_reload_time + 15
			end

		end,
	},

	{
		id          = "COPIS_THINGS_PLANK_VERTICAL",
		name 		= "Build Wooden Wall",
		author		= "Copi",
		description = "Construct a vertical wooden wall",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/plank_vertical.png",
		type 		= ACTION_TYPE_UTILITY,
		spawn_level			               = "0,1,2,4,5,6", -- WALL_SQUARE
		spawn_probability	               = "0.1,0.1,0.3,0.4,0.2,0.1", -- WALL_SQUARE
		price = 100,
		mana = 40,
		max_uses = 3,
		custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/plank_vertical.xml",
		action				= function()
			local entity_id = EntityGetWithTag("player_unit")[1]
			if entity_id ~= nil and entity_id ~= 0 then
				local mouse_x, mouse_y = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(entity_id, "ControlsComponent"), "mMousePosition")
				EntityLoad("mods/copis_things/files/entities/buildings/plank_vertical_building.xml", mouse_x, mouse_y)
				c.fire_rate_wait = c.fire_rate_wait + 5
				current_reload_time = current_reload_time + 15
			end

		end,
	},

	{
		id          = "COPIS_THINGS_SLOTS_TO_POWER",
		name 		= "Slots To Power",
		author		= "Copi",
		description = "Increases a projectile's damage based on the number of empty slots in the wand",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/slots_to_power.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/homing_unidentified.png",
		related_extra_entities = { "mods/copis_things/files/entities/misc/slots_to_power.xml" },
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "1,2,3,10", -- AREA_DAMAGE
		spawn_probability                 = "0.2,0.5,0.5,0.1", -- AREA_DAMAGE
		price = 120,
		mana = 110,
		-- max_uses = 20,
		action 		= function()
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/slots_to_power.xml,"
			c.fire_rate_wait    = c.fire_rate_wait + 20
			draw_actions( 1, true )
		end,
	},

	{
		id          = "COPIS_THINGS_UPGRADE_GUN_SHUFFLE",
		name 		= "Unshuffle (One-Off)",
		author		= "Copi",
		description = "Cast inside a wand to unshuffle it at the cost of reduced stats. Spell is voided upon use!",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/upgrade_gun_shuffle.png",
		type 		= ACTION_TYPE_UTILITY,
		spawn_level                       = "1,2,3,10", -- AREA_DAMAGE
		spawn_probability                 = "1,1,0.5,0.2", -- AREA_DAMAGE
		price = 840,
		mana = 0,
		action 		= function()
		local entity_id = EntityGetWithTag("player_unit")[1]
			if entity_id ~= nil and entity_id ~= 0 then
				dofile("data/scripts/lib/utilities.lua")
				local pos_x, pos_y = EntityGetTransform( entity_id )
				local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
				local wand = EZWand.GetHeldWand()
				if (wand.shuffle == true) then
					wand.shuffle = false
					wand:RemoveSpells("COPIS_THINGS_UPGRADE_GUN_SHUFFLE")
					wand.manaMax = wand.manaMax * 0.9
					wand.manaChargeSpeed = wand.manaChargeSpeed * 0.9
					wand.castDelay = wand.castDelay * 1.1
					wand.rechargeTime = wand.rechargeTime * 1.1


					wand:UpdateSprite()
					GameScreenshake(50, pos_x, pos_y)
					GamePrintImportant("Wand unshuffled!", "Stats slightly reduced.")
				end
			end
		end,
	},

	{
		id          = "COPIS_THINGS_UPGRADE_GUN_SHUFFLE_BAD",
		name 		= "Shuffle (One-Off)",
		author		= "Copi",
		description = "Cast inside a wand to shuffle it, but greatly improve it's stats. Spell is voided upon use!",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/upgrade_gun_shuffle_bad.png",
		type 		= ACTION_TYPE_UTILITY,
		spawn_level                       = "1,2,3,10", -- AREA_DAMAGE
		spawn_probability                 = "1,1,0.5,0.2", -- AREA_DAMAGE
		price = 840,
		mana = 0,
		action 		= function()
		local entity_id = EntityGetWithTag("player_unit")[1]
			if entity_id ~= nil and entity_id ~= 0 then
				dofile("data/scripts/lib/utilities.lua")
				local pos_x, pos_y = EntityGetTransform( entity_id )
				local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
				local wand = EZWand.GetHeldWand()
				if (wand.shuffle == false) then
					wand.shuffle = true
					wand:RemoveSpells("COPIS_THINGS_UPGRADE_GUN_SHUFFLE_BAD")
					wand.manaMax = wand.manaMax * 1.5
					wand.manaChargeSpeed = wand.manaChargeSpeed * 1.5
					wand.castDelay = wand.castDelay * 0.55
					wand.rechargeTime = wand.rechargeTime * 0.55


					wand:UpdateSprite()
					GameScreenshake(50, pos_x, pos_y)
					GamePrintImportant("Wand shuffled!", "Stats improved.")
				end
			end
		end,
	},

	{
		id          = "COPIS_THINGS_UPGRADE_ACTIONS_PER_ROUND",
		name 		= "Upgrade Spells per Cast (One-Off)",
		author		= "Copi",
		description = "Cast inside a wand to increase the amount of spells fired per cast. Spell is voided upon use!",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/upgrade_actions_per_round.png",
		type 		= ACTION_TYPE_UTILITY,
		spawn_level                       = "1,2,3,10", -- AREA_DAMAGE
		spawn_probability                 = "1,1,0.5,0.1", -- AREA_DAMAGE
		price = 840,
		mana = 0,
		action 		= function()
		local entity_id = EntityGetWithTag("player_unit")[1]
			if entity_id ~= nil and entity_id ~= 0 then
				dofile("data/scripts/lib/utilities.lua")
				local pos_x, pos_y = EntityGetTransform( entity_id )
				local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
				local wand = EZWand.GetHeldWand()
				wand:RemoveSpells("COPIS_THINGS_UPGRADE_ACTIONS_PER_ROUND")
				wand.spellsPerCast = wand.spellsPerCast + 1


				wand:UpdateSprite()
				GameScreenshake(50, pos_x, pos_y)
				GamePrintImportant("Wand upgraded!", tostring(wand.spellsPerCast) .. " spells per cast.")
			end
		end,
	},

	{
		id          = "COPIS_THINGS_UPGRADE_SPEED_MULTIPLIER",
		name 		= "Upgrade spell speed multiplier (One-Off)",
		author		= "Copi",
		description = "Cast inside a wand to increase the velocity of projectiles from it. Spell is voided upon use!",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/upgrade_speed_multiplier.png",
		type 		= ACTION_TYPE_UTILITY,
		spawn_level                       = "1,2,3,10", -- AREA_DAMAGE
		spawn_probability                 = "1,1,0.5,0.1", -- AREA_DAMAGE
		price = 840,
		mana = 0,
		action 		= function()
		local entity_id = EntityGetWithTag("player_unit")[1]
			if entity_id ~= nil and entity_id ~= 0 then
				dofile("data/scripts/lib/utilities.lua")
				local pos_x, pos_y = EntityGetTransform( entity_id )
				local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
				local wand = EZWand.GetHeldWand()
				wand:RemoveSpells("COPIS_THINGS_UPGRADE_SPEED_MULTIPLIER")
				SetRandomSeed( pos_x, pos_y + GameGetFrameNum() + 137 )
				wand.speedMultiplier  = wand.speedMultiplier * Random(2,3)


				wand:UpdateSprite()
				GameScreenshake(50, pos_x, pos_y)
				GamePrintImportant("Wand upgraded!", tostring(wand.speedMultiplier ) .. " speed multiplier.")
			end
		end,
	},

	{
		id          = "COPIS_THINGS_UPGRADE_GUN_CAPACITY",
		name 		= "Upgrade wand capacity (One-Off)",
		author		= "Copi",
		description = "Cast inside a wand to increase the wand's total spell capacity. Spell is voided upon use!",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/upgrade_gun_capacity.png",
		type 		= ACTION_TYPE_UTILITY,
		spawn_level                       = "1,2,3,10", -- AREA_DAMAGE
		spawn_probability                 = "1,1,0.5,0.1", -- AREA_DAMAGE
		price = 840,
		mana = 0,
		action 		= function()
		local entity_id = EntityGetWithTag("player_unit")[1]
			if entity_id ~= nil and entity_id ~= 0 then
				dofile("data/scripts/lib/utilities.lua")
				local pos_x, pos_y = EntityGetTransform( entity_id )
				local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
				local wand = EZWand.GetHeldWand()
				if (wand.capacity < 26 ) then
					wand:RemoveSpells("COPIS_THINGS_UPGRADE_GUN_CAPACITY")
					SetRandomSeed( pos_x, pos_y + GameGetFrameNum() + 137 )
					wand.capacity = wand.capacity + Random(1,3)


					wand:UpdateSprite()
					GameScreenshake(50, pos_x, pos_y)
					GamePrintImportant("Wand upgraded!", tostring(wand.capacity) .. " capacity.")
				end
			end
		end,
	},

	{
		id          = "COPIS_THINGS_UPGRADE_FIRE_RATE_WAIT",
		name 		= "Upgrade Cast Delay (One-Off)",
		author		= "Copi",
		description = "Cast inside a wand to decrease the cast delay. Spell is voided upon use!",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/upgrade_fire_rate_wait.png",
		type 		= ACTION_TYPE_UTILITY,
		spawn_level                       = "1,2,3,10", -- AREA_DAMAGE
		spawn_probability                 = "1,1,0.5,0.2", -- AREA_DAMAGE
		price = 840,
		mana = 0,
		action 		= function()
		local entity_id = EntityGetWithTag("player_unit")[1]
			if entity_id ~= nil and entity_id ~= 0 then
				dofile("data/scripts/lib/utilities.lua")
				local pos_x, pos_y = EntityGetTransform( entity_id )
				local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
				local wand = EZWand.GetHeldWand()
				wand:RemoveSpells("COPIS_THINGS_UPGRADE_FIRE_RATE_WAIT")
				local castDelay_old = wand.castDelay
				wand.castDelay = ((wand.castDelay + 0.2) * 0.8) - 0.2


				wand:UpdateSprite()
				GameScreenshake(50, pos_x, pos_y)
				GamePrintImportant("Wand upgraded!", ("%.2fs"):format(castDelay_old/60) .. " -> " .. ("%.2fs"):format(wand.castDelay/60) .. " cast delay.")
			end
		end,
	},

	{
		id          = "COPIS_THINGS_UPGRADE_RELOAD_TIME",
		name 		= "Upgrade Reload Time (One-Off)",
		author		= "Copi",
		description = "Cast inside a wand to decrease the reload time. Spell is voided upon use!",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/upgrade_reload_time.png",
		type 		= ACTION_TYPE_UTILITY,
		spawn_level                       = "1,2,3,10", -- AREA_DAMAGE
		spawn_probability                 = "1,1,0.5,0.2", -- AREA_DAMAGE
		price = 840,
		mana = 0,
		action 		= function()
		local entity_id = EntityGetWithTag("player_unit")[1]
			if entity_id ~= nil and entity_id ~= 0 then
				dofile("data/scripts/lib/utilities.lua")
				local pos_x, pos_y = EntityGetTransform( entity_id )
				local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
				local wand = EZWand.GetHeldWand()
				wand:RemoveSpells("COPIS_THINGS_UPGRADE_RELOAD_TIME")
				local rechargeTime_old = wand.rechargeTime
				wand.rechargeTime = ((wand.rechargeTime + 0.2) * 0.8) - 0.2


				wand:UpdateSprite()
				GameScreenshake(50, pos_x, pos_y)
				GamePrintImportant("Wand upgraded!", ("%.2fs"):format(rechargeTime_old/60) .. " -> " .. ("%.2fs"):format(wand.rechargeTime/60) .. " recharge time.")
			end
		end,
	},

	{
		id          = "COPIS_THINGS_UPGRADE_SPREAD_DEGREES",
		name 		= "Upgrade accuracy (One-Off)",
		author		= "Copi",
		description = "Cast inside a wand to increase the accuracy. Spell is voided upon use!",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/upgrade_spread_degrees.png",
		type 		= ACTION_TYPE_UTILITY,
		spawn_level                       = "1,2,3,10", -- AREA_DAMAGE
		spawn_probability                 = "1,1,0.5,0.2", -- AREA_DAMAGE
		price = 840,
		mana = 0,
		action 		= function()
		local entity_id = EntityGetWithTag("player_unit")[1]
			if entity_id ~= nil and entity_id ~= 0 then
				dofile("data/scripts/lib/utilities.lua")
				local pos_x, pos_y = EntityGetTransform( entity_id )
				local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
				local wand = EZWand.GetHeldWand()
				wand:RemoveSpells("COPIS_THINGS_UPGRADE_SPREAD_DEGREES")
				local spread_old = wand.rechargeTime
				wand.spread = wand.spread - ((math.abs(wand.spread) * 0.25) + 0.5)


				wand:UpdateSprite()
				GameScreenshake(50, pos_x, pos_y)
				GamePrintImportant("Wand upgraded!", tostring(rechargeTime_old) .. " -> " .. tostring(wand.spread ) .. " degrees spread.")
			end
		end,
	},

	{
		id          = "COPIS_THINGS_UPGRADE_MANA_MAX",
		name 		= "Upgrade maximum mana (One-Off)",
		author		= "Copi",
		description = "Cast inside a wand to increase it's mana capacity. Spell is voided upon use!",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/upgrade_mana_max.png",
		type 		= ACTION_TYPE_UTILITY,
		spawn_level                       = "1,2,3,10", -- AREA_DAMAGE
		spawn_probability                 = "1,1,0.5,0.2", -- AREA_DAMAGE
		price = 840,
		mana = 0,
		action 		= function()
		local entity_id = EntityGetWithTag("player_unit")[1]
			if entity_id ~= nil and entity_id ~= 0 then
				dofile("data/scripts/lib/utilities.lua")
				local pos_x, pos_y = EntityGetTransform( entity_id )
				local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
				local wand = EZWand.GetHeldWand()
				wand:RemoveSpells("COPIS_THINGS_UPGRADE_MANA_MAX")
				wand.manaMax = wand.manaMax * 1.2 + 50


				wand:UpdateSprite()
				GameScreenshake(50, pos_x, pos_y)
				GamePrintImportant("Wand upgraded!", tostring(wand.manaMax ) .. " mana capacity.")
			end
		end,
	},

	{
		id          = "COPIS_THINGS_UPGRADE_MANA_CHARGE_SPEED",
		name 		= "Upgrade mana charge speed (One-Off)",
		author		= "Copi",
		description = "Cast inside a wand to increase it's mana charge speed. Spell is voided upon use!",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/upgrade_mana_charge_speed.png",
		type 		= ACTION_TYPE_UTILITY,
		spawn_level                       = "1,2,3,10", -- AREA_DAMAGE
		spawn_probability                 = "1,1,0.5,0.2", -- AREA_DAMAGE
		price = 840,
		mana = 0,
		action 		= function()
		local entity_id = EntityGetWithTag("player_unit")[1]
			if entity_id ~= nil and entity_id ~= 0 then
				dofile("data/scripts/lib/utilities.lua")
				local pos_x, pos_y = EntityGetTransform( entity_id )
				local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
				local wand = EZWand.GetHeldWand()
				wand:RemoveSpells("COPIS_THINGS_UPGRADE_MANA_CHARGE_SPEED")
				wand.manaChargeSpeed = wand.manaChargeSpeed * 1.2 + 50


				wand:UpdateSprite()
				GameScreenshake(50, pos_x, pos_y)
				GamePrintImportant("Wand upgraded!", tostring(wand.manaChargeSpeed ) .. " mana charge speed.")
			end
		end,
	},

	{
		id          = "COPIS_THINGS_UPGRADE_GUN_ACTIONS_PERMANENT",
		name 		= "Upgrade Always Cast (One-Off)",
		author		= "Copi",
		description = "Cast inside a wand to turn it's first spell into an always cast. Spell is voided upon use!",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/upgrade_gun_action_permanent_actions.png",
		type 		= ACTION_TYPE_UTILITY,
		spawn_level                       = "1,2,3,10", -- AREA_DAMAGE
		spawn_probability                 = "1,1,0.5,0.2", -- AREA_DAMAGE
		price = 840,
		mana = 0,
		action 		= function()
		draw_actions( 1, true )
		local entity_id = EntityGetWithTag("player_unit")[1]
			if entity_id ~= nil and entity_id ~= 0 then
				dofile("data/scripts/lib/utilities.lua")
				local pos_x, pos_y = EntityGetTransform( entity_id )
				local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
				local wand = EZWand.GetHeldWand()
				local spells, attached_spells = wand:GetSpells()
				if (#spells > 0 and spells[1].action_id ~= "COPIS_THINGS_UPGRADE_GUN_ACTIONS_PERMANENT" and spells[1].action_id ~= "COPIS_THINGS_UPGRADE_GUN_ACTIONS_PERMANENT_REMOVE") then
					local action_to_attach = spells[1]
					wand:RemoveSpells("COPIS_THINGS_UPGRADE_GUN_ACTIONS_PERMANENT")
					wand:RemoveSpells(spells[1].action_id)
					wand:AttachSpells(spells[1].action_id)
					wand:UpdateSprite()
					GameScreenshake(50, pos_x, pos_y)
					GamePrintImportant("Spell attached!")
				end
			end
		end,
	},

	{
		id          = "COPIS_THINGS_UPGRADE_GUN_ACTIONS_PERMANENT_REMOVE",
		name 		= "Upgrade Remove Always Cast (One-Off)",
		author		= "Copi",
		description = "Cast inside a wand to turn it's first always cast into a spell. Spell is voided upon use!",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/upgrade_gun_action_permanent_actions_remove.png",
		type 		= ACTION_TYPE_UTILITY,
		spawn_level                       = "1,2,3,10", -- AREA_DAMAGE
		spawn_probability                 = "1,1,0.5,0.2", -- AREA_DAMAGE
		price = 840,
		mana = 0,
		action 		= function()
		draw_actions( 1, true )
		local entity_id = EntityGetWithTag("player_unit")[1]
			if entity_id ~= nil and entity_id ~= 0 then
				dofile("data/scripts/lib/utilities.lua")
				local pos_x, pos_y = EntityGetTransform( entity_id )
				local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
				local wand = EZWand.GetHeldWand()
				local spells, attached_spells = wand:GetSpells()
				if (#attached_spells > 0 and attached_spells[1].action_id ~= "COPIS_THINGS_UPGRADE_GUN_ACTIONS_PERMANENT" and wand:GetFreeSlotsCount() > 0) then
					local action_to_attach = attached_spells[1]
					wand:RemoveSpells("COPIS_THINGS_UPGRADE_GUN_ACTIONS_PERMANENT_REMOVE")
					wand:DetachSpells(attached_spells[1].action_id)
					wand:AddSpells(attached_spells[1].action_id)
					wand:UpdateSprite()
					GameScreenshake(50, pos_x, pos_y)
					GamePrintImportant("Spell extracted!")
				end
			end
		end,
	},

	{
		id          = "COPIS_THINGS_DAMAGE_MELEE",
		name 		= "Melee damage plus",
		author		= "Copi",
		description = "Increases melee the damage done by a projectile",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/damage_melee.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/damage_unidentified.png",
		related_extra_entities = { "data/entities/particles/tinyspark_yellow.xml" },
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "1,2,3,4,5", -- DAMAGE
		spawn_probability                 = "0.6,0.6,0.6,0.6,0.6", -- DAMAGE
		price = 140,
		mana = 5,
		--max_uses = 50,
		custom_xml_file = "data/entities/misc/custom_cards/damage.xml",
		action 		= function()
			c.damage_melee_add = c.damage_melee_add + 0.4
			c.gore_particles    = c.gore_particles + 5
			c.fire_rate_wait    = c.fire_rate_wait + 5
			c.extra_entities    = c.extra_entities .. "data/entities/particles/tinyspark_yellow.xml,"
			shot_effects.recoil_knockback = shot_effects.recoil_knockback + 10.0
			draw_actions( 1, true )
		end,
	},

	{
	id          = "COPIS_THINGS_DAMAGE_DRILL",
	name 		= "Drill damage plus",
	description = "Increases the drill damage done by a projectile",
	sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/damage_drill.png",
	sprite_unidentified = "data/ui_gfx/gun_actions/damage_unidentified.png",
	related_extra_entities = { "data/entities/particles/tinyspark_yellow.xml" },
	type 		= ACTION_TYPE_MODIFIER,
	spawn_level                       = "1,2,3,4,5", -- DAMAGE
	spawn_probability                 = "0.6,0.6,0.6,0.6,0.6", -- DAMAGE
	price = 140,
	mana = 5,
	--max_uses = 50,
	custom_xml_file = "data/entities/misc/custom_cards/damage.xml",
	action 		= function()
		c.damage_drill_add = c.damage_drill_add + 0.4
		c.gore_particles    = c.gore_particles + 5
		c.fire_rate_wait    = c.fire_rate_wait + 5
		c.extra_entities    = c.extra_entities .. "data/entities/particles/tinyspark_yellow.xml,"
		shot_effects.recoil_knockback = shot_effects.recoil_knockback + 10.0
		draw_actions( 1, true )
	end,

	},

	{
		id          = "COPIS_THINGS_DAMAGE_EXPLOSION",
		name 		= "Explosive damage plus",
		author		= "Copi",
		description = "Increases the explosion damage done by a projectile",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/damage_explosion.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/damage_unidentified.png",
		related_extra_entities = { "data/entities/particles/tinyspark_yellow.xml" },
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "1,2,3,4,5", -- DAMAGE
		spawn_probability                 = "0.6,0.6,0.6,0.6,0.6", -- DAMAGE
		price = 140,
		mana = 5,
		--max_uses = 50,
		custom_xml_file = "data/entities/misc/custom_cards/damage.xml",
		action 		= function()
			c.damage_explosion_add = c.damage_explosion_add + 0.4
			c.gore_particles    = c.gore_particles + 5
			c.fire_rate_wait    = c.fire_rate_wait + 5
			c.extra_entities    = c.extra_entities .. "data/entities/particles/tinyspark_yellow.xml,"
			shot_effects.recoil_knockback = shot_effects.recoil_knockback + 10.0
			draw_actions( 1, true )
		end,
	},

	{
		id          = "COPIS_THINGS_DAMAGE_SLICE",
		name 		= "Slice damage plus",
		author		= "Copi",
		description = "Increases the slice damage done by a projectile",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/damage_slice.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/damage_unidentified.png",
		related_extra_entities = { "data/entities/particles/tinyspark_yellow.xml" },
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "1,2,3,4,5", -- DAMAGE
		spawn_probability                 = "0.6,0.6,0.6,0.6,0.6", -- DAMAGE
		price = 140,
		mana = 5,
		--max_uses = 50,
		custom_xml_file = "data/entities/misc/custom_cards/damage.xml",
		action 		= function()
			c.damage_slice_add = c.damage_slice_add + 0.4
			c.gore_particles    = c.gore_particles + 5
			c.fire_rate_wait    = c.fire_rate_wait + 5
			c.extra_entities    = c.extra_entities .. "data/entities/particles/tinyspark_yellow.xml,"
			shot_effects.recoil_knockback = shot_effects.recoil_knockback + 10.0
			draw_actions( 1, true )
		end,
	},

	{
		id          = "COPIS_THINGS_DAMAGE_ELECTRICITY",
		name 		= "Electric damage plus",
		author		= "Copi",
		description = "Increases the electric damage done by a projectile",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/damage_electricity.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/damage_unidentified.png",
		related_extra_entities = { "data/entities/particles/tinyspark_yellow.xml" },
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "1,2,3,4,5", -- DAMAGE
		spawn_probability                 = "0.6,0.6,0.6,0.6,0.6", -- DAMAGE
		price = 140,
		mana = 5,
		--max_uses = 50,
		custom_xml_file = "data/entities/misc/custom_cards/damage.xml",
		action 		= function()
			c.damage_electricity_add = c.damage_electricity_add + 0.4
			c.gore_particles    = c.gore_particles + 5
			c.fire_rate_wait    = c.fire_rate_wait + 5
			c.extra_entities    = c.extra_entities .. "data/entities/particles/tinyspark_yellow.xml,"
			shot_effects.recoil_knockback = shot_effects.recoil_knockback + 10.0
			draw_actions( 1, true )
		end,
	},

	{
		id          = "COPIS_THINGS_DAMAGE_FREEZE",
		name 		= "Freeze damage plus",
		author		= "Copi",
		description = "Increases the freeze damage done by a projectile",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/damage_freeze.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/damage_unidentified.png",
		related_extra_entities = { "data/entities/particles/tinyspark_yellow.xml" },
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "1,2,3,4,5", -- DAMAGE
		spawn_probability                 = "0.6,0.6,0.6,0.6,0.6", -- DAMAGE
		price = 140,
		mana = 5,
		--max_uses = 50,
		custom_xml_file = "data/entities/misc/custom_cards/damage.xml",
		action 		= function()
			c.damage_ice_add = c.damage_ice_add + 0.4
			c.gore_particles    = c.gore_particles + 5
			c.fire_rate_wait    = c.fire_rate_wait + 5
			c.extra_entities    = c.extra_entities .. "data/entities/particles/tinyspark_yellow.xml,"
			shot_effects.recoil_knockback = shot_effects.recoil_knockback + 10.0
			draw_actions( 1, true )
		end,
	},

	{
		id          = "COPIS_THINGS_DAMAGE_CURSE",
		name 		= "Curse damage plus",
		author		= "Copi",
		description = "Increases the curse damage done by a projectile",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/damage_curse.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/damage_unidentified.png",
		related_extra_entities = { "data/entities/particles/tinyspark_yellow.xml" },
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "1,2,3,4,5", -- DAMAGE
		spawn_probability                 = "0.6,0.6,0.6,0.6,0.6", -- DAMAGE
		price = 140,
		mana = 5,
		--max_uses = 50,
		custom_xml_file = "data/entities/misc/custom_cards/damage.xml",
		action 		= function()
			c.damage_curse_add = c.damage_curse_add + 0.4
			c.gore_particles    = c.gore_particles + 5
			c.fire_rate_wait    = c.fire_rate_wait + 5
			c.extra_entities    = c.extra_entities .. "data/entities/particles/tinyspark_yellow.xml,"
			shot_effects.recoil_knockback = shot_effects.recoil_knockback + 10.0
			draw_actions( 1, true )
		end,
	},

	{
		id          = "COPIS_THINGS_DAMAGE_FIRE",
		name 		= "Fire damage plus",
		author		= "Copi",
		description = "Increases the fire damage done by a projectile",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/damage_fire.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/damage_unidentified.png",
		related_extra_entities = { "data/entities/particles/tinyspark_yellow.xml" },
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "1,2,3,4,5", -- DAMAGE
		spawn_probability                 = "0.6,0.6,0.6,0.6,0.6", -- DAMAGE
		price = 140,
		mana = 5,
		--max_uses = 50,
		custom_xml_file = "data/entities/misc/custom_cards/damage.xml",
		action 		= function()
			c.damage_fire_add = c.damage_fire_add + 0.4
			c.gore_particles    = c.gore_particles + 5
			c.fire_rate_wait    = c.fire_rate_wait + 5
			c.extra_entities    = c.extra_entities .. "data/entities/particles/tinyspark_yellow.xml,"
			shot_effects.recoil_knockback = shot_effects.recoil_knockback + 10.0
			draw_actions( 1, true )
		end,
	},

	{
		id          = "COPIS_THINGS_DAMAGE_MINUS",
		name 		= "Damage Minus",
		author		= "Copi",
		description = "Decreases the damage done by a projectile",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/damage_minus.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/damage_unidentified.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "2,3,4,5", -- DAMAGE
		spawn_probability                 = "0.3,0.3,0.3,0.3", -- DAMAGE
		price = 50,
		mana = -20,
		--max_uses = 50,
		action 		= function()
			c.damage_projectile_add = c.damage_projectile_add - 0.2
			c.gore_particles    = c.gore_particles - 5
			c.fire_rate_wait    = c.fire_rate_wait - 2.5
			shot_effects.recoil_knockback = shot_effects.recoil_knockback - 10.0
			draw_actions( 1, true )
		end,
	},

	{
		id          = "COPIS_THINGS_DAMAGE_TO_CURSE",
		name 		= "Damage to Curse",
		author		= "Copi",
		description = "Converts 80% of projectile damage to curse damage",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/damage_to_curse.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "1,2,4,5,10", -- MATTER_EATER
		spawn_probability                 = "0.1,1,0.1,0.1,0.2", -- MATTER_EATER
		price = 280,
		mana = 30,
		action 		= function()
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/damage_to_curse.xml,"
			draw_actions( 1, true )
		end,
	},

	{
		id          = "COPIS_THINGS_DAMAGE_LIFETIME",
		name 		= "Damage growth",
		author		= "Copi",
		description = "Causes your projectile to gain damage the longer it's alive",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/damage_lifetime.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "1,2,4,5,10", -- MATTER_EATER
		spawn_probability                 = "0.1,1,0.1,0.1,0.2", -- MATTER_EATER
		price = 280,
		mana = 30,
		action 		= function()
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/damage_lifetime.xml,"
			draw_actions( 1, true )
		end,
	},

	{
		id          = "COPIS_THINGS_INFINITE_LIFETIME",
		name 		= "Infinite Lifetime",
		author		= "Copi",
		description = "Causes your projectile to last forever, but drain your wand's mana. Projectile expires when you run out of mana.",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/lifetime_infinite.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/electric_charge_unidentified.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "1,2,4,5,10", -- MATTER_EATER
		spawn_probability                 = "0.1,1,0.1,0.1,0.2", -- MATTER_EATER
		price = 280,
		mana = 60,
		action 		= function()
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/infinite_lifetime.xml,"
			draw_actions( 1, true )
		end,
	},

	{
		id          = "COPIS_THINGS_OSCILLATING_SPEED",
		name 		= "Oscillating Speed",
		author		= "Copi",
		description = "Decreases the speed at which a projectile flies through the air",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/oscillating_speed.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level			               = "1,2,3", -- SPEED
		spawn_probability	               = "1,0.5,0.5", -- SPEED
		price = 80,
		mana = 2,
		--max_uses = 100,
		action				= function()
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/oscillating_speed.xml,"
			c.spread_degrees = c.spread_degrees - 8
			draw_actions( 1, true )
		end,
	},

	{
		id          = "COPIS_THINGS_HITFX_CRITICAL_DRUNK",
		name 		= "Critical on drunk enemies",
		author		= "Copi",
		description = "Makes a projectile always do a critical hit on drunk enemies",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/crit_on_alcoholic.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level			               = "1,3,4,5", -- HITFX_CRITICAL_WATER
		spawn_probability	               = "0.2,0.2,0.2,0.2", -- HITFX_CRITICAL_WATER
		price = 70,
		mana = 10,
		--max_uses = 50,
		action				= function()
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/crit_on_alcoholic.xml,"
			draw_actions( 1, true )
		end,
	},

	{
		id          = "COPIS_THINGS_HITFX_CRITICAL_CHARM",
		name 		= "Critical on charmed enemies",
		author		= "Copi",
		description = "Makes a projectile always do a critical hit on charmed enemies",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/crit_on_charm.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level			               = "1,3,4,5", -- HITFX_CRITICAL_WATER
		spawn_probability	               = "0.2,0.2,0.2,0.2", -- HITFX_CRITICAL_WATER
		price = 70,
		mana = 10,
		--max_uses = 50,
		action				= function()
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/crit_on_charm.xml,"
			draw_actions( 1, true )
		end,
	},

	{
		id          = "COPIS_THINGS_HITFX_CRITICAL_CONFUSION",
		name 		= "Critical on confused enemies",
		author		= "Copi",
		description = "Makes a projectile always do a critical hit on confused enemies",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/crit_on_confusion.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level			               = "1,3,4,5", -- HITFX_CRITICAL_WATER
		spawn_probability	               = "0.2,0.2,0.2,0.2", -- HITFX_CRITICAL_WATER
		price = 70,
		mana = 10,
		--max_uses = 50,
		action				= function()
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/crit_on_confusion.xml,"
			draw_actions( 1, true )
		end,
	},

	{
		id          = "COPIS_THINGS_HITFX_CRITICAL_ELECTROCUTED",
		name 		= "Critical on electrocuted enemies",
		author		= "Copi",
		description = "Makes a projectile always do a critical hit on electrocuted enemies",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/crit_on_electrocuted.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level			               = "1,3,4,5", -- HITFX_CRITICAL_WATER
		spawn_probability	               = "0.2,0.2,0.2,0.2", -- HITFX_CRITICAL_WATER
		price = 70,
		mana = 10,
		--max_uses = 50,
		action				= function()
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/crit_on_electrocuted.xml,"
			draw_actions( 1, true )
		end,
	},

	{
		id          = "COPIS_THINGS_HITFX_CRITICAL_FROZEN",
		name 		= "Critical on frozen enemies",
		author		= "Copi",
		description = "Makes a projectile always do a critical hit on frozen enemies",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/crit_on_frozen.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level			               = "1,3,4,5", -- HITFX_CRITICAL_WATER
		spawn_probability	               = "0.2,0.2,0.2,0.2", -- HITFX_CRITICAL_WATER
		price = 70,
		mana = 10,
		--max_uses = 50,
		action				= function()
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/crit_on_frozen.xml,"
			draw_actions( 1, true )
		end,
	},

	{
		id          = "COPIS_THINGS_RECHARGE_2",
		name 		= "Reduce recharge time II",
		author		= "Copi",
		description = "Reduces the time between spellcasts heavily",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/recharge_2.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level			               = "1,2,3,4,5,6", -- RECHARGE
		spawn_probability	               = "0.5,0.5,0.5,0.5,0.5,0.5", -- RECHARGE
		price = 400,
		mana = 24,
		--max_uses = 75,
		action				= function()
			c.fire_rate_wait    = c.fire_rate_wait - 20
			current_reload_time = current_reload_time - 40
			draw_actions( 1, true )
		end,
	},

	{
		id          = "COPIS_THINGS_RECHARGE_3",
		name 		= "Reduce recharge time III",
		author		= "Copi",
		description = "Reduces the time between spellcasts immensely",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/recharge_3.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level			               = "1,2,3,4,5,6", -- RECHARGE
		spawn_probability	               = "0.33,0.33,0.33,0.33,0.33,0.33", -- RECHARGE
		price = 600,
		mana = 48,
		--max_uses = 50,
		action				= function()
			c.fire_rate_wait    = c.fire_rate_wait - 30
			current_reload_time = current_reload_time - 60
			draw_actions( 1, true )
		end,
	},

	{
		id          = "COPIS_THINGS_RECHARGE_DELAY_UP",
		name 		= "Delayed recharge",
		author		= "Copi",
		description = "Sharply reduces wand recharge speed at the cost of cast delay",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/recharge_delay_up.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level			               = "1,2,3,4,5,6", -- RECHARGE
		spawn_probability	               = "0.1,0.1,0.1,0.1,0.1,0.1", -- RECHARGE
		price = 400,
		mana = 24,
		action				= function()
			c.fire_rate_wait    = c.fire_rate_wait + 60
			current_reload_time = current_reload_time - 80
			draw_actions( 1, true )
		end,
	},

	{
		id          = "COPIS_THINGS_RECHARGE_DELAY_DOWN",
		name 		= "Rushing recharge",
		author		= "Copi",
		description = "Sharply reduces cast delay between spells at the cost of wand recharge speed",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/recharge_delay_down.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level			               = "1,2,3,4,5,6", -- RECHARGE
		spawn_probability	               = "0.1,0.1,0.1,0.1,0.1,0.1", -- RECHARGE
		price = 400,
		mana = 24,
		action				= function()
			c.fire_rate_wait    = c.fire_rate_wait - 80
			current_reload_time = current_reload_time + 60
			draw_actions( 1, true )
		end,
	},

	{
		id          = "COPIS_THINGS_ARCANE_RECHARGE",
		name 		= "Arcane Recharge",
		author		= "Copi",
		description = "Slightly reduce the time between spellcasts, but gain mana when casting",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/arcane_recharge.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level			               = "1,2,3,4,5,6", -- RECHARGE
		spawn_probability	               = "0.1,0.1,0.1,0.1,0.1,0.1", -- RECHARGE
		price = 400,
		mana = -12,
		action				= function()
			c.fire_rate_wait    = c.fire_rate_wait - 5
			current_reload_time = current_reload_time - 10
			draw_actions( 1, true )
		end,
	},

	{
		id					= "COPIS_THINGS_PASSIVE_RECHARGE",
		name				= "Passive Recharge",
		author		= "Copi",
		description			= "Your wand recharges faster!",
		sprite      	   = "mods/copis_things/files/ui_gfx/gun_actions/passive_recharge.png",
		type        		= ACTION_TYPE_PASSIVE,
		spawn_level			               = "1,2,3,4,5,6", -- RECHARGE
		spawn_probability	               = "0.5,0.5,0.5,0.5,0.5,0.5", -- RECHARGE
		price				= 200,
		mana				= 0,
		custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/passive_recharge.xml",
		action = function()
			draw_actions( 1, true )
		end
	},

	{
		id          = "COPIS_THINGS_MANA_REDUCE_2",
		name 		= "Add mana II",
		author		= "Copi",
		description = "Adds 60 mana to the wand",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/mana_2.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level			               = "1,2,3,4,5,6", -- MANA_REDUCE
		spawn_probability	               = "0.5,0.5,0.5,0.5,0.5,0.5", -- MANA_REDUCE
		price = 500,
		mana = -60,
		--max_uses = 75,
		custom_xml_file = "data/entities/misc/custom_cards/mana_reduce.xml",
		action				= function()
			c.fire_rate_wait = c.fire_rate_wait + 20
			draw_actions( 1, true )
		end,
	},

	{
		id          = "COPIS_THINGS_MANA_REDUCE_3",
		name 		= "Add mana III",
		author		= "Copi",
		description = "Adds 90 mana to the wand",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/mana_3.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level			               = "1,2,3,4,5,6", -- MANA_REDUCE
		spawn_probability	               = "0.33,0.33,0.33,0.33,0.33,0.33", -- MANA_REDUCE
		price = 750,
		mana = -90,
		--max_uses = 50,
		custom_xml_file = "data/entities/misc/custom_cards/mana_reduce.xml",
		action				= function()
			c.fire_rate_wait = c.fire_rate_wait + 30
			draw_actions( 1, true )
		end,
	},

	{
		id					= "COPIS_THINGS_PASSIVE_MANA",
		name				= "Passive Mana",
		author		= "Copi",
		description			= "Your wand regenerates mana faster!",
		sprite      	   = "mods/copis_things/files/ui_gfx/gun_actions/passive_mana.png",
		type        		= ACTION_TYPE_PASSIVE,
		spawn_level			               = "1,2,3,4,5,6", -- RECHARGE
		spawn_probability	               = "0.5,0.5,0.5,0.5,0.5,0.5", -- RECHARGE
		price				= 200,
		mana				= 0,
		custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/passive_mana.xml",
		action = function()
			draw_actions( 1, true )
		end
	},

	{
		id					= "COPIS_THINGS_SUMMON_BOSS_CENTIPEDE",
		name				= "Summon Kolmisilmä",
		author		= "Copi",
		description			= "Summons Kolmisilmä.",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/summon_boss_centipede.png",
		type				= ACTION_TYPE_UTILITY,
		spawn_level			= "0,0",
		spawn_probability	= "0,0",
		price				= 0,
		mana				= 1500,
		max_uses			= 1,
		action				= function()
		add_projectile("data/entities/animals/boss_centipede/boss_centipede.xml")
		c.fire_rate_wait = c.fire_rate_wait + 150
		current_reload_time = current_reload_time + 40
		end,
	},

	{
		id					= "COPIS_THINGS_SUMMON_BOSS_WIZARD",
		name				= "Summon Mestarien mestari",
		author		= "Copi",
		description			= "Summons Mestarien mestari.",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/summon_boss_wizard.png",
		type				= ACTION_TYPE_UTILITY,
		spawn_level			= "0,0",
		spawn_probability	= "0,0",
		price				= 0,
		mana				= 1500,
		max_uses			= 1,
		action				= function()
		add_projectile("data/entities/animals/boss_wizard/boss_wizard.xml")
		c.fire_rate_wait = c.fire_rate_wait + 150
		current_reload_time = current_reload_time + 40
		end,
	},

	{
		id					= "COPIS_THINGS_SUMMON_BOSS_ALCHEMIST",
		name				= "Summon Ylialkemisti",
		author		= "Copi",
		description			= "Summons Ylialkemisti.",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/summon_boss_alchemist.png",
		type				= ACTION_TYPE_UTILITY,
		spawn_level			= "0,0",
		spawn_probability	= "0,0",
		price				= 0,
		mana				= 1500,
		max_uses			= 1,
		action				= function()
		add_projectile("data/entities/animals/boss_alchemist/boss_alchemist.xml")
		c.fire_rate_wait = c.fire_rate_wait + 150
		current_reload_time = current_reload_time + 40
		end,
	},

	{
		id					= "COPIS_THINGS_SUMMON_BOSS_DRAGON",
		name				= "Summon Suomuhauki",
		author		= "Copi",
		description			= "Summons Suomuhauki.",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/summon_boss_dragon.png",
		type				= ACTION_TYPE_UTILITY,
		spawn_level			= "0,0",
		spawn_probability	= "0,0",
		price				= 0,
		mana				= 1500,
		max_uses			= 1,
		action				= function()
		add_projectile("data/entities/animals/boss_dragon.xml")
		c.fire_rate_wait = c.fire_rate_wait + 150
		current_reload_time = current_reload_time + 40
		end,
	},

	{
		id					= "COPIS_THINGS_SUMMON_BOSS_GHOST",
		name				= "Summon Ylialkemisti",
		author		= "Copi",
		description			= "Summons Ylialkemisti.",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/summon_boss_ghost.png",
		type				= ACTION_TYPE_UTILITY,
		spawn_level			= "0,0",
		spawn_probability	= "0,0",
		price				= 0,
		mana				= 1500,
		max_uses			= 1,
		action				= function()
		add_projectile("data/entities/animals/boss_ghost/boss_ghost.xml")
		c.fire_rate_wait = c.fire_rate_wait + 150
		current_reload_time = current_reload_time + 40
		end,
	},

	{
		id					= "COPIS_THINGS_SUMMON_BOSS_PIT",
		name				= "Summon Sauvojen Tuntija",
		author		= "Copi",
		description			= "Summons Sauvojen Tuntija.",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/summon_boss_pit.png",
		type				= ACTION_TYPE_UTILITY,
		spawn_level			= "0,0",
		spawn_probability	= "0,0",
		price				= 0,
		mana				= 1500,
		max_uses			= 1,
	action				= function()
		add_projectile("data/entities/animals/boss_pit/boss_pit.xml")
		c.fire_rate_wait = c.fire_rate_wait + 150
		current_reload_time = current_reload_time + 40
		end,
	},

	{
		id					= "COPIS_THINGS_SUMMON_BOSS_LIMBS",
		name				= "Summon Kolmisilmän Koipi",
		author		= "Copi",
		description			= "Summons Kolmisilmän Koipi.",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/summon_boss_limbs.png",
		type				= ACTION_TYPE_UTILITY,
		spawn_level			= "0,0",
		spawn_probability	= "0,0",
		price				= 0,
		mana				= 1500,
		max_uses			= 1,
		action				= function()
		add_projectile("data/entities/animals/boss_limbs/boss_limbs.xml")
		c.fire_rate_wait = c.fire_rate_wait + 150
		current_reload_time = current_reload_time + 40
		end,
	},

	{
		id					= "COPIS_THINGS_SUMMON_BOSS_ROBOT",
		name				= "Summon Kolmisilmän silmä",
		author		= "Copi",
		description			= "Summons Kolmisilmän Koipi.",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/summon_boss_robot.png",
		type				= ACTION_TYPE_UTILITY,
		spawn_level			= "0,0",
		spawn_probability	= "0,0",
		price				= 0,
		mana				= 1500,
		max_uses			= 1,
		action				= function()
		add_projectile("data/entities/animals/boss_robot/boss_robot.xml")
		c.fire_rate_wait = c.fire_rate_wait + 150
		current_reload_time = current_reload_time + 40
		end,
	},

	{
		id					= "COPIS_THINGS_SUMMON_MAGGOT_TINY",
		name				= "Summon Limatoukka",
		author		= "Copi",
		description			= "Summons Limatoukka.",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/summon_maggot_tiny.png",
		type				= ACTION_TYPE_UTILITY,
		spawn_level			= "0,0",
		spawn_probability	= "0,0",
		price				= 0,
		mana				= 1500,
		max_uses			= 1,
		action				= function()
		add_projectile("data/entities/animals/maggot_tiny/maggot_tiny.xml")
		c.fire_rate_wait = c.fire_rate_wait + 150
		current_reload_time = current_reload_time + 40
		end,
	},

	{
		id					= "COPIS_THINGS_SUMMON_FLASK",
		name				= "Summon flask",
		author		= "Copi",
		description			= "Summons an empty flask",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/summon_flask.png",
		type				= ACTION_TYPE_UTILITY,
		spawn_level			= "2,		3,		4,		5,		6",
		spawn_probability	= "0.25,	0.33,	0.50,	0.33,	0.25",
		price				= 200,
		mana				= 90,
		max_uses			= 1,
		action				= function()
			c.fire_rate_wait    = c.fire_rate_wait + 20
			current_reload_time = current_reload_time + 40
			add_projectile("data/entities/items/pickup/potion_empty.xml")
		end,
	},

	{
		id					= "COPIS_THINGS_SUMMON_FLASK_FULL",
		name				= "Summon filled flask",
		author		= "Copi",
		description			= "Summons a flask filled with a random material",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/summon_flask_full.png",
		type				= ACTION_TYPE_UTILITY,
		spawn_level			= "2,		3,		4,		5,		6",
		spawn_probability	= "0.125,	0.17,	0.25,	0.17,	0.125",
		price				= 300,
		mana				= 120,
		max_uses			= 1,
		action				= function()
			c.fire_rate_wait    = c.fire_rate_wait + 20
			current_reload_time = current_reload_time + 40
			add_projectile("data/entities/items/pickup/potion_random_material.xml")
		end,
	},

	{
		id					= "COPIS_THINGS_SUMMON_JAR",
		name				= "Summon jar",
		author		= "Copi",
		description			= "Summons an empty jar",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/summon_jar.png",
		type				= ACTION_TYPE_UTILITY,
		spawn_level			= "2,		3,		4,		5,		6",
		spawn_probability	= "0.050,	0.067,	0.100,	0.067,	0.050",
		price				= 200,
		mana				= 90,
		max_uses			= 1,
		action				= function()
			c.fire_rate_wait    = c.fire_rate_wait + 20
			current_reload_time = current_reload_time + 40
			add_projectile("data/entities/items/pickup/jar.xml")
		end,
	},

	{
		id					= "COPIS_THINGS_SUMMON_JAR_URINE",
		name				= "Jarate",
		author		= "Copi",
		description			= "Jar-based Karate",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/summon_jar_urine.png",
		type				= ACTION_TYPE_UTILITY,
		spawn_level			= "2,		3,		4,		5,		6",
		spawn_probability	= "0.025,	0.033,	0.050,	0.033,	0.025",
		price				= 200,
		mana				= 45,
		max_uses			= 30,
		action				= function()
			c.fire_rate_wait    = c.fire_rate_wait + 10
			current_reload_time = current_reload_time + 20
			add_projectile("data/entities/items/pickup/jar_of_urine.xml")
		end,
	},

	{
		id					= "COPIS_THINGS_SUMMON_SUN",
		name				= "Summon Sun",
		author		= "Copi",
		description			= "Summons the sun.",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/summon_sun.png",
		type				= ACTION_TYPE_UTILITY,
		spawn_level			= "0,0",
		spawn_probability	= "0,0",
		price				= 0,
		mana				= 3000,
		action				= function()
		add_projectile("data/entities/items/pickup/sun/newsun.xml")
		c.fire_rate_wait = c.fire_rate_wait + 150
		current_reload_time = current_reload_time + 40
		end,
	},

	{
		id					= "COPIS_THINGS_SUMMON_DARK_SUN",
		name				= "Summon Dark Sun",
		author		= "Copi",
		description			= "Summons the dark sun.",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/summon_dark_sun.png",
		type				= ACTION_TYPE_UTILITY,
		spawn_level			= "0,0",
		spawn_probability	= "0,0",
		price				= 0,
		mana				= 3000,
		action				= function()
		add_projectile("data/entities/items/pickup/sun/newsun_dark.xml")
		c.fire_rate_wait = c.fire_rate_wait + 150
		current_reload_time = current_reload_time + 40
		end,
	},

	{
		id					= "COPIS_THINGS_BUFF_BERSERK",
		name				= "Status: Berserk",
		author		= "Copi",
		description			= "Applies the berserk status to you for a short time",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/buff_berserk.png",
		type				= ACTION_TYPE_UTILITY,
		spawn_level			= "2,		3,		4,		5,		6",
		spawn_probability	= "0.25,	0.33,	0.50,	0.33,	0.25",
		price				= 200,
		mana				= 120,
		max_uses			= 10,
		action				= function()
			c.fire_rate_wait    = c.fire_rate_wait + 20
			current_reload_time = current_reload_time + 40
			local entity_id = EntityGetWithTag("player_unit")[1]
			if entity_id ~= nil and entity_id ~= 0 then
				local px, py = EntityGetTransform( entity_id )
				local effect_id = EntityLoad( "mods/copis_things/files/entities/misc/status_entities/buff_berserk.xml", px, py )
				EntityAddChild( entity_id, effect_id )
				end
			end,
	},

	{
		id					= "COPIS_THINGS_BUFF_BOUNCE",
		name				= "Status: Bouncing Shots",
		author		= "Copi",
		description			= "Applies the bouncing shots status to you for a short time",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/buff_bounce.png",
		type				= ACTION_TYPE_UTILITY,
		spawn_level			= "2,		3,		4,		5,		6",
		spawn_probability	= "0.25,	0.33,	0.50,	0.33,	0.25",
		price				= 200,
		mana				= 120,
		max_uses			= 10,
		action				= function()
			c.fire_rate_wait    = c.fire_rate_wait + 20
			current_reload_time = current_reload_time + 40
			local entity_id = EntityGetWithTag("player_unit")[1]
			if entity_id ~= nil and entity_id ~= 0 then
				local px, py = EntityGetTransform( entity_id )
				local effect_id = EntityLoad( "mods/copis_things/files/entities/misc/status_entities/buff_bounce.xml", px, py )
				EntityAddChild( entity_id, effect_id )
				end
			end,
	},

	{
		id					= "COPIS_THINGS_BUFF_DAMAGE_PLUS",
		name				= "Status: Damage plus",
		author		= "Copi",
		description			= "Applies the damage plus status to you for a short time",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/buff_damage_plus.png",
		type				= ACTION_TYPE_UTILITY,
		spawn_level			= "2,		3,		4,		5,		6",
		spawn_probability	= "0.25,	0.33,	0.50,	0.33,	0.25",
		price				= 200,
		mana				= 120,
		max_uses			= 10,
		action				= function()
			c.fire_rate_wait    = c.fire_rate_wait + 20
			current_reload_time = current_reload_time + 40
			local entity_id = EntityGetWithTag("player_unit")[1]
			if entity_id ~= nil and entity_id ~= 0 then
				local px, py = EntityGetTransform( entity_id )
				local effect_id = EntityLoad( "mods/copis_things/files/entities/misc/status_entities/buff_damage_plus.xml", px, py )
				EntityAddChild( entity_id, effect_id )
				end
			end,
	},

	{
		id					= "COPIS_THINGS_BUFF_EDIT_WANDS_EVERYWHERE",
		name				= "Status: Tinker with wands",
		author		= "Copi",
		description			= "Applies the tinker with wands status to you for a short time",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/buff_edit_wands_everywhere.png",
		type				= ACTION_TYPE_UTILITY,
		spawn_level			= "2,		3,		4,		5,		6",
		spawn_probability	= "0.125,	0.17,	0.25,	0.083,	0.125",
		price				= 200,
		mana				= 120,
		max_uses			= 10,
		action				= function()
			c.fire_rate_wait    = c.fire_rate_wait + 20
			current_reload_time = current_reload_time + 40
			local entity_id = EntityGetWithTag("player_unit")[1]
			if entity_id ~= nil and entity_id ~= 0 then
				local px, py = EntityGetTransform( entity_id )
				local effect_id = EntityLoad( "mods/copis_things/files/entities/misc/status_entities/buff_edit_wands_everywhere.xml", px, py )
				EntityAddChild( entity_id, effect_id )
				end
			end,
	},

	{
		id					= "COPIS_THINGS_BUFF_FASTER_LEVITATION",
		name				= "Status: Faster levitiation",
		author		= "Copi",
		description			= "Applies the faster levitation status to you for a short time",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/buff_faster_levitation.png",
		type				= ACTION_TYPE_UTILITY,
		spawn_level			= "2,		3,		4,		5,		6",
		spawn_probability	= "0.25,	0.33,	0.50,	0.33,	0.25",
		price				= 200,
		mana				= 120,
		max_uses			= 10,
		action				= function()
			c.fire_rate_wait    = c.fire_rate_wait + 20
			current_reload_time = current_reload_time + 40
			local entity_id = EntityGetWithTag("player_unit")[1]
			if entity_id ~= nil and entity_id ~= 0 then
				local px, py = EntityGetTransform( entity_id )
				local effect_id = EntityLoad( "mods/copis_things/files/entities/misc/status_entities/buff_faster_levitation.xml", px, py )
				EntityAddChild( entity_id, effect_id )
				end
			end,
	},

	{
		id					= "COPIS_THINGS_BUFF_HOMING",
		name				= "Status: Homing shots",
		author		= "Copi",
		description			= "Applies the homing shots status to you for a short time",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/buff_homing.png",
		type				= ACTION_TYPE_UTILITY,
		spawn_level			= "2,		3,		4,		5,		6",
		spawn_probability	= "0.25,	0.33,	0.50,	0.33,	0.25",
		price				= 200,
		mana				= 120,
		max_uses			= 10,
		action				= function()
			c.fire_rate_wait    = c.fire_rate_wait + 20
			current_reload_time = current_reload_time + 40
			local entity_id = EntityGetWithTag("player_unit")[1]
			if entity_id ~= nil and entity_id ~= 0 then
				local px, py = EntityGetTransform( entity_id )
				local effect_id = EntityLoad( "mods/copis_things/files/entities/misc/status_entities/buff_homing.xml", px, py )
				EntityAddChild( entity_id, effect_id )
				end
			end,
	},

	{
		id					= "COPIS_THINGS_BUFF_HP_REGENERATION",
		name				= "Status: Health regeneration",
		author		= "Copi",
		description			= "Applies the health regeneration status to you for a short time",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/buff_hp_regeneration.png",
		type				= ACTION_TYPE_UTILITY,
		spawn_level			= "2,		3,		4,		5,		6",
		spawn_probability	= "0.125,	0.17,	0.25,	0.17,	0.125",
		price				= 200,
		mana				= 120,
		max_uses			= 10,
		action				= function()
			c.fire_rate_wait    = c.fire_rate_wait + 20
			current_reload_time = current_reload_time + 40
			local entity_id = EntityGetWithTag("player_unit")[1]
			if entity_id ~= nil and entity_id ~= 0 then
				local px, py = EntityGetTransform( entity_id )
				local effect_id = EntityLoad( "mods/copis_things/files/entities/misc/status_entities/buff_hp_regeneration.xml", px, py )
				EntityAddChild( entity_id, effect_id )
				end
			end,
	},

	{
		id					= "COPIS_THINGS_BUFF_INVISIBILITY",
		name				= "Status: Invisibility",
		author		= "Copi",
		description			= "Applies the invisibility status to you for a short time",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/buff_invisibility.png",
		type				= ACTION_TYPE_UTILITY,
		spawn_level			= "2,		3,		4,		5,		6",
		spawn_probability	= "0.25,	0.33,	0.50,	0.33,	0.25",
		price				= 200,
		mana				= 120,
		max_uses			= 10,
		action				= function()
			c.fire_rate_wait    = c.fire_rate_wait + 20
			current_reload_time = current_reload_time + 40
			local entity_id = EntityGetWithTag("player_unit")[1]
			if entity_id ~= nil and entity_id ~= 0 then
				local px, py = EntityGetTransform( entity_id )
				local effect_id = EntityLoad( "mods/copis_things/files/entities/misc/status_entities/buff_invisibility.xml", px, py )
				EntityAddChild( entity_id, effect_id )
				end
			end,
	},

	{
		id					= "COPIS_THINGS_BUFF_MANA_REGENERATION",
		name				= "Status: Mana regeneration",
		author		= "Copi",
		description			= "Applies the mana regeneration status to you for a short time",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/buff_mana_regeneration.png",
		type				= ACTION_TYPE_UTILITY,
		spawn_level			= "2,		3,		4,		5,		6",
		spawn_probability	= "0.25,	0.33,	0.50,	0.33,	0.25",
		price				= 200,
		mana				= 120,
		max_uses			= 10,
		action				= function()
			c.fire_rate_wait    = c.fire_rate_wait + 20
			current_reload_time = current_reload_time + 40
			local entity_id = EntityGetWithTag("player_unit")[1]
			if entity_id ~= nil and entity_id ~= 0 then
				local px, py = EntityGetTransform( entity_id )
				local effect_id = EntityLoad( "mods/copis_things/files/entities/misc/status_entities/buff_mana_regeneration.xml", px, py )
				EntityAddChild( entity_id, effect_id )
				end
			end,
	},

	{
		id					= "COPIS_THINGS_BUFF_MOVEMENT_FASTER",
		name				= "Status: Greased lightning",
		author		= "Copi",
		description			= "Applies the greased lightning status to you for a short time",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/buff_movement_faster.png",
		type				= ACTION_TYPE_UTILITY,
		spawn_level			= "2,		3,		4,		5,		6",
		spawn_probability	= "0.25,	0.33,	0.50,	0.33,	0.25",
		price				= 200,
		mana				= 120,
		max_uses			= 10,
		action				= function()
			c.fire_rate_wait    = c.fire_rate_wait + 20
			current_reload_time = current_reload_time + 40
			local entity_id = EntityGetWithTag("player_unit")[1]
			if entity_id ~= nil and entity_id ~= 0 then
				local px, py = EntityGetTransform( entity_id )
				local effect_id = EntityLoad( "mods/copis_things/files/entities/misc/status_entities/buff_movement_faster.xml", px, py )
				EntityAddChild( entity_id, effect_id )
				end
			end,
	},

	{
		id					= "COPIS_THINGS_BUFF_NIGHTVISION",
		name				= "Status: Wormy vision",
		author		= "Copi",
		description			= "Applies the wormy vision status to you for a short time",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/buff_nightvision.png",
		type				= ACTION_TYPE_UTILITY,
		spawn_level			= "2,		3,		4,		5,		6",
		spawn_probability	= "0.125,	0.17,	0.25,	0.17,	0.125",
		price				= 200,
		mana				= 120,
		max_uses			= 10,
		action				= function()
			c.fire_rate_wait    = c.fire_rate_wait + 20
			current_reload_time = current_reload_time + 40
			local entity_id = EntityGetWithTag("player_unit")[1]
			if entity_id ~= nil and entity_id ~= 0 then
				local px, py = EntityGetTransform( entity_id )
				local effect_id = EntityLoad( "mods/copis_things/files/entities/misc/status_entities/buff_nightvision.xml", px, py )
				EntityAddChild( entity_id, effect_id )
				end
			end,
	},

	{
		id					= "COPIS_THINGS_BUFF_PROTECTION_ALL",
		name				= "Status: Immunity",
		author		= "Copi",
		description			= "Applies the immunity status to you for a short time",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/buff_protection_all.png",
		type				= ACTION_TYPE_UTILITY,
		spawn_level			= "2,		3,		4,		5,		6",
		spawn_probability	= "0.125,	0.17,	0.25,	0.17,	0.125",
		price				= 200,
		mana				= 120,
		max_uses			= 10,
		action				= function()
			c.fire_rate_wait    = c.fire_rate_wait + 20
			current_reload_time = current_reload_time + 40
			local entity_id = EntityGetWithTag("player_unit")[1]
			if entity_id ~= nil and entity_id ~= 0 then
				local px, py = EntityGetTransform( entity_id )
				local effect_id = EntityLoad( "mods/copis_things/files/entities/misc/status_entities/buff_protection_all.xml", px, py )
				EntityAddChild( entity_id, effect_id )
				end
			end,
	},

	{
		id					= "COPIS_THINGS_BUFF_RECHARGE",
		name				= "Status: Reduced recharge",
		author		= "Copi",
		description			= "Applies the reduced recharge status to you for a short time",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/buff_recharge.png",
		type				= ACTION_TYPE_UTILITY,
		spawn_level			= "2,		3,		4,		5,		6",
		spawn_probability	= "0.25,	0.33,	0.50,	0.33,	0.25",
		price				= 200,
		mana				= 120,
		max_uses			= 10,
		action				= function()
			c.fire_rate_wait    = c.fire_rate_wait + 20
			current_reload_time = current_reload_time + 40
			local entity_id = EntityGetWithTag("player_unit")[1]
			if entity_id ~= nil and entity_id ~= 0 then
				local px, py = EntityGetTransform( entity_id )
				local effect_id = EntityLoad( "mods/copis_things/files/entities/misc/status_entities/buff_recharge.xml", px, py )
				EntityAddChild( entity_id, effect_id )
				end
			end,
	},

	{
		id					= "COPIS_THINGS_BUFF_SHIELD",
		name				= "Status: Shielded",
		author		= "Copi",
		description			= "Applies the shielded status to you for a short time",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/buff_shield.png",
		type				= ACTION_TYPE_UTILITY,
		spawn_level			= "2,		3,		4,		5,		6",
		spawn_probability	= "0.25,	0.33,	0.50,	0.33,	0.25",
		price				= 200,
		mana				= 120,
		max_uses			= 10,
		action				= function()
			c.fire_rate_wait    = c.fire_rate_wait + 20
			current_reload_time = current_reload_time + 40
			local entity_id = EntityGetWithTag("player_unit")[1]
			if entity_id ~= nil and entity_id ~= 0 then
				local px, py = EntityGetTransform( entity_id )
				local effect_id = EntityLoad( "mods/copis_things/files/entities/misc/status_entities/buff_shield.xml", px, py )
				EntityAddChild( entity_id, effect_id )
				end
			end,
	},

	{
		id					= "COPIS_THINGS_SPELL_REFRESH",
		name				= "Spell refresh",
		author		= "Copi",
		description			= "Refreshes the spells within your wands and inventory",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/spell_refresh.png",
		type				= ACTION_TYPE_UTILITY,
		spawn_level			= "0,		1,		2,		3,		4,		5,		6,		7,		8,		9,		10",
		spawn_probability	= "0.001,	0.001,	0.001,	0.001,	0.001,	0.001,	0.001,	0.001,	0.001,	0.001,	0.001",
		price				= 600,
		mana				= 240,
		action				= function()
			c.fire_rate_wait    = c.fire_rate_wait + 20
			current_reload_time = current_reload_time + 40
			local entity_id = EntityGetWithTag("player_unit")[1]
			if entity_id ~= nil and entity_id ~= 0 then
				GameRegenItemActionsInPlayer(entity_id)
				end
			end,
	},

	{
		id					= "COPIS_THINGS_GOLD",
		name				= "Gold",
		author		= "Copi",
		description			= "Summons a nugget of gold",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/gold.png",
		type				= ACTION_TYPE_UTILITY,
		spawn_level			= "0,		1,		2,		3,		4,		5,		6,		7,		8,		9,		10",
		spawn_probability	= "0.001,	0.001,	0.001,	0.001,	0.001,	0.001,	0.001,	0.001,	0.001,	0.001,	0.001",
		price				= 200000,
		mana				= 150,
		max_uses			= 3,
		action				= function()
			c.fire_rate_wait    = c.fire_rate_wait + 20
			current_reload_time = current_reload_time + 40
			add_projectile("data/entities/items/pickup/goldnugget_200.xml")
		end,
	},
	{
		id          = "COPIS_THINGS_FREEZING_VAPOUR_TRAIL",
		name 		= "Freezing Vapour Trail",
		author		= "Copi",
		description = "Gives a projectile a trail of stinging frost",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/freezing_vapour_trail.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level			               = "0,1,2,3,4,5,6", -- FIREBALL_RAY
		spawn_probability	               = "0.5,0.5,0.5,0.5,0.5,0.5,0.5", -- FIREBALL_RAY
		price = 300,
		mana = 13,
		action				= function()
            c.trail_material = c.trail_material .. "blood_cold";
            c.trail_material_amount = c.trail_material_amount + 5;
            draw_actions( 1, true );
		end,
	},
	{
		id          = "COPIS_THINGS_VOID_TRAIL",
		name 		= "Void Liquid Trail",
		author		= "Copi",
		description = "Gives a projectile a trail of pure darkness",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/void_trail.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level			               = "0,1,2,3,4,5,6", -- FIREBALL_RAY
		spawn_probability	               = "0.5,0.5,0.5,0.5,0.5,0.5,0.5", -- FIREBALL_RAY
		price = 200,
		mana = 6,
		action				= function()
            c.trail_material = c.trail_material .. "void_liquid,";
            c.trail_material_amount = c.trail_material_amount + 1;
            draw_actions( 1, true );
		end,
	},
	{
		id          = "COPIS_THINGS_DAMAGE_CRITICAL",
		name 		= "Critical strike",
		author		= "Copi",
		description = "Increases spell critical damage",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/damage_critical.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level			               = "0,1,2,3,4,5,6", -- FIREBALL_RAY
		spawn_probability	               = "0.7,0.7,0.7,0.7,0.7,0.7,0.7", -- FIREBALL_RAY
		price = 300,
		mana = 20,
		action				= function()
            c.damage_critical_multiplier = math.max( 1, c.damage_critical_multiplier ) + 1;
            draw_actions( 1, true );
		end,
	},
	{
		id          = "COPIS_THINGS_DIMIGE",
		name 		= "Dimige",
		author		= "Copi",
		description = "Increases spell damage slightly for each projectile spell on the wand",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/dimige.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level			               = "0,1,2,3", -- FIREBALL_RAY
		spawn_probability	               = "1.0,1.0,1.0,1.0", -- FIREBALL_RAY
		price = 70,
		mana = 5,
		action				= function()
            local projectile_type_sum = 0;
            for k,v in ipairs( deck or {} ) do if v.type == ACTION_TYPE_PROJECTILE or v.type == ACTION_TYPE_STATIC_PROJECTILE or v.type == ACTION_TYPE_MATERIAL then projectile_type_sum = projectile_type_sum + 1; end end
            for k,v in ipairs( hand or {} ) do if v.type == ACTION_TYPE_PROJECTILE or v.type == ACTION_TYPE_STATIC_PROJECTILE or v.type == ACTION_TYPE_MATERIAL then projectile_type_sum = projectile_type_sum + 1; end end
            for k,v in ipairs( discarded or {} ) do if v.type == ACTION_TYPE_PROJECTILE or v.type == ACTION_TYPE_STATIC_PROJECTILE or v.type == ACTION_TYPE_MATERIAL then projectile_type_sum = projectile_type_sum + 1; end end
            c.damage_projectile_add = c.damage_projectile_add + 0.04 + 0.04 * projectile_type_sum;
            draw_actions( 1, true );
		end,
	},
	{
		id          = "COPIS_THINGS_POWER_SHOT",
		name 		= "Power Shot",
		author		= "Copi",
		description = "Cast a spell with increased damage and material penetration",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/power_shot.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level			               = "0,1,2,3,4,5,6", -- FIREBALL_RAY
		spawn_probability	               = "0.7,0.7,0.7,0.7,0.7,0.7,0.7", -- FIREBALL_RAY
		price = 300,
		mana = 20,
		action				= function()
			c.damage_projectile_add = c.damage_projectile_add + 0.24;
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/power_shot.xml,";
            draw_actions( 1, true );
		end,
	},
	{
		id          = "COPIS_THINGS_STICKY_SHOT",
		name 		= "Sticky Shot",
		author		= "Copi",
		description = "Cast a spell which sticks to surfaces it hits",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/sticky_shot.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level			               = "0,1,2,3,4,5,6", -- FIREBALL_RAY
		spawn_probability	               = "0.6,0.6,0.6,0.6,0.6,0.6,0.6", -- FIREBALL_RAY
		price = 200,
		mana = 9,
		action				= function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/sticky_shot.xml,";
            draw_actions( 1, true );
		end,
	},
	{
		id          = "COPIS_THINGS_LIGHT_REMOVER",
		name 		= "Light Remover",
		author		= "Copi",
		description = "Removes the light from a projectile",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/light_remover.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level			               = "2,3", -- FIREBALL_RAY
		spawn_probability	               = "0.2,0.2", -- FIREBALL_RAY
		price = 50,
		mana = 0,
		action				= function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/light_remover.xml,";
            draw_actions( 1, true );
		end,
	},
	{
		id          = "COPIS_THINGS_LOVELY_TRAIL",
		name 		= "Lovely Trail",
		author		= "Copi",
		description = "Show your enemies some love",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/lovely_trail.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level			               = "0,1,2,3,4,5,6", -- FIREBALL_RAY
		spawn_probability	               = "0.2,0.2,0.2,0.2,0.2,0.2,0.2", -- FIREBALL_RAY
		price = 10,
		mana = 0,
		action				= function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/particles/lovely_trail.xml,";
            draw_actions( 1, true );
		end,
	},
	{
		id          = "COPIS_THINGS_STARRY_TRAIL",
		name 		= "Starry Trail",
		author		= "Copi",
		description = "Only shooting stars",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/starry_trail.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level			               = "0,1,2,3,4,5,6", -- FIREBALL_RAY
		spawn_probability	               = "0.2,0.2,0.2,0.2,0.2,0.2,0.2", -- FIREBALL_RAY
		price = 10,
		mana = 0,
		action				= function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/particles/starry_trail.xml,";
            draw_actions( 1, true );
		end,
	},
	{
		id          = "COPIS_THINGS_SPARKLING_TRAIL",
		name 		= "Sparkling Trail",
		author		= "Copi",
		description = "Spread glitter across the world",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/sparkling_trail.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level			               = "0,1,2,3,4,5,6", -- FIREBALL_RAY
		spawn_probability	               = "0.2,0.2,0.2,0.2,0.2,0.2,0.2", -- FIREBALL_RAY
		price = 10,
		mana = 0,
		action				= function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/particles/sparkling_trail.xml,";
            draw_actions( 1, true );
		end,
	},
	{
		id          = "COPIS_THINGS_NULL_TRAIL",
		name 		= "Lovely Trail",
		author		= "Copi",
		description = "Remove all particle emitters from the projectile",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/null_trail.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level			               = "0,1,2,3,4,5,6", -- FIREBALL_RAY
		spawn_probability	               = "0.2,0.2,0.2,0.2,0.2,0.2,0.2", -- FIREBALL_RAY
		price = 10,
		mana = 0,
		action				= function()
            c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/null_trail.xml,";
            draw_actions( 1, true );
		end,
	},

	{
		id          = "COPIS_THINGS_RANDOM_CAST",
		name 		= "Random cast",
		author		= "Copi",
		description = "Casts a spell from a random position",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/random_cast.png",
		type 		= ACTION_TYPE_UTILITY,
		spawn_level			               = "2,3,4,5", -- FIREBALL_RAY
		spawn_probability	               = "0.2,0.2,0.2,0.2", -- FIREBALL_RAY
		price = 90,
		mana = 0,
		action				= function()
			add_projectile_trigger_death("mods/copis_things/files/entities/projectiles/random_cast.xml", 1)
			c.fire_rate_wait = c.fire_rate_wait - 10
		end,
	},

	{
		id          = "COPIS_THINGS_ROOT_GROWER",
		name 		= "Creeping Vines",
		author		= "Copi",
		description = "Spawns a mass of rapidly growing nature",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/root_grower.png",
		type 		= ACTION_TYPE_STATIC_PROJECTILE,
		spawn_level			               = "0,1,2,3,4,5", -- FIREBALL_RAY
		spawn_probability	               = "0.5,0.5,0.5,0.5,0.5,0.5", -- FIREBALL_RAY
		price = 90,
		mana = 40,
		max_uses = 10,
		action				= function()
			add_projectile("mods/copis_things/files/entities/props/root_grower.xml")
			c.fire_rate_wait = c.fire_rate_wait + 12
		end,
	},

	{
		id					= "COPIS_THINGS_HOMING_CURSOR",
		name				= "Cursor Homing",
		author		= "Copi",
		description			= "Homing projectiles will be able to target your cursor",
		sprite      	   = "mods/copis_things/files/ui_gfx/gun_actions/homing_cursor.png",
		type        		= ACTION_TYPE_PASSIVE,
		spawn_level			               = "1,2,3,4,5,6,10", -- RECHARGE
		spawn_probability	               = "0.1,0.1,0.1,0.1,0.1,0.1,0.2", -- RECHARGE
		price				= 100,
		mana				= 0,
		custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/homing_cursor.xml",
		action = function()
			draw_actions( 1, true )
		end
	},

	{
		id						= "COPIS_THINGS_HOMING_ANTI",
		name					= "Anti Homing",
		author		= "Copi",
		description				= "Projectiles will be repelled by enemies",
		sprite					= "mods/copis_things/files/ui_gfx/gun_actions/homing_anti.png",
		related_extra_entities	= { "mods/copis_things/files/entities/misc/homing_anti.xml,data/entities/particles/tinyspark_white_weak.xml" },
		type					= ACTION_TYPE_MODIFIER,
		spawn_level				= "1,2,3,4,5", -- HOMING
		spawn_probability		= "0.1,0.1,0.1,0.1,0.1", -- HOMING
		price					= 100,
		mana					= 0,
		action					= function()
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/homing_anti.xml,data/entities/particles/tinyspark_white_weak.xml,"
			draw_actions( 1, true )
		end,
	},

	{
		id					= "COPIS_THINGS_PROTECTION_FIRE",
		name				= "Fire immunity",
		author		= "Copi",
		description			= "Your wand grants you a magical aura of fire immunity!",
		sprite      	   = "mods/copis_things/files/ui_gfx/gun_actions/protection_fire.png",
		type        		= ACTION_TYPE_PASSIVE,
		spawn_level			               = "1,2,3,4,5,6,10", -- RECHARGE
		spawn_probability	               = "0.1,0.1,0.1,0.1,0.1,0.1,0.2", -- RECHARGE
		price				= 1200,
		mana				= 0,
		custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/protection_fire.xml",
		action = function()
			draw_actions( 1, true )
		end
	},

	{
		id					= "COPIS_THINGS_PROTECTION_EXPLOSION",
		name				= "Explosion immunity",
		author		= "Copi",
		description			= "Your wand grants you a magical aura of explosion immunity!",
		sprite      	   = "mods/copis_things/files/ui_gfx/gun_actions/protection_explosion.png",
		type        		= ACTION_TYPE_PASSIVE,
		spawn_level			               = "1,2,3,4,5,6,10", -- RECHARGE
		spawn_probability	               = "0.1,0.1,0.1,0.1,0.1,0.1,0.2", -- RECHARGE
		price				= 1200,
		mana				= 0,
		custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/protection_explosion.xml",
		action = function()
			draw_actions( 1, true )
		end
	},

	{
		id					= "COPIS_THINGS_PROTECTION_ELECTRICITY",
		name				= "Electricity immunity",
		author		= "Copi",
		description			= "Your wand grants you a magical aura of electricity immunity!",
		sprite      	   = "mods/copis_things/files/ui_gfx/gun_actions/protection_electricity.png",
		type        		= ACTION_TYPE_PASSIVE,
		spawn_level			               = "1,2,3,4,5,6,10", -- RECHARGE
		spawn_probability	               = "0.1,0.1,0.1,0.1,0.1,0.1,0.2", -- RECHARGE
		price				= 1200,
		mana				= 0,
		custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/protection_electricity.xml",
		action = function()
			draw_actions( 1, true )
		end
	},

	{
			id					= "COPIS_THINGS_PROTECTION_ICE",
			name				= "Freeze immunity",
			author		= "Copi",
		description			= "Your wand grants you a magical aura of freeze immunity!",
			sprite      	   = "mods/copis_things/files/ui_gfx/gun_actions/protection_ice.png",
			type        		= ACTION_TYPE_PASSIVE,
			spawn_level			               = "1,2,3,4,5,6,10", -- RECHARGE
			spawn_probability	               = "0.1,0.1,0.1,0.1,0.1,0.1,0.2", -- RECHARGE
			price				= 1200,
			mana				= 0,
			custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/protection_ice.xml",
			action = function()
				draw_actions( 1, true )
			end
	},

	{
			id					= "COPIS_THINGS_PROTECTION_RADIOACTIVITY",
			name				= "Toxic immunity",
			author		= "Copi",
		description			= "Your wand grants you a magical aura of toxic immunity!",
			sprite      	   = "mods/copis_things/files/ui_gfx/gun_actions/protection_radioactivity.png",
			type        		= ACTION_TYPE_PASSIVE,
			spawn_level			               = "1,2,3,4,5,6,10", -- RECHARGE
			spawn_probability	               = "0.1,0.1,0.1,0.1,0.1,0.1,0.2", -- RECHARGE
			price				= 1200,
			mana				= 0,
			custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/protection_radioactivity.xml",
			action = function()
				draw_actions( 1, true )
			end
	},

	{
			id					= "COPIS_THINGS_PROTECTION_MELEE",
			name				= "Melee immunity",
			author		= "Copi",
		description			= "Your wand grants you a magical aura of melee immunity!",
			sprite      	   = "mods/copis_things/files/ui_gfx/gun_actions/protection_melee.png",
			type        		= ACTION_TYPE_PASSIVE,
			spawn_level			               = "1,2,3,4,5,6,10", -- RECHARGE
			spawn_probability	               = "0.1,0.1,0.1,0.1,0.1,0.1,0.2", -- RECHARGE
			price				= 1200,
			mana				= 0,
			custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/protection_melee.xml",
			action = function()
				draw_actions( 1, true )
			end
	},

	{
			id					= "COPIS_THINGS_PROTECTION_POLYMORPH",
			name				= "Polymorph immunity",
			author		= "Copi",
		description			= "Your wand grants you a magical aura of polymorph immunity!",
			sprite      	   = "mods/copis_things/files/ui_gfx/gun_actions/protection_polymorph.png",
			type        		= ACTION_TYPE_PASSIVE,
			spawn_level			               = "1,2,3,4,5,6,10", -- RECHARGE
			spawn_probability	               = "0.05,0.05,0.05,0.05,0.05,0.05,0.1", -- RECHARGE
			price				= 1200,
			mana				= 0,
			custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/protection_polymorph.xml",
			action = function()
				draw_actions( 1, true )
			end
	},

	{
			id					= "COPIS_THINGS_PROJECTILE_HOMING",
			name				= "Passive Homing",
			author		= "Copi",
		description			= "All projectiles fired while holding the wand slighty home in on enemies!",
			sprite      	   = "mods/copis_things/files/ui_gfx/gun_actions/projectile_homing.png",
			type        		= ACTION_TYPE_PASSIVE,
			spawn_level			               = "1,2,3,4,5,6", -- RECHARGE
			spawn_probability	               = "0.3,0.3,0.3,0.3,0.3,0.3", -- RECHARGE
			price				= 800,
			mana				= 0,
			custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/projectile_homing.xml",
			action = function()
				draw_actions( 1, true )
			end
	},

	{
			id					= "COPIS_THINGS_INVISIBILITY",
			name				= "Invisibility",
			author		= "Copi",
		description			= "Your wand grants you a magical aura of invisibility!",
			sprite      	   = "mods/copis_things/files/ui_gfx/gun_actions/invisibility.png",
			type        		= ACTION_TYPE_PASSIVE,
			spawn_level			               = "1,2,3,4,5,6", -- RECHARGE
			spawn_probability	               = "0.3,0.3,0.3,0.3,0.3,0.3", -- RECHARGE
			price				= 800,
			mana				= 0,
			custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/invisibility.xml",
			action = function()
				draw_actions( 1, true )
			end
	},

	{
			id					= "COPIS_THINGS_BREATH_UNDERWATER",
			name				= "Breath Underwater",
			author		= "Copi",
		description			= "Your wand grants you a magical aura of respiration!",
			sprite      	   = "mods/copis_things/files/ui_gfx/gun_actions/breath_underwater.png",
			type        		= ACTION_TYPE_PASSIVE,
			spawn_level			               = "1,2,3,4,5,6", -- RECHARGE
			spawn_probability	               = "0.3,0.3,0.3,0.3,0.3,0.3", -- RECHARGE
			price				= 800,
			mana				= 0,
			custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/breath_underwater.xml",
			action = function()
				draw_actions( 1, true )
			end
	},

	{
		id          = "COPIS_THINGS_ATTACK_LEG",
		name 		= "Lukki Limb",
		author		= "Copi",
		description = "Control a Lukki leg to kick nearby enemies automatically",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/attack_leg.png",
		type 		= ACTION_TYPE_PASSIVE,
		spawn_level			               = "0,1,2,3,4,5", -- ENERGY_SHIELD_SECTOR
		spawn_probability	               = "0.1,0.2,0.3,0.2,0.1,0.1", -- ENERGY_SHIELD_SECTOR
		price = 160,
		mana	= 0,
		custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/attack_leg.xml",
		action				= function()
			-- does nothing to the projectiles
			draw_actions( 1, true )
		end,
	},

	{
		id          = "COPIS_THINGS_BAYONET",
		name 		= "Bayonet",
		author		= "Copi",
		description = "Attach a small knife to the tip of your wand --INDEV WRONG AREA DAMAGE--",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/bayonet.png",
		type 		= ACTION_TYPE_PASSIVE,
		spawn_level			               = "0,1,2,3,4,5", -- ENERGY_SHIELD_SECTOR
		spawn_probability	               = "0.1,0.2,0.3,0.2,0.1,0.1", -- ENERGY_SHIELD_SECTOR
		price = 160,
		mana	= 0,
		custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/bayonet.xml",
		action				= function()
			-- does nothing to the projectiles
			draw_actions( 1, true )
		end,
	},

	{
		id          = "COPIS_THINGS_KICK_EXPLOSION",
		name 		= "Explosive Kick",
		author		= "Copi",
		description = "Create a devastating explosion when you kick. Use wisely! Consumes 60 mana when you kick.",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/kick_explosion.png",
		type 		= ACTION_TYPE_PASSIVE,
		spawn_level			               = "1,2,3,4,5", -- ENERGY_SHIELD_SECTOR
		spawn_probability	               = "0.2,0.3,0.2,0.1,0.1", -- ENERGY_SHIELD_SECTOR
		price = 280,
		mana	= 0,
		custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/kick_explosion.xml",
		action				= function()
			-- does nothing to the projectiles
			draw_actions( 1, true )
		end,
	},

	{
		id          = "COPIS_THINGS_ALT_FIRE_FLAMETHROWER",
		name 		= "Sidearm Flamethrower",
		author		= "Copi",
		description = "Fires a deadly stream of flames while you hold alt fire. Consumes 20 mana per shot.",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/alt_fire_flamethrower.png",
		type 		= ACTION_TYPE_PASSIVE,
		spawn_level			               = "1,2,3,4,5", -- ENERGY_SHIELD_SECTOR
		spawn_probability	               = "0.2,0.3,0.2,0.1,0.1", -- ENERGY_SHIELD_SECTOR
		price = 280,
		mana	= 0,
		custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/alt_fire_flamethrower.xml",
		action				= function()
			-- does nothing to the projectiles
			draw_actions( 1, true )
		end,
	},

	{
		id          = "COPIS_THINGS_DECOY",
		name 		= "$action_decoy",
		author		= "Copi",
		description = "$actiondesc_decoy",
		sprite 		= "data/ui_gfx/gun_actions/decoy.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/decoy_unidentified.png",
		type 		= ACTION_TYPE_PROJECTILE,
		spawn_level			= "0,1,2,3,4,5", -- ENERGY_SHIELD_SECTOR
		spawn_probability	= "0.1,0.3,0.2,0.2,0.1,0.1", -- ENERGY_SHIELD_SECTOR
		price = 130,
		mana = 60,
		max_uses    = 10,
		custom_xml_file = "data/entities/misc/custom_cards/decoy.xml",
		action 		= function()
			add_projectile("data/entities/projectiles/deck/decoy.xml")
			c.fire_rate_wait = c.fire_rate_wait + 40
		end,
	},
	
	{
		id          = "COPIS_THINGS_DECOY_TRIGGER",
		name 		= "$action_decoy_trigger",
		author		= "Copi",
		description = "$actiondesc_decoy_trigger",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/decoy_death_trigger.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/decoy_trigger_unidentified.png",
		type 		= ACTION_TYPE_PROJECTILE,
		spawn_level			= "0,1,2,3,4,5", -- ENERGY_SHIELD_SECTOR
		spawn_probability	= "0.1,0.3,0.2,0.2,0.1,0.1", -- ENERGY_SHIELD_SECTOR
		price = 150,
		mana = 80,
		max_uses    = 10,
		custom_xml_file = "data/entities/misc/custom_cards/decoy_trigger.xml",
		action 		= function()
			add_projectile_trigger_death("data/entities/projectiles/deck/decoy_trigger.xml", 1)
			c.fire_rate_wait = c.fire_rate_wait + 40
		end,
	},

	{
		id          = "COPIS_THINGS_HITFX_EXPLOSION_FROZEN",
		name 		= "Explosion on frozen enemies",
		author		= "Copi",
		description = "Makes a projectile explode upon collision with frozen creatures",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/explode_on_frozen.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/freeze_unidentified.png",
		related_extra_entities = { "mods/copis_things/files/entities/misc/hitfx_explode_frozen.xml" },
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "1,3,4,5", -- HITFX_EXPLOSION_ALCOHOL
		spawn_probability                 = "0.2,0.2,0.2,0.2", -- HITFX_EXPLOSION_ALCOHOL
		price = 140,
		mana = 20,
		--max_uses = 50,
		action 		= function()
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/hitfx_explode_frozen.xml,"
			draw_actions( 1, true )
		end,
	},

	{
		id          = "COPIS_THINGS_HITFX_EXPLOSION_FROZEN_GIGA",
		name 		= "Giant explosion on frozen enemies",
		author		= "Copi",
		description = "Makes a projectile explode powerfully upon collision with frozen creatures",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/explode_on_frozen_giga.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/freeze_unidentified.png",
		related_extra_entities = { "mods/copis_things/files/entities/misc/hitfx_explode_frozen_giga.xml", "data/entities/particles/tinyspark_orange.xml" },
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "1,3,4,5", -- HITFX_EXPLOSION_ALCOHOL_GIGA
		spawn_probability                 = "0.1,0.1,0.1,0.1", -- HITFX_EXPLOSION_ALCOHOL_GIGA
		price = 300,
		mana = 200,
		max_uses = 20,
		action 		= function()
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/hitfx_explode_frozen.xml,data/entities/particles/tinyspark_orange.xml,"
			draw_actions( 1, true )
		end,
	},

	{
		id          = "COPIS_THINGS_CIRCLE_EDIT_WANDS_EVERYWHERE",
		name 		= "Circle of Divine Blessing",
		author		= "Copi",
		description = "A field of modification magic",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/circle_edit_wands_everywhere.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/freeze_unidentified.png",
		related_extra_entities = { "mods/copis_things/files/entities/projectiles/circle_edit_wands_everywhere.xml"},
		type 		= ACTION_TYPE_STATIC_PROJECTILE,
		spawn_level                       = "0,		1,		2,		3",
		spawn_probability                 = "1,		1,		1,		1",
		price = 200,
		mana = 50,
		max_uses = 3,
		action 		= function()
			add_projectile("mods/copis_things/files/entities/projectiles/circle_edit_wands_everywhere.xml")
			draw_actions( 1, true )
		end,
	},

	{
		id          = "COPIS_THINGS_MINI_SHIELD",
		name 		= "Projectile Bubble Shield",
		author		= "Copi",
		description = "Encases a projectile in a deflective shield",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/mini_shield.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/freeze_unidentified.png",
		related_extra_entities = { "mods/copis_things/files/entities/misc/mini_shield.xml"},
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "0,1,2,3,4,5,6", -- HITFX_EXPLOSION_ALCOHOL_GIGA
		spawn_probability                 = "1,1,1,1,1,1,1", -- HITFX_EXPLOSION_ALCOHOL_GIGA
		price = 540,
		mana = 20,
		action 		= function()
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/mini_shield.xml"
			draw_actions( 1, true )
		end,
	},

	{
		id          = "COPIS_THINGS_NGON_SHAPE",
		name 		= "Formation - N-gon",
		author		= "Copi",
		description = "Cast all remaining spells in a circular pattern",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/ngon_shape.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/freeze_unidentified.png",
		type 		= ACTION_TYPE_DRAW_MANY,
		spawn_level                       = "0,		1,		2,		3,		4,		5,		6",
		spawn_probability                 = "0.33,	0.33,	0.33,	0.33,	0.33,	0.33,	0.33",
		price = 120,
		mana = 24,
        action		= function()
            c.pattern_degrees = 180;
            draw_actions( #deck, true );
        end,
	},

	{
		id          = "COPIS_THINGS_SHUFFLE_DECK",
		name 		= "Shuffle Deck",
		author		= "Copi",
		description = "Randomize the order of all spells in the cast",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/shuffle_deck.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/freeze_unidentified.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "0,		1,		2,		3,		4,		5,		6",
		spawn_probability                 = "0.4,	0.4,	0.4,	0.4,	0.4,	0.4,	0.4",
		price = 100,
		mana = -20,
		action = function()
			SetRandomSeed( GameGetFrameNum(), 1284 );
            local shuffle_deck = {};
            for i=1, #deck do
                local index = Random( 1, #deck );
                local action = deck[ index ];
                table.remove( deck, index );
                table.insert( shuffle_deck, action );
            end
            for index,action in pairs(shuffle_deck) do
                table.insert( deck, action );
            end
            draw_actions( 1, true );
        end,
	},

	--[[{
		id          = "COPIS_THINGS_BARRIER_TRAIL",
		name 		= "Barrier Trail",
		author		= "Copi",
		description = "Projectiles gain a trail of barriers",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/barrier_trail.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/freeze_unidentified.png",
		related_extra_entities = { "mods/copis_things/files/entities/misc/barrier_trail.xml"},
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "2,		3,		4,		5",
		spawn_probability                 = "0.7,	0.7,	0.7,	0.7",
		price = 200,
		mana = 20,
		action = function()
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/barrier_trail.xml,"
            draw_actions( 1, true );
        end,
	},]]

	{
		id          = "COPIS_THINGS_EXPIRE_NEARBY_ENEMIES",
		name 		= "Projectile Area Expiration",
		author		= "Copi",
		description = "Projectiles will expire when enemies are nearby",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/expire_nearby_enemies.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/freeze_unidentified.png",
		related_extra_entities = { "mods/copis_things/files/entities/misc/expire_nearby_enemies.xml"},
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "2,		4,		5,		6",
		spawn_probability                 = "0.2,	0.2,	0.5,	0.1",
		price = 50,
		mana = 5,
		action = function()
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/expire_nearby_enemies.xml,"
            draw_actions( 1, true );
        end,
	},
}

for k, v in ipairs(to_insert) do
    table.insert(actions, v)
end



	--[[
	{
		id					= "COPIS_THINGS_SUMMON_POUCH",
		name				= "Summon pouch",
		author		= "Copi",
		description			= "Summons an empty pouch",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/summon_flask.png",
		type				= ACTION_TYPE_UTILITY,
		spawn_level			= "2,		3,		4,		5,		6",
		spawn_probability	= "0.25,	0.33,	0.50,	0.33,	0.25",
		price				= 200,
		mana				= 90,
		max_uses			= 1,
		action				= function()
			c.fire_rate_wait    = c.fire_rate_wait + 20
			current_reload_time = current_reload_time + 40
			add_projectile("data/entities/items/pickup/goldnugget_200.xml")
		end,
	},

	{
		id					= "COPIS_THINGS_SUMMON_POUCH_FULL",
		name				= "Summon filled pouch",
		author		= "Copi",
		description			= "Summons a pouch filled with a random material",
		sprite				= "mods/copis_things/files/ui_gfx/gun_actions/summon_flask_full.png",
		type				= ACTION_TYPE_UTILITY,
		spawn_level			= "2,		3,		4,		5,		6",
		spawn_probability	= "0.125,	0.17,	0.25,	0.17,	0.125",
		price				= 300,
		mana				= 120,
		max_uses			= 1,
		action				= function()
			c.fire_rate_wait    = c.fire_rate_wait + 20
			current_reload_time = current_reload_time + 40
			add_projectile("data/entities/items/pickup/goldnugget_200.xml")
		end,
	},
	
	{
		id          = "COPIS_THINGS_SORT_DECK",
		name 		= "Unshuffle",
		author		= "Copi",
		description = "Stablizes shuffled wands",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/sort_deck.png",
		type 		= ACTION_TYPE_PASSIVE,
		spawn_level			               = "1,3,4,5", -- FREEZE
		spawn_probability	               = "1,1,1,1", -- FREEZE
		price = 100,
		mana = 5,
		action				= function()
		end,
	},

	{
		id          = "COPIS_THINGS_SHUFFLE_DECK",
		name 		= "Shuffle",
		author		= "Copi",
		description = "Imbues a wand with unpredictable energy",
		sprite 		= "mods/copis_things/files/ui_gfx/gun_actions/shuffle_deck.png",
		type 		= ACTION_TYPE_PASSIVE,
		spawn_level			               = "1,3,4,5", -- FREEZE
		spawn_probability	               = "1,1,1,1", -- FREEZE
		price = 100,
		mana = -20,
		action				= function()
		end,
	},

	]]--