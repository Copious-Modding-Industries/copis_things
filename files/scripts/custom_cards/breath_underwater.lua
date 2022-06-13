function enabled_changed( entity_id, is_enabled )
    dofile_once("data/scripts/lib/utilities.lua")
    local root = EntityGetRootEntity(entity_id)
    local x, y = EntityGetTransform(entity_id)

    if is_enabled then
        if root ~= nil and root ~= 0 then
            local damage_model_component = EntityGetFirstComponent(root, "DamageModelComponent")
            ComponentSetValue2(damage_model_component, "air_in_lungs", 100)
        end
        LoadGameEffectEntityTo(root, "mods/copis_things/files/entities/misc/status_entities/effect_card_breath_underwater.xml")
    else
        for i, child_id in ipairs(EntityGetAllChildren(root) or {}) do
            local game_effect_component = EntityGetFirstComponentIncludingDisabled(child_id, "GameEffectComponent")
            if game_effect_component and EntityGetName(child_id) == "perk_passive" then
                EntityRemoveFromParent(child_id)
                EntityKill(child_id)
            end
        end
    end
end