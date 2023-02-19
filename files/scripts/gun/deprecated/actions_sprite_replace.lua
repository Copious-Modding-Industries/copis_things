local path = "mods/copis_things/files/ui_gfx/gun_actions/replace/"
local actions_to_edit = {
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

for actions_index = 1,#actions do
    for edit_index = 1,#actions_to_edit do
        if actions[actions_index].id == actions_to_edit[edit_index] then
            table.remove( actions_to_edit, edit_index )
            actions[actions_index].sprite = table.concat({path, actions_to_edit[edit_index], ".png"})
            break
        end
    end
end

--[[

    This file is by Copi/Human#6606
    Unending credit and thanks to Bruham/Mk IV QF 4-inch NAVAL GUN#5890!
    not only did they help with the optimizations,
    but also helped me figure things out with their insightful words!
    I've further edited this for simplicity, and as such it should be trivial to use.

]]