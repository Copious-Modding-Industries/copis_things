
-- fucking incomprehensible but it works
local function add_tag(xml, attr_value_new)
    local attr_value_old = nil
    local new_xml = xml:gsub("(<%s*[%w]+)(.-)(/?>)",
		function(first_tag, attrs, last_tag)
			if attrs:find("tags=") then
				attr_value_old = attrs:match('tags=["\'](.-)["\']')
				if attr_value_old then
					attr_value_new = attr_value_old .. "," .. attr_value_new
				end
				attrs = attrs:gsub('tags=(["\']).-["\']', table.concat{'tags="', attr_value_new, '"'})
			else
				attrs = table.concat{attrs, ' ', 'tags="', attr_value_new, '"'}
			end
        return table.concat{first_tag, attrs, last_tag}
    end, 1)
    return new_xml
end

local files_to_edit = {
	{
		path = "mods/copis_things/files/entities/projectiles/firesphere.xml",
		tag = "warm"
	},
	{
		path = "mods/copis_things/files/entities/projectiles/ice_orb.xml",
		tag = "cold_passive"
	},
	{
		path = "mods/copis_things/files/entities/projectiles/ice_cube.xml",
		tag = "cold"
	},
}

for i=1, #files_to_edit do
	local file = files_to_edit[i]
	print(ModTextFileGetContent(file.path))
	ModTextFileSetContent(file.path, add_tag(ModTextFileGetContent(file.path), file.tag))
	print(ModTextFileGetContent(file.path))
end