
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
	"data/entities/base_humanoid.xml",
	"data/entities/base_helpless_animal.xml",
	"data/entities/animals/fish.xml",
	"data/entities/animals/fish_large.xml",
	"data/entities/animals/boss_dragon.xml",
	"data/entities/animals/chest_leggy.xml",
	"data/entities/animals/boss_book/book_physics.xml",
	"data/entities/animals/boss_centipede/boss_centipede.xml",
	"data/entities/animals/boss_fish/fish_giga.xml",
	"data/entities/player.xml",
}

-- Add apotheosis creatures
if ModIsEnabled("apotheosis") then
	files_to_edit[#files_to_edit+1] = "data/entities/animals/fairy_cheap.xml"
end

for i=1, #files_to_edit do
	ModEntityFileAddComponent(files_to_edit[i], [[<LuaComponent execute_every_n_frame="-1" script_damage_received="mods/copis_things/init/enemypatcher/received.lua" />]])
	--ModEntityFileAddComponent(files_to_edit[i], [[<SpriteComponent image_file="data/debug/circle_16.png" />]]) -- display for DEBUG hide in gaming
end
