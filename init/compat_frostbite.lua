
-- fucking incomprehensible but it works
local function add_tag(xml)
	local attr_value_new = "warmth_affector"
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

--- ### Adds a component to an entity file.
--- ***
--- @param file_path string The path to the file you wish to add a component to.
--- @param comp string The component you wish to add.
function ModEntityFileAddComponent(file_path, comp)
    local file_contents = ModTextFileGetContent(file_path)
    local contents = file_contents:gsub("</Entity>$", function() return comp .. "</Entity>" end)
    ModTextFileSetContent(file_path, contents)
end

local files_to_edit = {
	{
		path = "mods/copis_things/files/entities/projectiles/firesphere.xml",
		amount = 40
	},
	{
		path = "mods/copis_things/files/entities/projectiles/ice_orb.xml",
		amount = -10
	},
	{
		path = "mods/copis_things/files/entities/projectiles/ice_cube.xml",
		amount = -20
	},
}

for i=1, #files_to_edit do
	local file = files_to_edit[i]
	local content = add_tag(ModTextFileGetContent(file.path))
	ModEntityFileAddComponent(content, [[<VariableStorageComponent name="warmth_affector" value_float="]] .. tostring(file.amount) .. [[" />]])
	ModTextFileSetContent(file.path, content)
end