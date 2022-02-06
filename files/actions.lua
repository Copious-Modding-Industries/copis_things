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
	description        = "A little stabby stabby",
	sprite             = "mods/copis_things/files/sprites/spell_gui/stab.png",
	related_projectiles	= {"mods/copis_things/files/entities/projectiles/stab.xml"},
	type               = ACTION_TYPE_PROJECTILE,
	spawn_level        = "0,1,3,5",
	spawn_probability  = "0.9,0.9,0.9,0.9",
	price              = 110,
	mana               = 15,
	action 		= function()
			add_projectile("mods/copis_things/files/entities/projectiles/stab.xml")
			c.fire_rate_wait = c.fire_rate_wait + 7
			c.screenshake = c.screenshake + 0.7
			c.spread_degrees = c.spread_degrees - 2.0
			c.damage_critical_chance = c.damage_critical_chance + 15
		end,
	})