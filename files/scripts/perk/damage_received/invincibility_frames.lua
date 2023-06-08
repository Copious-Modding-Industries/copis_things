function damage_received( damage, message, entity_thats_responsible, is_fatal, projectile_thats_responsible )
    local entity = GetUpdatedEntityID();
    if damage > 0 then
        if entity_thats_responsible ~= entity then
            local vscs = EntityGetComponent(entity, "VariableStorageComponent") or {}
            local vsc = nil
            for i=1, #vscs do
                if ComponentGetValue2( vscs[i], "name" ) == "invincibility_frames" then
                    vsc = vscs[i]
                    break
                end
            end
            if(vsc)then
                local invincibility_duration = ComponentGetValue2(vsc, "value_int")
                local dmcs = EntityGetComponentIncludingDisabled( entity, "DamageModelComponent" ) or {}
                for _, dmc in ipairs(dmcs) do
                    local current_invincibility_frames = ComponentGetValue2( dmc, "invincibility_frames" )
                    if current_invincibility_frames <= 0 then
                        ComponentSetValue2( dmc, "invincibility_frames", invincibility_duration )
                    end
                end
            end
        end
    end
end