function damage_about_to_be_received( damage, x, y, entity_thats_responsible, critical_hit_chance )
    local chardatcomp = EntityGetFirstComponentIncludingDisabled(GetUpdatedEntityID(), "CharacterDataComponent");
    if chardatcomp ~= nil then
        local airtime = GameGetFrameNum() - ComponentGetValue2( chardatcomp, "mLastFrameOnGround" )
        local reduction = math.min(45, 2*(airtime^(1/2)))/100
        damage = damage * (1-reduction)
        ComponentSetValue2(chardatcomp, "mFlyingTimeLeft", ComponentGetValue2(chardatcomp, "mFlyingTimeLeft")/1.2)
    end
    return damage, critical_hit_chance
end