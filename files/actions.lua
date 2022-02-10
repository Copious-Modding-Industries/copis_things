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

	table.insert(actions,
	{
		id          = "COPIS_THINGS_LUNGE",
		name 		= "Lunge",
		description = "Launch yourself forwards with a burst of speed",
		sprite 		= "data/ui_gfx/gun_actions/recoil.png",
		sprite_unidentified = "data/ui_gfx/gun_actions/recoil_unidentified.png",
		type 		= ACTION_TYPE_MODIFIER,
		spawn_level = "2,4",
		spawn_probability = "0.6,0.6",
		price = 100,
		mana = 5,
		action 		= function()
			shot_effects.recoil_knockback = shot_effects.recoil_knockback + 200.0
			draw_actions( 1, true )
		end,
	})

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
	mana = 10,
	sound_loop_tag = "sound_digger",
	action 		= function()
		add_projectile("mods/copis_things/files/entities/projectiles/sunsaber_dark.xml")
		c.fire_rate_wait = c.fire_rate_wait - 35
		current_reload_time = current_reload_time - ACTION_DRAW_RELOAD_TIME_INCREASE - 10
	end,
	})