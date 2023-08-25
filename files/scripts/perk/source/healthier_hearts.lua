MaxHPLastFrame = MaxHPLastFrame or 0
local ent = GetUpdatedEntityID()
local dmc = EntityGetFirstComponentIncludingDisabled( ent, "DamageModelComponent" ) --[[@cast dmc number]]
local max_hp = ComponentGetValue2( dmc, "max_hp" )
local delta_max_hp = max_hp - MaxHPLastFrame
if delta_max_hp > 0 then
    local hp = ComponentGetValue2( dmc, "hp" )
    local vscs = EntityGetComponent(ent, "VariableStorageComponent") or {}
    local healthier_hearts_count = 0
    for i=1, #vscs do
        if ComponentGetValue2( vscs[i], "name" ) == "healthier_hearts_count" then
            healthier_hearts_count = ComponentGetValue2(vscs[i], "value_float")
            break
        end
    end
    ComponentSetValue2( dmc, "hp", math.min(max_hp, hp + (delta_max_hp  * healthier_hearts_count)))
end
MaxHPLastFrame = max_hp