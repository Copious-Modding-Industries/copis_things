local path = "data/entities/animals/boss_alchemist/death.lua"
local contents = ModTextFileGetContent(path)
local greeks = {
    psi = ModSettingGet("copis_things_action_enabled_COPITH_PSI") or true,
    delta = ModSettingGet("copis_things_action_enabled_COPITH_DELTA") or true
}
-- inject greeks
contents = contents:gsub(
    [[local opts = { ]],
    table.concat{[[local opts = { ]] , greeks.psi and [["COPITH_PSI", ]] or "", greeks.delta and [["COPITH_DELTA", ]] or ""}
)
--[=[ boost drops FOR TESTING!!!
contents = contents:gsub(
    [[i=1,4]],
    [[i=1,12]]
)]=]
ModTextFileSetContent(path, contents)