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

for i, current_action in ipairs(actions) do                             -- for each action,
    for e, action_to_edit in ipairs(actions_to_edit) do                 -- go over each action we want to edit
        if current_action.id == action_to_edit then                     -- if they are the same,
            table.remove( actions_to_edit, e )                          -- check it off the list
            current_action.sprite = path .. action_to_edit .. ".png"    -- swap the sprite path
            break                                                       -- exit our edit list
        end                                                             -- checked for our spell to edit
    end                                                                 -- checked our edit list
end                                                                     -- checked all actions

--[[

    This file is by Copi/Human#6606
    Unending credit and thanks to Bruham/Mk IV QF 4-inch NAVAL GUN#5890!
    not only did they help with the optimizations,
    but also helped me figure things out with their insightful words!
    I've further edited this for simplicity, and as such it should be trivial to use.

]]