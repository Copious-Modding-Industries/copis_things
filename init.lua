-- all functions below are optional and can be left out
ModLuaFileAppend("data/scripts/gun/gun_actions.lua", "mods/copis_things/files/actions.lua")
-- ModLuaFileAppend("data/scripts/gun/gun_actions.lua", "mods/copis_things/files/actions_removed.lua")

--[[

function OnModPreInit()
	print("Mod - OnModPreInit()") -- First this is called for all mods
end

function OnModInit()
	print("Mod - OnModInit()") -- After that this is called for all mods
end

function OnModPostInit()
	print("Mod - OnModPostInit()") -- Then this is called for all mods
end
]]--

function OnPlayerSpawned( player_entity ) -- This runs when player entity has been created
	GamePrint( "OnPlayerSpawned() - Player entity id: " .. tostring(player_entity) )
	EntityLoad("mods/copis_things/files/entities/special_wands/hammer/hammer.xml", 20, -100)
	EntityLoad("mods/copis_things/files/entities/special_wands/earthworm/earthworm.xml", 40, -100)
	EntityLoad("mods/copis_things/files/entities/special_wands/tachamis/tachamis.xml", 60, -100)
	EntityLoad("mods/copis_things/files/entities/special_wands/frostburn/frostburn.xml", 80, -100)
	EntityLoad("mods/copis_things/files/entities/special_wands/hellfire/hellfire.xml", 100, -100)
	EntityLoad("mods/copis_things/files/entities/special_wands/energy_blaster/energy_blaster.xml", 120, -100)
	EntityLoad("mods/copis_things/files/entities/special_wands/viper/viper.xml", 140, -100)
	EntityLoad("mods/copis_things/files/entities/special_wands/twig/twig.xml", 160, -100)
	EntityLoad("mods/copis_things/files/entities/special_wands/lonk_sword/lonk_sword.xml", 180, -100)

	EntityLoad("mods/copis_things/files/entities/special_wands/twisted/twisted.xml", 20, -120)
	EntityLoad("mods/copis_things/files/entities/special_wands/tome_edgy/tome_edgy.xml", 40, -120)
	EntityLoad("mods/copis_things/files/entities/special_wands/tome_decay/tome_decay.xml", 60, -120)
	EntityLoad("mods/copis_things/files/entities/special_wands/tome_blank/tome_blank.xml", 80, -120)

	EntityLoad("mods/copis_things/files/entities/special_wands/luminous_saber/luminous_saber.xml", 20, -140)
	EntityLoad("mods/copis_things/files/entities/special_wands/dark_sunsaber/dark_sunsaber.xml", 40, -140)

	EntityLoad("mods/copis_things/files/entities/special_wands/essence/Charybdis/Charybdis.xml", 20, -160)
	EntityLoad("mods/copis_things/files/entities/special_wands/essence/Igneous/Igneous.xml", 40, -160)
	EntityLoad("mods/copis_things/files/entities/special_wands/essence/Drunkard/Drunkard.xml", 60, -160)

	EntityLoad("mods/copis_things/files/entities/items/books/book_hint_sword/book_hint_sword.xml", 20, -170)
	EntityLoad("mods/copis_things/files/entities/items/books/book_hint_starter/book_hint_starter.xml", 40, -170)
end

local content = ModTextFileGetContent("data/translations/common.csv")
ModTextFileSetContent("data/translations/common.csv", content .. [[
book_hint_starter_description,A witch is one gifted with a power like no other. \nIt can be used for good, or evil, \nyet magic has no affiliation of it's own. \nWether you use it to bring \ncalamity to a world or restore peace, \nthat is up to you, gifted one.,,,,,,,,,,,,,
forge_perk_FORGE_ALCHEMISTERY,Alechemistery,,,,,,,,,,,,,
]])

--[[


function OnWorldInitialized() -- This is called once the game world is initialized. Doesn't ensure any world chunks actually exist. Use OnPlayerSpawned to ensure the chunks around player have been loaded or created.
end


function OnWorldPreUpdate() -- This is called every time the game is about to start updating the world
	GamePrint( "Pre-update hook " .. tostring(GameGetFrameNum()) )
end

function OnWorldPostUpdate() -- This is called every time the game has finished updating the world
	GamePrint( "Post-update hook " .. tostring(GameGetFrameNum()) )
end


function OnMagicNumbersAndWorldSeedInitialized() -- this is the last point where the Mod* API is available. after this materials.xml will be loaded.
	local x = ProceduralRandom(0,0)
	print( "===================================== random " .. tostring(x) )

end

]]--

-- This code runs when all mods' filesystems are registered

GamePrint("Cope")