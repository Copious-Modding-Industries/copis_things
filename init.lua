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
	EntityLoad("mods/copis_things/files/entities/special_wands/hammer/hammer.xml", 20, -80)
	EntityLoad("mods/copis_things/files/entities/special_wands/earthworm/earthworm.xml", 40, -80)
	EntityLoad("mods/copis_things/files/entities/special_wands/tachamis/tachamis.xml", 60, -80)
	EntityLoad("mods/copis_things/files/entities/special_wands/frostburn/frostburn.xml", 80, -80)
	EntityLoad("mods/copis_things/files/entities/special_wands/hellfire/hellfire.xml", 100, -80)
	EntityLoad("mods/copis_things/files/entities/special_wands/energy_blaster/energy_blaster.xml", 120, -80)
	EntityLoad("mods/copis_things/files/entities/special_wands/viper/viper.xml", 140, -80)
	EntityLoad("mods/copis_things/files/entities/special_wands/twig/twig.xml", 160, -80)
	EntityLoad("mods/copis_things/files/entities/special_wands/lonk_sword/lonk_sword.xml", 180, -80)
	EntityLoad("mods/copis_things/files/entities/special_wands/twisted/twisted.xml", 200, -80)
	EntityLoad("mods/copis_things/files/entities/special_wands/tome_edgy/tome_edgy.xml", 220, -80)
	EntityLoad("mods/copis_things/files/entities/special_wands/luminous_saber/luminous_saber.xml", 240, -80)
end



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