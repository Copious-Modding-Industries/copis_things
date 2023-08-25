function EditSizeManager(entity, set, amount)
	local vscs = EntityGetComponent(entity, "VariableStorageComponent") or {}
	for i=1, #vscs do
		if ComponentGetValue2(vscs[i], "name") == "copi_scaling" then
			
		end
	end
end


--SpriteComponent
--GameAreaEffectComponent
--ParticleEmitterComponent









return {EditSizeManager=EditSizeManager}


