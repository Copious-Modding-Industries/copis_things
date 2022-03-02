
dofile_once( "data/scripts/lib/utilities.lua" )

local entity_id    = GetUpdatedEntityID()

local x, y = EntityGetTransform( entity_id )

local parent_id = EntityGetParent( entity_id )

local target_id = 0

if ( parent_id ~= NULL_ENTITY ) then
	target_id = parent_id
else
	target_id = entity_id
end

if ( target_id ~= NULL_ENTITY ) then
	local projectile_components = EntityGetComponent( target_id, "ProjectileComponent" )
	
	if( projectile_components == nil ) then return end
	
	if ( #projectile_components > 0 ) then
		edit_component( target_id, "ProjectileComponent", function(comp,vars)
			vars.die_on_low_velocity = 0
		end)
	end
end

edit_component2( entity_id, "VelocityComponent", function(comp,vars)
  vars.gravity_y = 0
  vars.air_friction= 8
  vars.mass= 0
end)











--[[
dofile_once("data/scripts/lib/utilities.lua")
local entity_id    = GetUpdatedEntityID()
edit_component2( entity_id, "VelocityComponent", function(comp,vars)
    vars.gravity_y = 0
    vars.air_friction= 1200
    vars.mass= 0.05
end)
edit_component( entity_id, "ProjectileComponent", function(comp,vars)
    vars.die_on_low_velocity = 0
end)
]]