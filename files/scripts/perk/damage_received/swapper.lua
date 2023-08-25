function damage_received( damage, message, responsible, is_fatal  )
    if EntityGetIsAlive( responsible ) then
        local entity_id = GetUpdatedEntityID()
        -- no self swaps + only enemies (TODO: mp support)
        if responsible ~= entity_id and (EntityHasTag( responsible, "enemy" )) then
            local sx,sy = EntityGetTransform( entity_id )
            local ax,ay = EntityGetTransform( responsible )
            -- the ol switcheroo (speed)
            local velcomp_enemy = EntityGetFirstComponent( entity_id, "VelocityComponent" )
            local velcomp_self = EntityGetFirstComponent( entity_id, "VelocityComponent" )
            if velcomp_self and velcomp_enemy then
                local avx,avy = ComponentGetValue2( velcomp_enemy, "mVelocity" )
                local svx,svy = ComponentGetValue2( velcomp_self, "mVelocity" )
                ComponentSetValue2( velcomp_enemy, "mVelocity", svx, svy )
                ComponentSetValue2( velcomp_self, "mVelocity", avx, avy )
            end
            -- do the real swappy
            EntitySetTransform( entity_id, ax, ay )
            EntitySetTransform( responsible, sx, sy )
            -- gfx
            EntityLoad( "data/entities/particles/teleportation_target.xml", sx, sy )
            EntityLoad( "data/entities/particles/teleportation_source.xml", ax, ay )
            for i=1,3 do EntityLoad( "data/entities/misc/invisibility_last_known_player_position.xml", sx, sy ) end -- i forgor why this is tripled, prob just makes enemies target it better
        end
    end
end