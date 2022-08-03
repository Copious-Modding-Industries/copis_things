local path = "mods/copis_things/files/ui_gfx/gun_actions/replace/"
local actions_to_edit = {
    { "MATERIAL_ACID", "material_acid" },
    { "MATERIAL_BLOOD", "material_blood" },
    { "MATERIAL_CEMENT", "material_cement" },
    { "MATERIAL_OIL", "material_oil" },
    { "MATERIAL_WATER", "material_water" },
    { "BLACK_HOLE_DEATH_TRIGGER", "black_hole_death_trigger" },
    { "MINE_DEATH_TRIGGER", "mine_death_trigger" },
    { "PIPE_BOMB_DEATH_TRIGGER", "pipe_bomb_death_trigger" },
    { "SUMMON_HOLLOW_EGG", "summon_hollow_egg" },
}

for _, action_to_edit in ipairs(actions_to_edit) do
    for _, current_action in ipairs(actions) do
        if current_action.id == action_to_edit[1] then
            current_action.sprite = path .. action_to_edit[2] .. ".png"
        end
    end
end

