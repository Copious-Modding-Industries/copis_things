---@diagnostic disable-next-line: lowercase-global
function item_pickup( entity_item, entity_who_picked, name )
    local luacs = EntityGetComponent(entity_item, "LuaComponent") or {}
    for i=1, #luacs do
        if ComponentGetValue2(luacs[i], "script_source_file")=="mods/copis_things/files/scripts/perk/misc/card_levitate.lua" then
            EntityRemoveComponent(entity_item, luacs[i])
        end
    end
end