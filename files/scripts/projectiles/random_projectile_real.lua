local entity_id = GetUpdatedEntityID()
local x, y, r = EntityGetTransform(entity_id)
local projcomp = EntityGetFirstComponentIncludingDisabled(entity_id, "ProjectileComponent")--[[@cast projcomp number]]
local spritecomp = EntityGetFirstComponentIncludingDisabled(entity_id, "SpriteComponent")--[[@cast spritecomp number]]
--math.randomseed(Random(entity_id,GetUpdatedComponentID())%r,x+y^256*r+entity_id+GameGetFrameNum())
-- works fine without, with it just repeats or shit
ComponentSetValue2(projcomp, "lifetime",										math.random(10,100))
ComponentSetValue2(projcomp, "lifetime_randomness",								math.random(5,20))
ComponentSetValue2(projcomp, "on_lifetime_out_explode",							math.random()>0.9)
ComponentSetValue2(projcomp, "collide_with_world",								math.random(1,2)==1)
ComponentSetValue2(projcomp, "speed_min",										math.random(50, 200))
ComponentSetValue2(projcomp, "speed_max",										math.random(200, 1000)+math.max(math.random(-20,1),0)*50)
ComponentSetValue2(projcomp, "friction",										math.random())
ComponentSetValue2(projcomp, "direction_random_rad",							math.random(0.785)*math.random(0,1))
ComponentSetValue2(projcomp, "direction_nonrandom_rad",							math.random(0.785)*math.random(0,1))
ComponentSetValue2(projcomp, "lob_min",											math.random())
ComponentSetValue2(projcomp, "lob_max",											math.random())
ComponentSetValue2(projcomp, "camera_shake_when_shot",							math.random(-5,5))
ComponentSetValue2(projcomp, "shoot_light_flash_radius",						math.random(0,100))
ComponentSetValue2(projcomp, "shoot_light_flash_r",								math.random(0,255))
ComponentSetValue2(projcomp, "shoot_light_flash_g",								math.random(0,255))
ComponentSetValue2(projcomp, "shoot_light_flash_b",								math.random(0,255))
ComponentSetValue2(projcomp, "create_shell_casing",								false)
ComponentSetValue2(projcomp, "shell_casing_material",							"brass")
ComponentSetValue2(projcomp, "muzzle_flash_file",								"data/entities/particles/muzzle_flashes/muzzle_flash_medium.xml")
ComponentSetValue2(projcomp, "bounces_left",									math.max(0, math.random(-30, 10)))
ComponentSetValue2(projcomp, "bounce_energy",									math.random()*1.5)
ComponentSetValue2(projcomp, "bounce_always",									math.random(1,2)==1)
ComponentSetValue2(projcomp, "bounce_at_any_angle",								math.random(1,2)==1)
ComponentSetValue2(projcomp, "attach_to_parent_trigger",						false)
ComponentSetValue2(projcomp, "bounce_fx_file",									"")
ComponentSetValue2(projcomp, "angular_velocity",								math.max(0, math.random(-25, 5))*math.random())
ComponentSetValue2(projcomp, "velocity_sets_rotation",							true)
ComponentSetValue2(projcomp, "velocity_sets_scale",								math.random(1,2)==1)
ComponentSetValue2(projcomp, "velocity_sets_scale_coeff",						math.random(1,2))
ComponentSetValue2(projcomp, "velocity_sets_y_flip",							math.random(1,2)==1)
ComponentSetValue2(projcomp, "velocity_updates_animation",						math.random(0,2))
ComponentSetValue2(projcomp, "ground_penetration_coeff",						math.random(0,6))
ComponentSetValue2(projcomp, "ground_penetration_max_durability_to_destroy",	math.random(1,12))
ComponentSetValue2(projcomp, "go_through_this_material",						"")
ComponentSetValue2(projcomp, "do_moveto_update",								true)
ComponentSetValue2(projcomp, "on_death_duplicate_remaining",					0)
ComponentSetValue2(projcomp, "on_death_gfx_leave_sprite",						math.random(1,2)==1)
ComponentSetValue2(projcomp, "on_death_explode",								math.random()>0.9)
ComponentSetValue2(projcomp, "on_death_emit_particle",							math.random(1,2)==1)
ComponentSetValue2(projcomp, "on_death_emit_particle_count",					math.random(1,100))
ComponentSetValue2(projcomp, "die_on_liquid_collision",							math.random(1,2)==1)
ComponentSetValue2(projcomp, "die_on_low_velocity",								math.random(1,2)==1)
ComponentSetValue2(projcomp, "die_on_low_velocity_limit",						math.random(-30,5))
ComponentSetValue2(projcomp, "on_death_emit_particle_type",						"fire")
ComponentSetValue2(projcomp, "on_death_particle_check_concrete",				true)
ComponentSetValue2(projcomp, "ground_collision_fx",								math.random(1,2)==1)
ComponentSetValue2(projcomp, "explosion_dont_damage_shooter",					math.random(1,2)==1)
ComponentSetValue2(projcomp, "on_death_item_pickable_radius",					0)
ComponentSetValue2(projcomp, "penetrate_world",									math.random()>0.80)
ComponentSetValue2(projcomp, "penetrate_world_velocity_coeff",					math.random())
ComponentSetValue2(projcomp, "penetrate_entities",								math.random(1,2)==1)
ComponentSetValue2(projcomp, "on_collision_die",								math.random(1,2)==1)
ComponentSetValue2(projcomp, "on_collision_remove_projectile",					false)
ComponentSetValue2(projcomp, "on_collision_spawn_entity",						false)
ComponentSetValue2(projcomp, "spawn_entity",									"")
ComponentSetValue2(projcomp, "spawn_entity_is_projectile",						false)
ComponentSetValue2(projcomp, "physics_impulse_coeff",							math.random(100,600))
ComponentSetValue2(projcomp, "damage_every_x_frames",							1)
ComponentSetValue2(projcomp, "damage_scaled_by_speed",							math.random(1,2)==1)
ComponentSetValue2(projcomp, "damage_scale_max_speed",							math.random(5,300))
ComponentSetValue2(projcomp, "collide_with_entities",							true)
ComponentSetValue2(projcomp, "collide_with_tag",								"hittable")
ComponentSetValue2(projcomp, "dont_collide_with_tag",							"")
ComponentSetValue2(projcomp, "collide_with_shooter_frames",						math.random(5,20))
ComponentSetValue2(projcomp, "friendly_fire",									math.random(1,2)==1)
ComponentSetValue2(projcomp, "damage",											math.random())
ComponentSetValue2(projcomp, "knockback_force",									math.random())
ComponentSetValue2(projcomp, "ragdoll_force_multiplier",						math.random())
ComponentSetValue2(projcomp, "hit_particle_force_multiplier",					math.random())
ComponentSetValue2(projcomp, "blood_count_multiplier",							math.random())
ComponentSetValue2(projcomp, "never_hit_player",								math.random(1,2)==1)
ComponentSetValue2(projcomp, "collect_materials_to_shooter",					false)
ComponentSetValue2(projcomp, "play_damage_sounds",								math.random(1,2)==1)
ComponentSetValue2(projcomp, "mLastFrameDamaged",								-1024)


local sprites = {
	{
		image_file = "data/projectiles_gfx/spark.xml",
		next_rect_animation = "data/projectiles_gfx/spark.xml",
		rect_animation = "data/projectiles_gfx/spark.xml",
	},
	{
		image_file = "data/projectiles_gfx/lance.xml",
		next_rect_animation = "",
		rect_animation = "",
	},
	{
		image_file = "data/projectiles_gfx/lance_holy.xml",
		next_rect_animation = "",
		rect_animation = "",
	},
	{
		image_file = "data/projectiles_gfx/grenade_purple.xml",
		next_rect_animation = "",
		rect_animation = "",
	},
	{
		image_file = "data/enemies_gfx/deer.xml",
		next_rect_animation = "",
		rect_animation = "stand",
	},
	{
		image_file = "data/projectiles_gfx/fireball_smaller_green.xml",
		next_rect_animation = "",
		rect_animation = "fireball",
	},
	{
		image_file = "data/projectiles_gfx/slow_bullet.xml",
		next_rect_animation = "",
		rect_animation = "fireball",
	},
	{
		image_file = "data/projectiles_gfx/fireball_small_magic.xml",
		next_rect_animation = "",
		rect_animation = "",
	},
	{
		image_file = "data/projectiles_gfx/arrow.xml",
		next_rect_animation = "",
		rect_animation = "",
	},
	{
		image_file = "data/projectiles_gfx/disc_bullet.xml",
		next_rect_animation = "",
		rect_animation = "",
	},
	{
		image_file = "data/projectiles_gfx/disc_bullet_bigger.xml",
		next_rect_animation = "",
		rect_animation = "",
	},
	{
		image_file = "data/projectiles_gfx/black_hole.xml",
		next_rect_animation = "",
		rect_animation = "fireball",
	},
	{
		image_file = "mods/copis_things/files/projectiles_gfx/anvil.png",
		next_rect_animation = "",
		rect_animation = "",
	},
	{
		image_file = "mods/copis_things/files/projectiles_gfx/matra_magic.xml",
		next_rect_animation = "",
		rect_animation = "default",
	},
	{
		image_file = "mods/copis_things/files/projectiles_gfx/silver_magnum.xml" ,
		next_rect_animation = "default",
		rect_animation = "default",
	},
	{
		image_file = "mods/copis_things/files/projectiles_gfx/icicle_lance.xml" ,
		next_rect_animation = "default",
		rect_animation = "default",
	},

}

local sprite = sprites[math.random(1, #sprites)]

ComponentSetValue2(spritecomp, "image_file",					sprite.image_file)
ComponentSetValue2(spritecomp, "ui_is_parent",					false)
ComponentSetValue2(spritecomp, "is_text_sprite",				false)
ComponentSetValue2(spritecomp, "offset_x",						0)
ComponentSetValue2(spritecomp, "offset_y",						0)
ComponentSetValue2(spritecomp, "alpha",							math.random()*1.5)
ComponentSetValue2(spritecomp, "visible",						true)
ComponentSetValue2(spritecomp, "emissive",						math.random(1,2)==1)
ComponentSetValue2(spritecomp, "additive",						math.random(1,2)==1)
ComponentSetValue2(spritecomp, "fog_of_war_hole",				math.random(1,2)==1)
ComponentSetValue2(spritecomp, "smooth_filtering",				false)
ComponentSetValue2(spritecomp, "rect_animation",				sprite.rect_animation)
ComponentSetValue2(spritecomp, "next_rect_animation",			sprite.next_rect_animation)
ComponentSetValue2(spritecomp, "text",							"")
ComponentSetValue2(spritecomp, "z_index",						1)
ComponentSetValue2(spritecomp, "update_transform",				true)
ComponentSetValue2(spritecomp, "update_transform_rotation",		true)
ComponentSetValue2(spritecomp, "kill_entity_after_finished",	false)
ComponentSetValue2(spritecomp, "has_special_scale",				math.random(1,2)==1)
ComponentSetValue2(spritecomp, "special_scale_x",				1+math.random(-1,0)*2)
ComponentSetValue2(spritecomp, "special_scale_y",				1+math.random(-1,0)*2)
ComponentSetValue2(spritecomp, "never_ragdollify_on_death",		true)


















