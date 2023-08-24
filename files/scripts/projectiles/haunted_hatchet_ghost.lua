dofile_once("data/scripts/lib/utilities.lua")
-- find a way to check if the killing shot is the hatchet
function death(damage_type_bit_field, damage_message, entity_thats_responsible, drop_items)
	local entity_id    = GetUpdatedEntityID()
	local pos_x, pos_y = EntityGetTransform(entity_id)
	if (#EntityGetWithTag("death_ghost") < 30) then
		local eid = EntityLoad("data/entities/misc/perks/death_ghost.xml", pos_x, pos_y)
		local ltc = EntityGetFirstComponent(eid, "LifetimeComponent") --[[@cast ltc number]]
		ComponentSetValue2(ltc, "lifetime", 600)
		ComponentSetValue2(ltc, "kill_frame", GameGetFrameNum() + 600)
		local children = EntityGetAllChildren(eid) or {}
		for i=1, #children do
			local comp = EntityGetFirstComponent(children[i], "AreaDamageComponent")
			if (comp ~= nil) then
				local damage = 0.07
				ComponentSetValue2(comp, "damage_per_frame", 0.07)
			end
		end
	end
end
