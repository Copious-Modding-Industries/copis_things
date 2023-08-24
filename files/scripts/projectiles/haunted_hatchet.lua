local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

local targets = EntityGetInRadiusWithTag( x, y, 128, "homing_target" ) or {}
for i=1, #targets do
	local target = targets[i]
	if not (EntityHasTag(target, "death_ghost") or EntityHasTag(target, "polymorphed")) then
		EntityAddTag( target, "death_ghost" )
		EntityAddComponent2( target, "LuaComponent", {
			script_death = "mods/copis_things/files/scripts/projectiles/haunted_hatchet_ghost.lua",
			execute_every_n_frame = -1,
		})
	end
end