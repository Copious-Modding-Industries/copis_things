dofile_once( "mods/copis_things/files/scripts/lib/Noitilities/NL_init.lua").init( "mods/copis_things/files/scripts/lib/Noitilities/" )
dofile_once( "mods/copis_things/files/scripts/lib/Noitilities/ModuleLoader.lua" ).Load({"Translations", "GunPatch"})



dofile_once( "mods/copis_things/files/scripts/lib/helper.lua" );
dofile_once( "mods/copis_things/files/scripts/lib/flags.lua" );
local MISC = dofile_once( "mods/copis_things/files/scripts/lib/options.lua" );
dofile_once( "mods/copis_things/files/scripts/lib/variables.lua" );
dofile_once( "mods/copis_things/files/scripts/lib/config.lua" );
dofile("data/scripts/lib/utilities.lua")
--[[

Hello seeker of knowledge.

I will speak many words to you through the past present and future.
But for now, rid yourself of this domain, as it is unstable and incomplete.
To base your future on the chaotic state of this project would only worsen them.
Now flee, escape until this primordial slate of commands is in it's final state.

]]

ModMaterialsFileAdd( "mods/copis_things/files/materials_nugget.xml" );
--ModMaterialsFileAdd( "mods/copis_things/files/materials.xml" )


--[[ Gun System Content ]]
dofile_once("mods/copis_things/init/gun.lua")

--[[ Content ]]
ModLuaFileAppend("data/scripts/perks/perk_list.lua", "mods/copis_things/files/scripts/perk/perk_list.lua")
ModLuaFileAppend("data/scripts/status_effects/status_list.lua", "mods/copis_things/files/scripts/status/status_list.lua")

--[[ Dev content ]]
if DebugGetIsDevBuild() then
    ModLuaFileAppend("data/scripts/gun/gun_actions.lua", "mods/copis_things/files/actions_dev.lua")
else
    --ModLuaFileAppend("data/scripts/gun/gun_actions.lua", "mods/copis_things/files/actions_dev_meta.lua")
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

GamePrint("Copi's things INDEV 0.01")