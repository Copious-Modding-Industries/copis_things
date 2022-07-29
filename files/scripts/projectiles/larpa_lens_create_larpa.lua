dofile_once("mods/copis_things/files/scripts/lib/disco_util/disco_util.lua")
local polytools = dofile_once("mods/copis_things/files/scripts/lib/polytools/polytools.lua")

function collision_trigger(colliding_entity_id)
    local proj = Entity.Wrap(colliding_entity_id)
    if proj.var_bool.copi_no_larpa then return end
    local px, py = proj:transform()
    proj.var_bool.copi_no_larpa = true
    proj:addComponent("LuaComponent", {
        script_source_file = "mods/azoth/files/actions/larpa_field/random_vel.lua",
        remove_after_executed = true
    })
    local data = polytools.save(proj)
    local copies = 2
    for i = 1, copies do polytools.spawn(px, py, data) end
end
