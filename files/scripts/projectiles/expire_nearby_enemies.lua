dofile_once( "data/scripts/lib/utilities.lua" )

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
local targets = EntityGetInRadiusWithTag( pos_x, pos_y, 32, "homing_target" )

local projectile_comp = EntityGetFirstComponentIncludingDisabled( entity_id, "ProjectileComponent" )
if(projectile_comp)then
	local who_shot = ComponentGetValue2( projectile_comp, "mWhoShot" )
	for i, v in ipairs(targets)do
		if(v == who_shot)then
			table.remove(targets, i)
			break
		end
	end
end

if ( #targets > 0 ) then
	EntityKill(entity_id)
end