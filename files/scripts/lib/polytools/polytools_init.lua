local polytools = {}

---Call this on mod initialization to let it know where it is and
---@param polytools_path string
function polytools.init(polytools_path)
    polytools_path = polytools_path .. "/"
    polytools_path = string.gsub(polytools_path, "/+", "/")
    local mod_files = {"apply.lua", "delay_load.lua", "depoly_death.lua", "effect_silent.xml",
                       "effect.xml", "fix_physics.lua", "fix_projectiles.lua", "null.xml",
                       "polytools.lua", "ui/heart.lua", "ui/heart.xml", "ui/nugget.xml",
                       "ui/on_remove.lua", "ui/player_base_hide.xml", "ui/player_base_worm.xml",
                       "ui/player_base.xml", "ui/polywand_switch.lua", "ui/polywand_throw.lua",
                       "ui/polywand.lua", "ui/polywand.xml"}
    for k, v in ipairs(mod_files) do
        local file_path = polytools_path .. v
        local text = ModTextFileGetContent(file_path)
        text = string.gsub(text, "%[POLYTOOLS_PATH%]", polytools_path)
        ModTextFileSetContent(file_path, text)
    end
end

return polytools
