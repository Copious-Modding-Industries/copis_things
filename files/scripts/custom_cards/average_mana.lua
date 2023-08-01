local card = GetUpdatedEntityID()
local shooter = EntityGetRootEntity(card)
local now = GameGetFrameNum()
-- only run passive once per frame per shooter, so multiple stacks don't fuck things up
_G['ENTITY_LAST_FRAME'] = _G['ENTITY_LAST_FRAME'] or {}
if _G['ENTITY_LAST_FRAME'][shooter] ~= now then
    local wand = EntityGetParent(card)
    local inv_quick = EntityGetParent(wand)
    local wands = EntityGetAllChildren(inv_quick) or {}
    local mana_sum = 0
    for i=1, #wands do
        local ability = EntityGetFirstComponentIncludingDisabled(wands[i], "AbilityComponent") --[[@cast ability number]]
        mana_sum = mana_sum + ComponentGetValue2(ability, "mana_charge_speed")
    end
    local ability = EntityGetFirstComponentIncludingDisabled(wand, "AbilityComponent") --[[@cast ability number]]
    local thismana = ComponentGetValue2(ability, "mana")
    ComponentSetValue2(ability, "mana", math.max(0, thismana - ComponentGetValue2(ability, "mana_charge_speed")/60) + (mana_sum/#wands)/60)
    _G['ENTITY_LAST_FRAME'][shooter] = now
end