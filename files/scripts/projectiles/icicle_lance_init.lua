dofile_once("data/scripts/lib/utilities.lua")
local entity_id    = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
edit_component2( entity_id, "VelocityComponent", function(comp,vars)
	local vx, vy = ComponentGetValue2( comp, "mVelocity")
	ComponentSetValue2( comp, "mVelocity", vx * -2, vy * -2)
	vars.air_friction = -5
	vars.mass = 0.2
end)
edit_component2( entity_id, "ProjectileComponent", function(comp,vars)
	vars.bounces_left = 1
	vars.bounce_always = true
	vars.bounce_energy = 1
	vars.bounce_at_any_angle = true
    vars.ground_penetration_coeff = 1
end)
EntityAddTag( entity_id, "ice_shot" )
EntitySetComponentsWithTagEnabled(entity_id, "lance", true)
EntitySetComponentsWithTagEnabled(entity_id, "shot", false)
GamePlaySound("data/audio/Desktop/projectiles.bank", "projectiles/freeze_circle", x, y)
--[[
for _,value in ipairs(EntityGetAllChildren(entity_id) or {}) do
	EntitySetComponentsWithTagEnabled(value, "re_enable_homing", true)
end
]]

-- This genuinely hurts to look at. Purge with fire and build from the ground up, including homing patch.