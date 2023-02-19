local upgrades = {
    ["data/entities/projectiles/deck/light_bullet"] = "data/entities/projectiles/deck/light_bullet_blue",
    ["data/entities/projectiles/deck/death_cross.xml"] = "data/entities/projectiles/deck/death_cross_big",
    ["data/entities/projectiles/deck/spitter"] = "data/entities/projectiles/deck/spitter_tier_2",
    ["data/entities/projectiles/deck/spitter_tier_2"] = "data/entities/projectiles/deck/spitter_tier_3",
    ["data/entities/projectiles/deck/disc_bullet"] = "data/entities/projectiles/deck/disc_bullet_big",
    ["data/entities/projectiles/deck/disc_bullet_big"] = "data/entities/projectiles/deck/disc_bullet_bigger",
    ["data/entities/projectiles/deck/rocket"] = "data/entities/projectiles/deck/rocket_tier_2",
    ["data/entities/projectiles/deck/rocket_tier_2"] = "data/entities/projectiles/deck/rocket_tier_3",
    ["data/entities/projectiles/deck/grenade"] = "data/entities/projectiles/deck/grenade_tier_2",
    ["data/entities/projectiles/deck/grenade_tier_2"] = "data/entities/projectiles/deck/grenade_tier_3",
    ["data/entities/projectiles/deck/digger"] = "data/entities/projectiles/deck/powerdigger",
    ["data/entities/projectiles/deck/tentacle"] = "data/entities/projectiles/deck/bloodtentacle",
    ["data/entities/projectiles/deck/magic_shield_start"] = "data/entities/projectiles/deck/big_magic_shield_start",
    ["data/entities/projectiles/bomb_holy"] = "data/entities/projectiles/bomb_holy_giga",
    ["data/entities/projectiles/deck/tntbox"] = "data/entities/projectiles/deck/tntbox_big",
    ["data/entities/projectiles/deck/nuke"] = "data/entities/projectiles/deck/nuke_giga",
    -- Copi's Things Content
    ["mods/copis_things/files/entities/projectiles/orb_laseremitter_small"] = "data/entities/projectiles/deck/orb_laseremitter_cutter",
    ["mods/copis_things/files/entities/projectiles/silver_bullet"] = "mods/copis_things/files/entities/projectiles/silver_magnum",
    ["data/entities/projectiles/deck/disc_bullet_bigger"] = "mods/copis_things/files/entities/projectiles/zenith_disc",
    ["mods/copis_things/files/entities/projectiles/zenith_disc"] = "mods/copis_things/files/entities/projectiles/eviscerator",
}

-- Varia Addons mod support
if ModIsEnabled("variaAddons") then
    upgrades["mods/variaAddons/files/entities/projectiles/small_rocket"] = "data/entities/projectiles/deck/rocket"
    upgrades["mods/variaAddons/files/entities/projectiles/bullet_player"] = "mods/variaAddons/files/entities/projectiles/sniper_bullet_player"
end

-- Apotheosis mod support
if ModIsEnabled("Apotheosis") then
    upgrades["data/entities/projectiles/bomb"] = "mods/Apotheosis/files/entities/projectiles/deck/bomb_giga"
    upgrades["mods/Apotheosis/files/entities/projectiles/deck/rat_bite"] = "mods/Apotheosis/files/entities/projectiles/deck/rat_bite_crit"
end

-- More Creeps & Weirdos mod support
if ModIsEnabled("mo_creeps") then
    upgrades["data/entities/projectiles/bomb"] = "mods/mo_creeps/files/entities/projectiles/deck/bomb_giga"
    upgrades["mods/mo_creeps/files/entities/projectiles/deck/rat_bite"] = "mods/mo_creeps/files/entities/projectiles/deck/rat_bite_crit"
end

return upgrades