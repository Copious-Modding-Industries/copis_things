local to_insert = {
    {
        id="COPITH_BUFF_RECHARGE",
        ui_name="Reduce recharge",
        ui_description="Reduces the time between spellcasts",
        ui_icon="mods/copis_things/files/ui_gfx/status_indicators/buff_recharge.png",
        effect_entity="mods/copis_things/files/entities/misc/status_entities/buff_recharge.xml",
    },
    {
        id              = "COPITH_INSTAKILL",
        ui_name         = "$effect_name_copis_things_instakill",
        ui_description  = "$effect_desc_copis_things_instakill",
        ui_icon         = "mods/copis_things/files/ui_gfx/status_indicators/buff_recharge.png",
        effect_entity   = "mods/copis_things/files/entities/misc/status_entities/buff_recharge.xml",
    },
    {
        id              = "COPITH_COLD_HEARTED",
        ui_name         = "$effectname_copith_cold_hearted",
        ui_description  = "$effectdesc_copith_cold_hearted",
        ui_icon         = "mods/copis_things/files/ui_gfx/status_indicators/cold_hearted.png",
        effect_entity   = "mods/copis_things/files/entities/misc/status_entities/cold_hearted.xml",
    },

    --[[ Shouldn't be handled as a status effect, what was I thinking lmao
    {
        id="COPITH_ENTITY_LARPA",
        ui_name         = "$effect_name_copis_things_entity_larpa",
        ui_description  = "$effect_desc_copis_things_entity_larpa",
        ui_icon         = "mods/copis_things/files/ui_gfx/status_indicators/buff_recharge.png",
        effect_entity   = "mods/copis_things/files/entities/misc/status_entities/buff_recharge.xml",
    },]]
}
local len = #status_effects
for i = 1, #to_insert do
    status_effects[len+i] = to_insert[i]
end