local to_insert = {
    {
        id="COPIS_THINGS_ON_CRIT_DAMAGE",
        ui_name="Damage plus (critical bonus)",
        ui_description="A brief projectile damage bonus granted from a critical hit",
        ui_icon="mods/copis_things/files/ui_gfx/status_indicators/on_crit_damage.png",
        effect_entity="mods/copis_things/files/entities/misc/status_entities/on_crit_damage.xml",
    },
    {
        id="COPIS_THINGS_ON_CRIT_RECHARGE",
        ui_name="Reduce recharge (critical bonus)",
        ui_description="A brief wand recharge time bonus granted from a critical hit",
        ui_icon="mods/copis_things/files/ui_gfx/status_indicators/on_crit_recharge.png",
        effect_entity="mods/copis_things/files/entities/misc/status_entities/on_crit_recharge.xml",
    },
    {
        id="COPIS_THINGS_ON_CRIT_SPEED",
        ui_name="Speed up (critical bonus)",
        ui_description="A brief projectile speed bonus granted from a critical hit",
        ui_icon="mods/copis_things/files/ui_gfx/status_indicators/on_crit_speed.png",
        effect_entity="mods/copis_things/files/entities/misc/status_entities/on_crit_speed.xml",
    },
    {
        id="COPIS_THINGS_ON_CRIT_PIERCING",
        ui_name="Piercing shot (critical bonus)",
        ui_description="A brief projectile piercing bonus granted from a critical hit",
        ui_icon="mods/copis_things/files/ui_gfx/status_indicators/on_crit_piercing.png",
        effect_entity="mods/copis_things/files/entities/misc/status_entities/on_crit_piercing.xml",
    },
    {
        id="COPIS_THINGS_ON_DAMAGE_DAMAGE",
        ui_name="Damage plus (damage bonus)",
        ui_description="A brief projectile damage bonus granted from a regular hit",
        ui_icon="mods/copis_things/files/ui_gfx/status_indicators/on_damage_damage.png",
        effect_entity="mods/copis_things/files/entities/misc/status_entities/on_damage_damage.xml",
    },
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