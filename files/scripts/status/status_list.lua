local to_insert = {
    {
        id="COPIS_THINGS_BUFF_RECHARGE",
        ui_name="Reduce recharge",
        ui_description="Reduces the time between spellcasts",
        ui_icon="mods/copis_things/files/ui_gfx/status_indicators/buff_recharge.png",
        effect_entity="mods/copis_things/files/entities/misc/status_entities/buff_recharge.xml",
    },
    {
        id="COPIS_THINGS_PASSIVE_ATTACK_FOOT",
        ui_name="Reduce recharge",
        ui_description="Reduces the time between spellcasts",
        ui_icon="mods/copis_things/files/ui_gfx/status_indicators/buff_recharge.png",
        effect_entity="mods/copis_things/files/entities/misc/status_entities/buff_recharge.xml",
    },
}

for k, v in ipairs(to_insert) do
    table.insert(status_effects, v)
end