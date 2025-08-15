function damage_received( damage, message, entity_thats_responsible, is_fatal, projectile_thats_responsible  )
	local entity_id = GetUpdatedEntityID()
	local root = EntityGetRootEntity(entity_id)
	local x, y = EntityGetTransform(root)
	local mortals = EntityGetInRadiusWithTag(x, y, 64, "mortal")
	for i=1, #mortals do
		if mortals[i]==root then goto skip end
		local tx, ty = EntityGetTransform(mortals[i])
		local ray_x, ray_y = tx-x, ty-y
		local dist = ((ray_x*ray_x)+(ray_y*ray_y))^0.5
		local run, rise = ray_x/dist, ray_y/dist
		for j=0, dist do
			GameCreateCosmeticParticle("spark_teal", x+run*j, y+rise*j, 1, 0, 0, 0, 0.05, 0.05, true, true, false, false, 0, 0)
		end
		EntityInflictDamage(mortals[i], damage/3, "DAMAGE_CURSE", "Accelerant", "BLOOD_EXPLOSION", 0, 0, root)
		::skip::
	end
end