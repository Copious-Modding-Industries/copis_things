dofile_once( "mods/copis_things/files/scripts/lib/flags.lua");
dofile_once( "mods/copis_things/files/scripts/lib/disco_util/disco_util.lua")
dofile_once( "mods/copis_things/files/scripts/lib/polytools/polytools_init.lua").init( "mods/copis_things/files/scripts/lib/polytools/" )

--[[
function DoFileEnvironment( filepath, environment )
    if environment == nil then environment = {} end
    local f = loadfile( filepath );
    local set_f = setfenv( f, setmetatable( environment, { __index = _G } ) );
    local status,result = pcall( set_f );
    if status == false then print_error( "do file environment for "..filepath..": "..result ); end
    return environment;
end
]]


ModMaterialsFileAdd( "mods/copis_things/files/materials_nugget.xml" );
--ModMaterialsFileAdd( "mods/copis_things/files/materials.xml" )


--[[ Gun System Extension ]]
ModLuaFileAppend("data/scripts/gun/gun_extra_modifiers.lua", "mods/copis_things/files/scripts/gun/gun_extra_modifiers.lua")
ModLuaFileAppend("data/scripts/gun/gun_actions.lua", "mods/copis_things/files/scripts/gun/actions_sprite_replace.lua")
ModLuaFileAppend("data/scripts/gun/gun.lua", "mods/copis_things/files/scripts/gun/gun_append.lua")

--[[ Content ]]
ModLuaFileAppend("data/scripts/gun/gun_actions.lua", "mods/copis_things/files/actions.lua")
ModLuaFileAppend("data/scripts/perks/perk_list.lua", "mods/copis_things/files/scripts/perk/perk_list.lua")
ModLuaFileAppend("data/scripts/status_effects/status_list.lua", "mods/copis_things/files/scripts/status/status_list.lua")

--[[ Dev spell ]]
if DebugGetIsDevBuild() then
    ModLuaFileAppend("data/scripts/gun/gun_actions.lua", "mods/copis_things/files/actions_dev.lua")
else
    ModLuaFileAppend("data/scripts/gun/gun_actions.lua", "mods/copis_things/files/actions_dev_meta.lua")
end


--ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/copis_things/files/scripts/gun/generate_random_spellbooks.lua" )

local translations = ModTextFileGetContent( "data/translations/common.csv" );
if translations ~= nil then
	while translations:find("\r\n\r\n") do
		translations = translations:gsub("\r\n\r\n","\r\n");
	end
	local new_translations = ModTextFileGetContent( "mods/copis_things/files/translations/common.csv" );
	translations = translations .. new_translations;
	ModTextFileSetContent( "data/translations/common.csv", translations );
end

function OnPlayerSpawned( player_entity ) --This runs when player entity has been created
    GlobalsSetValue( "mod_button_tr_width", "0" );
	GamePrint( "OnPlayerSpawned() - Player entity id: " .. tostring(player_entity) )
    --DoFileEnvironment( "mods/copi_noita/files/gkbrkn/player_spawned.lua", { player_entity = player_entity } );
end

function OnWorldInitialized()
    local mod_button_reservation = tonumber( GlobalsGetValue( "mod_button_tr_width", "0" ) );
    GlobalsSetValue( "copi_mod_button_reservation", tostring( mod_button_reservation ) );
    GlobalsSetValue( "mod_button_tr_width", tostring( mod_button_reservation + 15 ) );
end

function OnWorldPreUpdate()
	if GlobalsGetValue( "copi_mod_button_tr_max", "0" ) == "0" then
		GlobalsSetValue( "copi_mod_button_tr_max", GlobalsGetValue( "mod_button_tr_width", "0" ) );
	end
	--dofile( "mods/copis_things/files/scripts/gui/update.lua" );
end


GamePrint("Copi's things INDEV 0.01")