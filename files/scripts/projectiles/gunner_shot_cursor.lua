dofile_once( "data/scripts/lib/utilities.lua" )

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
local controls = EntityGetFirstComponentIncludingDisabled(EntityGetWithTag("player_unit")[1], "ControlsComponent")

if controls ~= nil then
	if ComponentGetValue2( controls, "mButtonDownRightClick" ) == true then
		local mouse_x, mouse_y = ComponentGetValue2(controls, "mMousePosition")
		local aim_x = mouse_x - pos_x
		local aim_y = mouse_y - pos_y
		local len = math.sqrt((aim_x^2) + (aim_y^2))
		local force = 90
		local projectile = "mods/copis_things/files/entities/projectiles/gunner_shot.xml"

		local eid = shoot_projectile_from_projectile( entity_id, projectile, pos_x, pos_y, (aim_x/len*force), (aim_y/len*force) )
		EntityAddTag( eid, "projectile_cloned" )
	end
end



