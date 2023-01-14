local to_insert = {
    {
        id                = "DEV",
        name              = "Dev",
        description       = "cast state data",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/dev_meta.png",
        type              = ACTION_TYPE_OTHER,
        spawn_level       = "0,0",
        spawn_probability = "0,0",
        price             = 0,
        mana              = 0,
        ai_never_uses     = true,
        action            = function(recursion_level, iteration)
            if not reflecting then
                print("[COPI'S THINGS CAST STATE PRINT START]")
                for k, v in pairs(c) do
                    print(k .. " = " .. tostring(v));
                end
                print("[COPI'S THINGS CAST STATE PRINT END]")
            end
        end,
    },

    {
        id                = "TEST_NOITHEOGONY",
        name              = "TEST_NOITHEOGONY",
        description       = "A powerful attack where one spins with their blade, cleaving enemies around them.\n \n \n Type: [Blade]\n Stamina: [1]\n Melee damage: [6]\n Slice damage: [4]",
        sprite            = "mods/copis_things/files/ui_gfx/gun_actions/dev_meta.png",
        type              = ACTION_TYPE_OTHER,
        spawn_level       = "0,0",
        spawn_probability = "0,0",
        price             = 0,
        mana              = 0,
        ai_never_uses     = true,
        action            = function(recursion_level, iteration)
            if not reflecting then
                GamePrint("Hello!")
            end
        end,
    },
}

for _, action in ipairs(to_insert) do
    ModSettingGet(table.concat({ "copis_things_rework_", action.id }))




    action.id = "COPIS_THINGS_" .. action.id
    table.insert(actions, action)
end

local path = "mods/copis_things/files/ui_gfx/gun_actions/replace/"
local rework_ids = {
    "MATERIAL_ACID",
    "MATERIAL_BLOOD",
    "MATERIAL_CEMENT",
    "MATERIAL_OIL",
    "MATERIAL_WATER",
    "BLACK_HOLE_DEATH_TRIGGER",
    "MINE_DEATH_TRIGGER",
    "PIPE_BOMB_DEATH_TRIGGER",
    "SUMMON_HOLLOW_EGG",
}

local rework_actions = {
    SLOW_BUT_STEADY = {
        id                  = "SLOW_BUT_STEADY",
        name                = "$action_slow_but_steady",
        description         = "The reload time of the wand is set to 1 second, but you gain damage depending on how fast your wand used to be!",
        sprite              = "mods/copis_things/files/ui_gfx/gun_actions/replace/",
        sprite_unidentified = "data/ui_gfx/gun_actions/spread_reduce_unidentified.png",
        spawn_requires_flag = "card_unlocked_maths",
        type                = ACTION_TYPE_MODIFIER,
        spawn_level         = "3,4,5,6,10", -- LIFETIME
        spawn_probability   = "0.1,0.2,0.3,0.4,0.4", -- LIFETIME
        price               = 50,
        mana                = 0,
        action              = function()
            local new_reload = 60
            local reload_delta = (new_reload - current_reload_time) / 60
            current_reload_time = new_reload
            GamePrint(tostring(reload_delta))
            shot_effects.recoil_knockback = shot_effects.recoil_knockback - 80.0
            draw_actions(1, true)
        end,
    },
}

for i_, current_action in ipairs(actions) do
    for rework_index, action_to_rework in ipairs(rework_ids) do
        if current_action.id == action_to_rework then
            table.remove(action_to_rework, rework_index)
            current_action = rework_actions[action_to_rework]
            break
        end
    end
end

local rework_enabled = {}
for _, rework in ipairs(rework_ids) do
    rework_enabled[rework] = ModSettingGet(table.concat({ "copis_things_rework_", rework })) or false
end