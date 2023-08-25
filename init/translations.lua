local translations = ModTextFileGetContent( "data/translations/common.csv" )
if translations ~= nil then
	while translations:find("\r\n\r\n") do
		translations = translations:gsub("\r\n\r\n","\r\n")
	end
    local files = {"perks", "actions"}
    for _, file in ipairs(files) do
        local new_translations = ModTextFileGetContent( table.concat({"mods/copis_things/files/translations/", file, ".csv"}) )
        translations = translations .. new_translations
    end
	ModTextFileSetContent( "data/translations/common.csv", translations )
end

-- TODO: rewrite this absolute fucking mess