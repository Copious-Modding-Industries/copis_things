function damage_about_to_be_received( damage, x, y, entity_thats_responsible, critical_hit_chance )
	if damage <= 0 then return damage, critical_hit_chance end
	EntityLoad("mods/copis_things/files/entities/misc/vfx_nettles_hit.xml", x, y)
    return damage+0.12, critical_hit_chance
end