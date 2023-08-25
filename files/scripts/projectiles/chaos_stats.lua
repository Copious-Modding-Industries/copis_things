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
	ProjectileComponent      = true,
	ParticleEmitterComponent = true,
	VelocityComponent        = true,
	LuaComponent             = true,
	UIIconComponent          = true,
	GameAreaEffectComponent  = true,
}
local entity_id = GetUpdatedEntityID()
local projcomp = EntityGetFirstComponent(entity_id, "ProjectileComponent") --[[@cast projcomp number]]
local comps = EntityGetAllComponents(entity_id) or {}
local luacs = EntityGetComponent(entity_id, "LuaComponent") or {}
for i = 1, #values do ComponentSetValue2(projcomp, values[i][1], values[i][2]) end
for i = 1, #comps do if not component_whitelist[ComponentGetTypeName(comps[i])] then EntityRemoveComponent(entity_id,
			comps[i]) end end
for i = 1, #luacs do if not ComponentGetValue2(luacs[i], "script_source_file") == "mods/copis_things/files/scripts/projectiles/glyph_of_bullshit_reset.lua" then
		EntityRemoveComponent(entity_id, luacs[i]) end end


local fns = {
	damage_every_x_frames = function(old)
		return math.max(1, old + math.random(-3, 5))
	end,
	collide_with_world = function(old)
		return math.random() + (old and 0.33 or 0) > 0.33
	end,
	damage = function(old)
		return old + math.random(-5, 5)
	end,
	speed_min = function(old)
		return old - math.random(0, 5)
	end,
	speed_max = function(old)
		return old + math.random(0, 5)
	end,
	lifetime = function(old)
		return math.max(4, old + math.random(-35, 50))
	end,
}
local members = ComponentGetMembers(projcomp) or {}
for i=1, #members do
	local member = members[i]
	if fns[member] then
		local old = ComponentGetValue2(projcomp, member)
		ComponentSetValue2(projcomp, member, fns[member](old))
	end
end



local fns_by_comp = {
	ProjectileComponent = {
		damage_every_x_frames = function(old)
			return math.max(1, old + math.random(-3, 5))
		end,
		collide_with_world = function(old)
			return math.random() + (old and 0.33 or 0) > 0.33
		end,
		damage = function(old)
			return old + math.random(-5, 5)
		end,
		speed_min = function(old)
			return old - math.random(0, 5)
		end,
		speed_max = function(old)
			return old + math.random(0, 5)
		end,
		lifetime = function(old)
			return math.max(4, old + math.random(-35, 50))
		end,
	},
	AreaDamageComponent = {
		damage_type = function (old)
			return ({
			"DAMAGE_MELEE",
			"DAMAGE_PROJECTILE",
			"DAMAGE_EXPLOSION",
			"DAMAGE_FIRE",
			"DAMAGE_ELECTRICITY",
			"DAMAGE_DROWNING",
			"DAMAGE_DRILL",
			"DAMAGE_SLICE",
			"DAMAGE_ICE",
			"DAMAGE_RADIOACTIVE",
			"DAMAGE_POISON",})[math.random(1,11)]
		end,
		update_every_n_frame = function (old)
			return math.max(1, old + math.random(-3, 5))
		end,
		damage_per_frame = function(old)
			return old + math.random(-1, 1)
		end,
	},
	VelocityComponent = {
		gravity_x = function (old)
			return (math.random()>0.66) and (old + math.random(-200, 200)) or 0
		end,
		gravity_y = function (old)
			return (math.random()>0.66) and (old + math.random(-200, 200)) or 0
		end,
		mass = function (old)
			return old + math.random(0, 0.2)
		end,
		air_friction = function (old)
			return old + math.random(-1, 1)
		end,
		terminal_velocity = function (old)
			return old
		end,
		liquid_drag = function (old)
			return old
		end,
	}
}