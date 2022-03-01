
	-- PSYCHIC SHOT
	table.insert(actions,
	{
	id          		= "COPIS_THINGS_PSYCHIC_SHOT",
	name 				= "Psychic shot",
	description 		= "Causes the projectile to be controlled telekinetically",
	sprite 				= "mods/copis_things/files/sprites/spell_gui/psychic_shot.png",
	type 				= ACTION_TYPE_MODIFIER,
	spawn_level         = "2,3,4,5,6",
	spawn_probability   = "0.3,0.4,0.5,0.6,0.6",
	price 				= 150,
	mana 				= 15,
    action 		= function()
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/psychic_shot.xml,"
			draw_actions( 1, true )
		end
	})

	-- STAB
	table.insert(actions,
	{
	id                 = "COPIS_THINGS_STAB",
	name               = "Stab",
	description        = "A short ranged melee thrust",
	sprite             = "mods/copis_things/files/sprites/spell_gui/stab.png",
	related_projectiles	= {"mods/copis_things/files/entities/projectiles/stab.xml"},
	type               = ACTION_TYPE_PROJECTILE,
	spawn_level        = "0,0,0,0",
	spawn_probability  = "0,0,0,0",
	price              = 0,
	mana               = 0,
	action 		= function()
			add_projectile("mods/copis_things/files/entities/projectiles/stab.xml")
			c.fire_rate_wait = c.fire_rate_wait + 7
			c.screenshake = c.screenshake + 0.7
			c.spread_degrees = c.spread_degrees - 2.0
			c.damage_critical_chance = c.damage_critical_chance + 15
		end,
	})

	-- SWORD THROW
	table.insert(actions,
	{
	id                 = "COPIS_THINGS_TWISTED_SWORD_THROW",
	name               = "Sword throw",
	description        = "Throw a rapidly spinning sword clone",
	sprite             = "mods/copis_things/files/sprites/spell_gui/twisted_throw.png",
	related_projectiles	= {"mods/copis_things/files/entities/projectiles/twisted_throw.xml"},
	type               = ACTION_TYPE_PROJECTILE,
	spawn_level        = "0,0,0,0",
	spawn_probability  = "0,0,0,0",
	price              = 0,
	mana               = 0,
	action 		= function()
			add_projectile("mods/copis_things/files/entities/projectiles/twisted_throw.xml")
			c.screenshake = c.screenshake + 0.7
			c.spread_degrees = c.spread_degrees - 2.0
			c.damage_critical_chance = c.damage_critical_chance + 15
			c.fire_rate_wait = c.fire_rate_wait + 40
			shot_effects.recoil_knockback = shot_effects.recoil_knockback + 30.0
			c.damage_projectile_add = c.damage_projectile_add + 0.2
		end,
	})

	-- LUNGE
	table.insert(actions,
	{
		id          = "COPIS_THINGS_LUNGE",
		name 		= "Lunge",
		description = "Launch yourself forwards with a burst of speed",
		sprite 		= "mods/copis_things/files/sprites/spell_gui/lunge.png",
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
	})


	--[[
	table.insert(actions,
	{
		id          = "COPIS_THINGS_SHADOWTENTACLE",
		name 		= "Shadow Apparition",
		description = "Release a lash of pure darkness which spreads from it's victims",
		sprite 		= "mods/copis_things/files/sprites/spell_gui/shadowtentacle.png",
		related_projectiles	= {"mods/copis_things/files/projectiles/shadowtentacle.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		spawn_level        = "0,0,0,0",
		spawn_probability  = "0,0,0,0",
		price = 170,
		mana = 30,
		action 		= function()
			add_projectile("mods/copis_things/files/projectiles/shadowtentacle.xml")
			c.fire_rate_wait = c.fire_rate_wait + 5
		end
	})
	]]--


	-- BLOOD TENTACLE
	table.insert(actions,
	{
    id          = "BLOODTENTACLE",
    name 		= "$action_bloodtentacle",
    description = "$actiondesc_bloodtentacle",
    spawn_requires_flag = "card_unlocked_pyramid",
    sprite 		= "data/ui_gfx/gun_actions/bloodtentacle.png",
    related_projectiles	= {"data/entities/projectiles/deck/bloodtentacle.xml"},
    type 		= ACTION_TYPE_PROJECTILE,
    spawn_level                       = "3,4,5,6", -- TENTACLE
    spawn_probability                 = "0.2,0.5,1,1", -- TENTACLE
    price = 170,
    mana = 30,
    --max_uses = 40,
    action 		= function()
        add_projectile("data/entities/projectiles/deck/bloodtentacle.xml")
        c.fire_rate_wait = c.fire_rate_wait + 20
    end,
	})


	table.insert(actions,
	{
	id          = "COPIS_THINGS_SUNSABER_DARK",
	name 		= "Dark Sunsaber",
	description = "A blade forged from the dark sun",
	sprite 		= "mods/copis_things/files/sprites/spell_gui/sunsaber_dark.png",
	related_projectiles	= {"mods/copis_things/files/entities/projectiles/sunsaber_dark.xml"},
	type 		= ACTION_TYPE_PROJECTILE,
	spawn_level                       = "0,0",
	spawn_probability                 = "0,0",
	price = 150,
	mana = 0,
	sound_loop_tag = "sound_digger",
	action 		= function()
		add_projectile("mods/copis_things/files/entities/projectiles/sunsaber_dark.xml")
		c.fire_rate_wait = c.fire_rate_wait - 35
		current_reload_time = current_reload_time - ACTION_DRAW_RELOAD_TIME_INCREASE - 10
	end,
	})

	table.insert(actions,
	{
		id                 = "COPIS_THINGS_SWORD_BLADE",
		name               = "Sword Blade",
		description        = "Your sword's sharp edge deals damage as it hits foes!",
		sprite      	   = "mods/copis_things/files/sprites/spell_gui/sword_blade.png",
		type        		= ACTION_TYPE_PASSIVE,
		spawn_level       = "0,0",
		spawn_probability  = "0,0",
		price              = 0,
		mana               = 0,
		custom_xml_file = "mods/copis_things/files/entities/projectiles/sword_blade.xml",
		action = function()
		end
	})
	
	table.insert(actions,
	{
		id          = "COPIS_THINGS_SUMMON_TABLET",
		name 		= "Summon Emerald Tablet",
		description = "Summon an emerald tablet",
		sprite 		= "mods/copis_things/files/sprites/spell_gui/summon_tablet.png",
		related_projectiles	= {"data/entities/projectiles/deck/rock.xml"},
		type 		= ACTION_TYPE_PROJECTILE,
		spawn_level                       = "0,1,2,3,4,5,6", -- SUMMON_ROCK
		spawn_probability                 = "0.8,0.8,0.8,0.8,0.8,0.8,0.8", -- SUMMON_ROCK
		price = 160,
		mana = 100, 
		max_uses    = 3, 
		custom_xml_file = "data/entities/misc/custom_cards/summon_rock.xml",
		action 		= function()
			add_projectile("data/entities/projectiles/deck/rock.xml")
		end,
	})

	table.insert(actions,
	{
	id          = "COPIS_THINGS_PROJECTION_CAST",
	name 		= "Projection cast",
	description = "Projects your cast to where your mind focuses",
	sprite 		= "mods/copis_things/files/sprites/spell_gui/projection_cast.png",
	type 		= ACTION_TYPE_UTILITY,
	spawn_level						  = "6,10",
	spawn_probability				  = "0.2,1",
	price = 250,
	mana = 50,
	action 		= function()
		add_projectile_trigger_death("mods/copis_things/files/entities/projectiles/projection_cast.xml", 1)
		c.fire_rate_wait = c.fire_rate_wait + 10
		c.spread_degrees = c.spread_degrees - 6
	end,
	})

	table.insert(actions,
	{
		id          = "COPIS_THINGS_SLOW",
		name 		= "Speed Down",
		description = "Decreases the speed at which a projectile flies through the air",
		sprite 		= "mods/copis_things/files/sprites/spell_gui/slow.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "1,2,3", -- SPEED
		spawn_probability                 = "1,0.5,0.5", -- SPEED
		price = 100,
		mana = -3,
		--max_uses = 100,
		custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/slow.xml",
		action 		= function()
			c.speed_multiplier = c.speed_multiplier * 0.4
			c.spread_degrees = c.spread_degrees - 8
			draw_actions( 1, true )
		end,
	})

	table.insert(actions,
	{
		id          = "COPIS_THINGS_CLAIRVOYANCE",
		name 		= "Clairvoyance",
		description = "Allows you to project your vision",
		sprite 		= "mods/copis_things/files/sprites/spell_gui/clairvoyance.png",
		type 		= ACTION_TYPE_PASSIVE,
		spawn_level                       = "1,2,3,4,5,6", -- TINY_GHOST
		spawn_probability                 = "0.1,0.5,1,1,1,1", -- TINY_GHOST
		price = 160,
		mana = 0,
		custom_xml_file = "mods/copis_things/files/entities/misc/custom_cards/clairvoyance.xml",
		action 		= function()
			draw_actions( 1, true )
		end,
	})

	table.insert(actions,
	{
		id          = "COPIS_THINGS_PEACEFUL_SHOT",
		name 		= "Peaceful Shot",
		description = "Sharply reduces the damage of a projectile",
		sprite 		= "mods/copis_things/files/sprites/spell_gui/peaceful_shot.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "1,2,3", -- SPEED
		spawn_probability                 = "1,0.5,0.5", -- SPEED
		price = 100,
		mana = 20,
		action 		= function()
			c.speed_multiplier = c.speed_multiplier * 0.8
			c.gore_particles   = c.gore_particles - 5
			c.fire_rate_wait   = c.fire_rate_wait - 5
			c.damage_projectile_add = c.damage_projectile_add - 1
			c.spread_degrees = c.spread_degrees - 5
			draw_actions( 1, true )
		end,
	})

	table.insert(actions,
	{
		id          = "COPIS_THINGS_ANCHORED_SHOT",
		name 		= "Anchored Shot",
		description = "Anchors a projectile where it was fired",
		sprite 		= "mods/copis_things/files/sprites/spell_gui/anchored_shot.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "1,2,3", -- SPEED
		spawn_probability                 = "1,0.5,0.5", -- SPEED
		price = 100,
		mana = 10,
		action 		= function()
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/stasis_shot.xml"
			c.speed_multiplier = c.speed_multiplier * 0.05
			c.spread_degrees = c.spread_degrees - 10
			c.lifetime_add 		= c.lifetime_add + 250
			c.fire_rate_wait = c.fire_rate_wait + 26
			draw_actions( 1, true )
		end,
	})

	table.insert(actions,
	{
		id          = "COPIS_THINGS_LEVITY_SHOT",
		name 		= "Levity Shot",
		description = "Nullifies a projectile's gravity",
		sprite 		= "mods/copis_things/files/sprites/spell_gui/levity_shot.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "1,2,3", -- SPEED
		spawn_probability                 = "1,0.5,0.5", -- SPEED
		price = 100,
		mana = 5,
		action 		= function()
			c.extra_entities = c.extra_entities .. "mods/copis_things/files/entities/misc/levity_shot.xml"
			c.speed_multiplier = c.speed_multiplier * 0.9
			c.spread_degrees = c.spread_degrees - 10
			draw_actions( 1, true )
		end,
	})

	table.insert(actions,
	{
		id          = "COPIS_THINGS_BOUNCE_100",
		name 		= "Hundredfold Bounce",
		description = "Causes a projectile to bounce many times",
		sprite 		= "mods/copis_things/files/sprites/spell_gui/bounce_100.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "2,3,4,5,6", -- BOUNCE
		spawn_probability                 = "1,1,0.4,0.2,0.2", -- BOUNCE
		price = 100,
		mana = 10,
		action 		= function()
			c.bounces = c.bounces + 100
			c.speed_multiplier = c.speed_multiplier * 1.2
			c.spread_degrees = c.spread_degrees - 10
			draw_actions( 1, true )
		end,
	})

	table.insert(actions,
	{
	id          = "COPIS_THINGS_SEPARATOR_CAST",
	name 		= "Separator cast",
	description = "Casts a projectile independent of any modifiers before it, like in a multicast",
	sprite 		= "mods/copis_things/files/sprites/spell_gui/separator_cast.png",
	type 		= ACTION_TYPE_UTILITY,
	spawn_level                       = "2,3,4,5,6", -- BOUNCE
	spawn_probability                 = "1,1,0.4,0.2,0.2", -- BOUNCE
	price = 100,
	mana = 0,
	action 		= function()
		add_projectile_trigger_death("mods/copis_things/files/entities/projectiles/separator_cast.xml", 1)
	end,
	})

	table.insert(actions,
	{
		id          = "COPIS_THINGS_SPREAD",
		name 		= "Spread",
		description = "Adds spread to a projectile",
		sprite 		= "mods/copis_things/files/sprites/spell_gui/spread.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level                       = "1,2,3,4,5,6", -- SPREAD_REDUCE
		spawn_probability                 = "0.8,0.8,0.8,0.8,0.8,0.8", -- SPREAD_REDUCE
		price = 100,
		mana = -5,
		action 		= function()
			c.spread_degrees = c.spread_degrees + 30.0
			c.fire_rate_wait   = c.fire_rate_wait - 5
			draw_actions( 1, true )
		end,
	})

	table.insert(actions,
	{
	id                 = "COPIS_THINGS_JSR_BLAST",
	name               = "JSR Blast",
	description        = "Fire a pulse of energy",
	sprite             = "mods/copis_things/files/sprites/spell_gui/jsr_blast.png",
	related_projectiles	= {"data/entities/projectiles/laser_bouncy.xml"},
	type               = ACTION_TYPE_PROJECTILE,
	spawn_level        = "0,0,0,0",
	spawn_probability  = "0,0,0,0",
	price              = 0,
	mana               = 0,
	action 		= function()
			add_projectile("data/entities/projectiles/laser_bouncy.xml")
			c.spread_degrees = c.spread_degrees - 2.0
			c.damage_projectile_add = c.damage_projectile_add - 0.25
		end,
	})

	table.insert(actions,
	{
	id                 = "COPIS_THINGS_DART",
	name               = "Dart",
	description        = "An accelerating magical dart that pierces soft materials",
	sprite             = "mods/copis_things/files/sprites/spell_gui/dart.png",
	related_projectiles	= {"mods/copis_things/files/entities/projectiles/dart.xml"},
	type               = ACTION_TYPE_PROJECTILE,
	spawn_level        = "0,1,2",
	spawn_probability  = "2,1,0.5",
	price              = 120,
	mana               = 7,
	action 		= function()
			add_projectile("mods/copis_things/files/entities/projectiles/dart.xml")
            c.fire_rate_wait = c.fire_rate_wait + 2;
		end,
	})