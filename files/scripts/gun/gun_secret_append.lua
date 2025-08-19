actions[#actions+1] = { -- rare esoteric bullshit
	id                  = "COPITH_RANDOM_PROJECTILE_REAL",
	name                = "$actionname_copith_random_projectile_real",
	description         = "$actiondesc_copith_random_projectile_real",
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
		-- TODO make 'glitchier', twitch events?
		if reflecting then return end
		for i=1, math.random(1,3) do
			add_projectile("mods/copis_things/files/entities/projectiles/random_projectile_real.xml")
		end
	end,
}
