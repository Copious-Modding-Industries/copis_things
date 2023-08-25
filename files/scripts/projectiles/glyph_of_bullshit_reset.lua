local values = {
	{ "lob_min",                       0.0 },
	{ "lob_max",                       0.0 },
	{ "speed_min",                     10000 },
	{ "speed_max",                     10000 },
	{ "direction_random_rad",          0 },
	{ "on_death_explode",              false },
	{ "on_death_gfx_leave_sprite",     false },
	{ "on_lifetime_out_explode",       false },
	{ "collide_with_entities",         true },
	{ "explosion_dont_damage_shooter", true },
	{ "on_collision_die",              true },
	{ "die_on_liquid_collision",       false },
	{ "lifetime",                      -1 },
	{ "damage",                        0 },
	{ "ragdoll_force_multiplier",      0.0 },
	{ "hit_particle_force_multiplier", 0.0 },
	{ "camera_shake_when_shot",        0.0 },
	{ "bounce_energy",                 0 },
	{ "bounces_left",                  0 },
	{ "muzzle_flash_file",             "" },
	{ "shoot_light_flash_radius",      1 },
	{ "knockback_force",               0 },
	{ "physics_impulse_coeff",         0 },
	{ "penetrate_entities",            false },
	{ "penetrate_world",               true },
	{ "damage_every_x_frames",         1 },
	{ "collide_with_world",            false },
}
local component_whitelist = {
	ProjectileComponent     = true,
	ParticleEmitterComponent= true,
	VelocityComponent       = true,
	LuaComponent            = true,
	UIIconComponent         = true,
	GameAreaEffectComponent = true,
}
local entity_id = GetUpdatedEntityID()
local projcomp = EntityGetFirstComponent(entity_id, "ProjectileComponent") --[[@cast projcomp number]]
local comps = EntityGetAllComponents(entity_id) or {}
local luacs = EntityGetComponent(entity_id, "LuaComponent") or {}
for i = 1, #values do ComponentSetValue2(projcomp, values[i][1], values[i][2]) end
for i = 1, #comps do if not component_whitelist[ComponentGetTypeName(comps[i])] then EntityRemoveComponent(entity_id, comps[i]) end end
for i = 1, #luacs do if not ComponentGetValue2(luacs[i], "script_source_file") == "mods/copis_things/files/scripts/projectiles/glyph_of_bullshit_reset.lua" then EntityRemoveComponent(entity_id, luacs[i]) end end