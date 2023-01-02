function HealthyHeartsHandler( player_id, max_hp_last_frame )
    local dmc = EntityGetFirstComponentIncludingDisabled( player_id, "DamageModelComponent" )
    local max_hp = ComponentGetValue2( dmc, "max_hp" )
    local delta_max_hp = max_hp - max_hp_last_frame
    if delta_max_hp > 0 then
        local hp = ComponentGetValue2( dmc, "hp" )
        ComponentSetValue2( dmc, hp, (delta_max_hp / 2) * tonumber(GlobalsGetValue( "HealthyHeartStacks", "0" )))
    end
    return max_hp
end
return HealthyHeartsHandler