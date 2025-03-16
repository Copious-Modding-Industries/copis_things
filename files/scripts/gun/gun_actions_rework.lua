local SpriteOverridePath = "mods/copis_things/files/ui_gfx/gun_actions/replace/"
-- TODO! Use sprite edit functions to replace.
local actions_to_edit = {

    -- Vanilla material spells

    ["MATERIAL_ACID"] = {
        sprite = table.concat({SpriteOverridePath, "material_acid", ".png"})
    },

    ["MATERIAL_BLOOD"] = {
        sprite = table.concat({SpriteOverridePath, "material_blood", ".png"})
    },

    ["MATERIAL_CEMENT"] = {
        sprite = table.concat({SpriteOverridePath, "material_cement", ".png"})
    },

    ["MATERIAL_OIL"] = {
        sprite = table.concat({SpriteOverridePath, "material_oil", ".png"})
    },

    ["MATERIAL_WATER"] = {
        sprite = table.concat({SpriteOverridePath, "material_water", ".png"})
    },

    -- Mo stuff material spells

    ["MATERIAL_METAL"] = {
        sprite = table.concat({SpriteOverridePath, "material_metal", ".png"})
    },
    
    -- Graham material spells

    ["GRAHAM_MATERIAL_PURE"] = {
        sprite = table.concat({SpriteOverridePath, "material_pure", ".png"})
    },

    ["GRAHAM_MATERIAL_RADIOACTIVE"] = {
        sprite = table.concat({SpriteOverridePath, "material_radioactive", ".png"})
    },

    
    -- Midas suite material spells

    ["MATERIAL_GOLD"] = {
        sprite = table.concat({SpriteOverridePath, "material_gold", ".png"})
    },


    -- Apo material spells
    --[[
    Leaving these ready to uncomment in case conga does anything with the commented out spells as per my suggestion in dms, to save myself some time

    ["APOTHEOSIS_MATERIAL_LAVA"] = {    -- NOTE! Move copi's things material lava sprite into replace folder, and use vanilla style for material spells, so people can toggle off and have consistency; do same override sprite in here
        sprite = table.concat({SpriteOverridePath, "material_lava", ".png"})
    },

    ]]
    ["APOTHEOSIS_MATERIAL_ALCOHOL"] = {
        sprite = table.concat({SpriteOverridePath, "material_alcohol", ".png"})
    },

    ["APOTHEOSIS_MATERIAL_SLIME"] = {
        sprite = table.concat({SpriteOverridePath, "material_slime", ".png"})
    },

    ["BLACK_HOLE_DEATH_TRIGGER"] = {
        sprite = table.concat({SpriteOverridePath, "black_hole_death_trigger", ".png"})
    },

    ["MINE_DEATH_TRIGGER"] = {
        sprite = table.concat({SpriteOverridePath, "mine_death_trigger", ".png"})
    },

    ["PIPE_BOMB_DEATH_TRIGGER"] = {
        sprite = table.concat({SpriteOverridePath, "pipe_bomb_death_trigger", ".png"})
    },

    ["SUMMON_HOLLOW_EGG"] = {
        sprite = table.concat({SpriteOverridePath, "summon_hollow_egg", ".png"})
    },

    ["SLOW_BUT_STEADY"] = {
        description = "The reload time of the wand is set to 1 second, but you gain damage depending on how fast your wand used to be!",
        sprite = table.concat({SpriteOverridePath, "slow_but_steady", ".png"}),
        spawn_requires_flag = nil,
        mana = 24,
        action = function()
            local new_reload = 60
            local reload_delta = (new_reload - current_reload_time)
            current_reload_time = new_reload
            c.damage_projectile_add = c.damage_projectile_add + (reload_delta/25)
            draw_actions(1, true)
        end,
    },

	--[[
    ["RANDOM_SPELL"] = {
        description = "Draws any one random spell at half cost!",
        sprite = table.concat({SpriteOverridePath, "random_spell", ".png"}),
        spawn_requires_flag = nil,
        mana = 0,
        action = function()
            if not reflecting then
                copi_state.mana_multiplier = copi_state.mana_multiplier * 0.5
                GunUtils.temporary_deck(
                    function( deck, hand, discarded )
                        local flag = "action_" .. deck[1].id:lower()
                        local progress_remove = not HasFlagPersistent( flag )
                        draw_actions( 1, true )
                        if progress_remove then
                            RemoveFlagPersistent( flag )
                        end
                    end,
                    GunUtils.deck_from_actions( {actions[math.random(1, #actions)]} ), {}, {} )
                copi_state.mana_multiplier = copi_state.mana_multiplier * 2.0
            end
        end,
    },]]

    ["GRAHAM_SPARK_BOLT"] = {
        name 		= "tloB krapS",
        description = "elitcejorp gnilkraps gnitnahcne tub kaew A",
    },

}

for i=1,#actions do -- fast as fuck boi
    if actions_to_edit[actions[i].id] then
        for key, value in pairs(actions_to_edit[actions[i].id]) do
            actions[i][key] = value
        end
        actions[i]['copis_things_reworked'] = true
    end
end