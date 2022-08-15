local options = {
    GoldPickupTracker = {
        TrackDuration = 180, -- in game frames
        ShowMessageFlag = "copis_things_gold_tracking_message",
        ShowTrackerFlag = "copis_things_gold_tracking_in_world",
    },
    InvincibilityFrames = {
        Duration = "copis_things_invincibility_frames_duration",
        EnabledFlag = "copis_things_invincibility_frames",
        FlashingFlag = "copis_things_invincibility_frames_flashing",
    },
    HealOnMaxHealthUp = {
        RangeFlag = "copis_things_max_health_heal_range",
        EnabledFlag = "copis_things_max_health_heal",
        FullHealFlag = "copis_things_max_health_heal_full",
    },
    InfiniteInventory = { EnabledFlag = "copis_things_infinite_inventory", },
    LooseSpellGeneration = { EnabledFlag = "copis_things_loose_spell_generation", },
    ChampionEnemies = {
        EnabledFlag = "copis_things_champion_enemies",
        SuperChampionsFlag = "copis_things_champion_enemies_super",
        AlwaysChampionsFlag = "copis_things_champion_enemies_always",
        MiniBossesFlag = "copis_things_champion_enemies_mini_bosses",
        ValourFlag = "copis_things_champion_enemies_valour",
        ShowIconsFlag = "copis_things_champion_enemies_show_icons",
        ChampionChance = 0.20,
        MiniBossChance = 0.10, -- rolled after champion chance only if mini boss kill threshold has been met
        MiniBossThreshold = 50, -- the amount of enemies that must be killed before a miniboss can spawn
        ExtraTypeChance = 0.05,
        ValourBonus = 3,
    },
    QuickSwap = { EnabledFlag = "copis_things_quick_swap", },
    SeededRuns = {
        UseSeedNextRunFlag = "copis_things_seeded_runs_use_seed_next_run",
        SeedFlag = "copis_things_seeded_runs_seed",
        CopySeedButtonFlag = "copis_things_seeded_runs_copy_seed",
    },
    LessParticles = {
        PlayerProjectilesFlag = "copis_things_less_particles_player",
        OtherStuffFlag = "copis_things_less_particles_other_stuff",
        ExplosionStainsFlag = "copis_things_less_particles_explosion_stains",
        DisableCosmeticsFlag = "copis_things_less_particles_disable_cosmetic"
    },
    RainbowProjectiles = { EnabledFlag = "copis_things_rainbow_projectiles" },
    RandomStart = {
        RandomWandsFlag = "copis_things_random_start_random_wands",
        RandomPrimaryWandFlag = "copis_things_random_start_primary_wand",
        RandomSecondaryWandFlag = "copis_things_random_start_secondary_wand",
        RandomExtraWandFlag = "copis_things_random_start_extra_wand",
        RandomHealthFlag = "copis_things_random_start_random_health",
        MinimumHP = 50,
        MaximumHP = 150,
        CustomWandGenerationFlag = "copis_things_random_start_custom_wands",
        RandomCapeColorFlag = "copis_things_random_start_random_cape",
        RandomFlaskFlag = "copis_things_random_start_random_flask",
        RandomPerkFlag = "copis_things_random_start_random_perk",
        RandomPerksFlag = "copis_things_random_start_random_perks",
    },
    LegendaryWands = {
        EnabledFlag = "copis_things_legendary_wands",
        SpawnWeighting = 0.03,
    },
    ExtendedWandGeneration = { EnabledFlag = "copis_things_extended_wand_generation", },
    ChaoticWandGeneration = { EnabledFlag = "copis_things_chaotic_wand_generation", },
    AlternativeWandGeneration = { EnabledFlag = "copis_things_alternative_wand_generation", },
    ShowFPS = { EnabledFlag = "copis_things_show_fps", },
    HealthBars = {
        RangeFlag = "copis_things_health_bars_range",
        EnabledFlag = "copis_things_health_bars",
        PrettyHealthBarsFlag = "copis_things_health_bars_pretty",
    },
    PackShops = {
        EnabledFlag = "copis_things_pack_shops",
        RandomCardsPerPack = 1,
        CardsPerPack = 4,
    },
    GoldDecay = { EnabledFlag = "copis_things_gold_decay",},
    GoldLifetime = { EnabledFlag = "copis_things_gold_lifetime_multiplier", },
    PersistentGold = { EnabledFlag = "copis_things_persistent_gold", },
    AutoPickupGold = { EnabledFlag = "copis_things_auto_pickup_gold", },
    CombineGold = {
        EnabledFlag = "copis_things_combine_gold",
        Radius = 48,
    },
    PassiveRecharge = {
        EnabledFlag = "copis_things_passive_recharge",
        Speed = 1
    },
    TargetDummy = {
        EnabledFlag = "copis_things_target_dummy",
        AllowEnvironmentalDamage = "copis_things_target_dummy_environmental"
    },
    SlotMachine = { EnabledFlag = "copis_things_slot_machine", },
    ShopReroll = { EnabledFlag = "copis_things_shop_reroll", },
    Loadouts = {
        ManageFlag = "copis_things_loadouts_manage",
        EnabledFlag = "copis_things_loadouts_enabled",
        UnlockLoadouts = "copis_things_unlock_loadouts",
        CapeColorFlag = "copis_things_loadouts_cape_color",
        PlayerSpritesFlag = "copis_things_loadouts_player_sprites",
        ClassyFrameworkIntegrationFlag = "copis_things_classy_framework_integration",
        SelectableClassesIntegrationFlag = "copis_things_selectable_classes_integration",
    },
    HeroMode = {
        EnabledFlag = "copis_things_hero_mode",
        OrbsDifficultyFlag = "copis_things_hero_mode_orb_scale",
        DistanceDifficultyFlag = "copis_things_hero_mode_distance_scale",
        CarnageDifficultyFlag = "copis_things_hero_mode_carnage",
    },
    NoPregenWands = { EnabledFlag = "copis_things_no_pregen_wands", },
    ChestsContainPerks = {
        EnabledFlag = "copis_things_chests_contain_perks",
        Chance=0.12,
        SuperChance=0.25,
        RemovePerkTag=false, -- this makes it so that picking up other perks doesn't kill this perk. might have side effects!!!
        DontKillOtherPerks=true,
    },
    ManageExternalContent = { EnabledFlag = "copis_things_manage_external_content", },
    ShowModTips = {
        EnabledFlag = "copis_things_mod_tips",
        Tips = {
            "$mod_tips_copis_things_tip_1",
            "$mod_tips_copis_things_tip_2",
            "$mod_tips_copis_things_tip_3",
            "$mod_tips_copis_things_tip_4",
            "$mod_tips_copis_things_tip_5",
            "$mod_tips_copis_things_tip_6",
            "$mod_tips_copis_things_tip_7",
            "$mod_tips_copis_things_tip_8",
            "$mod_tips_copis_things_tip_9",
            "$mod_tips_copis_things_tip_10",
        }
    },
    Badges = { EnabledFlag = "copis_things_show_badges", },
    ShowEntityNames = { EnabledFlag = "copis_things_show_entity_names", },
    ShowPerkDescriptions = { EnabledFlag = "copis_things_show_perk_descriptions", },
    ShowDamageNumbers = { EnabledFlag = "copis_things_show_damage_numbers", },
    FixedCamera = { EnabledFlag = "copis_things_fixed_camera", OldBehaviourFlag = "copis_things_fixed_camera_old" },
    Events = { EnabledFlag = "copis_things_events", },
    AutoHide = { EnabledFlag = "copis_things_auto_hide", },
    RemoveEditPrompt = { EnabledFlag = "copis_things_remove_edit_prompt", },
    PerkOptions = {
        MagicFocus = {
            DecayFrames = 60,
            ChargeFrames = 240,
        },
        BloodMagic = {
            BloodToManaRatio = 1,
            FreeAlwaysCasts = true,
            DamageMultiplier = 5,
        },
        Resilience = { 
            Resistances = {
                fire=0.33,
                radioactive=0.33,
                poison=0.33,
                electricity=0.33,
            }
        },
        ManaEfficiency = {
            Discount = 0.33
        },
        SpellEfficiency = {
            RetainChance = 0.33
        },
        LivingWand = {
            TeleportDistance = 128
        }
    },
    TweakOptions = {
        BloodAmountMultiplier = 0.98
    },
    PerkRewrite = {
        StackableChangesFlag = "copis_things_new_perk_stackables",
        NewLogicFlag = "copis_things_new_perk_logic",
        ShowBarGraphFlag = "copis_things_new_perk_bar_graph",
    }
}
--# intercept this line
return options