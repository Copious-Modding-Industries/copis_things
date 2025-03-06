local translations = ModTextFileGetContent("data/translations/common.csv")
if translations == nil then
	return
end

local files = { "perks", "actions" }
for _, file in ipairs(files) do
	local new_translations =
		ModTextFileGetContent(table.concat({ "mods/copis_things/files/translations/", file, ".csv" }))
	translations = translations .. "\n" .. new_translations .. "\n"
end
translations = translations:gsub("\r", ""):gsub("\n\n+", "\n")
ModTextFileSetContent("data/translations/common.csv", translations)

