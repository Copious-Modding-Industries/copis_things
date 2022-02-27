
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
			local component = EntityGetFirstComponent(player, "CharacterDataComponent")
			local pos_x, pos_y = EntityGetTransform( player )
			local mouse_x, mouse_y = ComponentGetValue2(EntityGetFirstComponentIncludingDisabled(player, "ControlsComponent"), "mMousePosition")
			EntitySetTransform(player, pos_x, pos_y - 3)
			ComponentSetValue2( component, "mVelocity",  (mouse_x - pos_x) * 4, (mouse_y - pos_y) * 2)
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

