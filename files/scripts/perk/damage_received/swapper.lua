function damage_about_to_be_received( damage, x, y, entity_thats_responsible, critical_hit_chance )
    print(tostring(entity_thats_responsible))
    if entity_thats_responsible == nil then
        local player_id = GetUpdatedEntityID()
        local vsc_id = EntityGetFirstComponentIncludingDisabled( player_id, "VariableStorageComponent", "A_USEFUL_TAG_NO_ONE_ELSE_HAS_USED"  )
        ComponentSetValue2( vsc_id, "value_float", damage )
        return 0, critical_hit_chance
    end
    return damage, critical_hit_chance
end