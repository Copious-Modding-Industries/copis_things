
ModLuaFileAppend("data/scripts/gun/gun_actions.lua", "mods/copis_things/files/actions.lua")
--ModLuaFileAppend("data/scripts/gun/gun.lua", "mods/copis_things/files/gun_append.lua")			-- experimental, may remove
ModLuaFileAppend("data/scripts/perks/perk_list.lua", "mods/copis_things/files/scripts/perk/perk_list.lua")

-- Thanks Evasia! Wouldn't have managed to do this without your help.
ModLuaFileAppend("data/scripts/gun/gun_extra_modifiers.lua", "mods/copis_things/files/scripts/gun/gun_extra_modifiers.lua")
ModLuaFileAppend("data/scripts/status_effects/status_list.lua", "mods/copis_things/files/scripts/status/status_list.lua")

--ModMaterialsFileAdd( "mods/copis_things/files/materials.xml" )

function OnPlayerSpawned( player_entity ) --This runs when player entity has been created

	EntitySetDamageFromMaterial(player_entity, "copis_things_creepy_acid", 0.1)

	GameAddFlagRun("copis_items_spawned") --clean up spawn for now

	if GameHasFlagRun("copis_items_spawned") == false then
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
		EntityLoad("mods/copis_things/files/entities/special_wands/rapier/rapier.xml", 200, -100)
		EntityLoad("mods/copis_things/files/entities/special_wands/chainsaw/chainsaw.xml", 220, -100)
		EntityLoad("mods/copis_things/files/entities/special_wands/datarandal/datarandal.xml", 240, -100)

		EntityLoad("mods/copis_things/files/entities/special_wands/twisted/twisted.xml", 20, -120)
		EntityLoad("mods/copis_things/files/entities/special_wands/tome_edgy/tome_edgy.xml", 40, -120)
		EntityLoad("mods/copis_things/files/entities/special_wands/tome_decay/tome_decay.xml", 60, -120)
		EntityLoad("mods/copis_things/files/entities/special_wands/tome_blank/tome_blank.xml", 80, -120)

		EntityLoad("mods/copis_things/files/entities/special_wands/luminous_saber/luminous_saber.xml", 20, -140)
		EntityLoad("mods/copis_things/files/entities/special_wands/dark_sunsaber/dark_sunsaber.xml", 40, -140)
		EntityLoad("mods/copis_things/files/entities/special_wands/mass_manipulator/mass_manipulator.xml", 60, -140)
		EntityLoad("mods/copis_things/files/entities/special_wands/jsr_beater/jsr_beater.xml", 80, -140)

		EntityLoad("mods/copis_things/files/entities/special_wands/essence/Charybdis/Charybdis.xml", 20, -160)
		EntityLoad("mods/copis_things/files/entities/special_wands/essence/Igneous/Igneous.xml", 40, -160)
		EntityLoad("mods/copis_things/files/entities/special_wands/essence/Drunkard/Drunkard.xml", 60, -160)

		EntityLoad("mods/copis_things/files/entities/special_wands/elite_bow/elite_bow.xml", 20, -180)
		EntityLoad("mods/copis_things/files/entities/special_wands/pheonix_bow/pheonix_bow.xml", 40, -180)

		GameAddFlagRun("copis_items_spawned")
	end
end

GamePrint("Copi's things INDEV 0.01")