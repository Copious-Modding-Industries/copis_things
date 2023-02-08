local entity_id = GetUpdatedEntityID()
local wand = EntityGetParent(entity_id)
local abilitycomp = EntityGetFirstComponentIncludingDisabled(wand, "AbilityComponent")
if abilitycomp ~= nil then
    local mana = ComponentGetValue2(abilitycomp, "mana")
    local max = ComponentGetValue2(abilitycomp, "mana_max")
    ComponentSetValue2(abilitycomp, "mana", math.min(max, mana + 1))
end