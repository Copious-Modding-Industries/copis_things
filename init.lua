-- all functions below are optional and can be left out
ModLuaFileAppend("data/scripts/gun/gun_actions.lua", "mods/copis_things/files/actions.lua")

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
	EntityLoad("mods/copis_things/files/entities/special_wands/hammer/hammer.xml", 20, -40)
	EntityLoad("mods/copis_things/files/entities/special_wands/earthworm/earthworm.xml", 40, -40)
	EntityLoad("mods/copis_things/files/entities/special_wands/tachamis/tachamis.xml", 60, -40)
	EntityLoad("mods/copis_things/files/entities/special_wands/frostburn/frostburn.xml", 80, -40)
	EntityLoad("mods/copis_things/files/entities/special_wands/hellfire/hellfire.xml", 100, -40)
	EntityLoad("mods/copis_things/files/entities/special_wands/energy_blaster/energy_blaster.xml", 120, -40)
	EntityLoad("mods/copis_things/files/entities/special_wands/viper/viper.xml", 140, -40)
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