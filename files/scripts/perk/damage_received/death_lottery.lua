function damage_received(is_fatal)
    if not is_fatal then
        GamePrint("AA")
        local entity = GetUpdatedEntityID();
        local kill = false
        SetRandomSeed(GameGetFrameNum(), 666)
        GamePrint(Random(1,2))
        if Random(1,2) == 2 then
            kill = false
            GamePrint("Hey!")
        else
            kill = true
        end

        local damage_models = EntityGetComponent( entity, "DamageModelComponent" );
        if damage_models ~= nil then
            for i,damage_model in pairs( damage_models ) do
                local max_hp = ComponentGetValue2( damage_model, "max_hp" );
                if not kill then
                    ComponentSetValue2( damage_model, "hp", max_hp / 2);
                end 
                ComponentSetValue2( damage_model, "kill_now", kill);
            end
        end
    end
end