local entity_id = GetUpdatedEntityID()
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

for comp, fns in pairs(fns_by_comp) do
	local comps = EntityGetComponentIncludingDisabled(entity_id, comp) or {}
	for i=1, #comps do
		for prop, func in pairs(fns) do
			ComponentSetValue2(comps[i], prop, func(ComponentGetValue2(comps[i], prop)))
		end
	end
end

