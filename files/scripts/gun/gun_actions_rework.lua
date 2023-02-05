local SpriteOverridePath = "mods/copis_things/files/ui_gfx/gun_actions/replace/"
local actions_to_edit = {

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

    ["MATERIAL_METAL"] = {
        sprite = table.concat({SpriteOverridePath, "material_metal", ".png"})
    },

    ["GRAHAM_MATERIAL_PURE"] = {
        sprite = table.concat({SpriteOverridePath, "material_pure", ".png"})
    },

    ["GRAHAM_MATERIAL_RADIOACTIVE"] = {
        sprite = table.concat({SpriteOverridePath, "material_radioactive", ".png"})
    },

    ["MATERIAL_GOLD"] = {
        sprite = table.concat({SpriteOverridePath, "material_gold", ".png"})
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
            GamePrint(tostring(reload_delta))
            draw_actions(1, true)
        end,
    },

    ["GRAHAM_SPARK_BOLT"] = {
        name 		= "tloB krapS",
        description = "elitcejorp gnilkraps gnitnahcne tub kaew A",
    }

}

for actions_index = 1,#actions do
    for edit_id, edit_contents in pairs(actions_to_edit) do
        if actions[actions_index].id == edit_id then
            for key, value in pairs(edit_contents) do
                actions[actions_index][key] = value
            end
            actions_to_edit[edit_id] = nil
            break
        end
    end
end