local path = "data/entities/animals/boss_alchemist/death.lua"
local contents = ModTextFileGetContent(path)
local greeks = {
    psi = ModSettingGet("copis_things_action_enabled_COPIS_THINGS_PSI") or true,
    delta = ModSettingGet("copis_things_action_enabled_COPIS_THINGS_DELTA") or true
}
-- inject greeks
contents = contents:gsub(
    [[local opts = { ]],
    table.concat{[[local opts = { ]] , greeks.psi and [["COPIS_THINGS_PSI", ]] or "", greeks.delta and [["COPIS_THINGS_DELTA", ]] or ""}
)
--[=[ boost drops FOR TESTING
contents = contents:gsub(
    [[i=1,4]],
    [[i=1,8]]
)]=]
ModTextFileSetContent(path, contents)