MaxHPLastFrame = MaxHPLastFrame or 0
local ent = GetUpdatedEntityID()
local dmc = EntityGetFirstComponentIncludingDisabled( ent, "DamageModelComponent" )
local max_hp = ComponentGetValue2( dmc, "max_hp" )
local delta_max_hp = max_hp - MaxHPLastFrame
if delta_max_hp > 0 then
    local hp = ComponentGetValue2( dmc, "hp" )
    local vsc = EntityGetFirstComponentIncludingDisabled(ent, "VariableStorageComponent", "healthier_hearts_count");
    local healthier_hearts_count = ComponentGetValue2(vsc, "value_float")
    ComponentSetValue2( dmc, "hp", math.min(max_hp, hp + (delta_max_hp  * healthier_hearts_count)))
end
MaxHPLastFrame = max_hp