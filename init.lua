--[[
Hello seeker of knowledge.

Keep your eyes open, for there is much to come.
]]

COPIS_THINGS_VERSION = "0.5"

-- NOTICE! This is CRAP! I will be REWRITING THIS LIBRARY!
dofile_once("mods/copis_things/files/scripts/lib/polytools/polytools_init.lua").init( "mods/copis_things/files/scripts/lib/polytools/")

-- gus you fuck this file literally doesnt exist you broke my mod
---@module "setupCompatibility"
--local compatibility = dofile_once("mods/copis_things/files/setupCompatibility.lua")

---@module "gui"
local Gui = dofile_once("mods/copis_things/files/scripts/gui/gui.lua")

--#region stuff
--[[
  ██████████    ██████████████  ██          ██  ██████████████  ██████████████  
██          ██        ██        ██          ██  ██              ██              
██                    ██        ██          ██  ██              ██              
  ██████████          ██        ██          ██  ██████████      ██████████      
            ██        ██        ██          ██  ██              ██              
██          ██        ██        ██          ██  ██              ██              
  ██████████          ██          ██████████    ██              ██              
]]

local content = {

    actions = function ()
        -- Gun Extra Modifiers (status)
        ModLuaFileAppend("data/scripts/gun/gun_extra_modifiers.lua", "mods/copis_things/files/scripts/gun/gun_extra_modifiers.lua")
        -- Edit gun.lua
        ModLuaFileAppend("data/scripts/gun/gun.lua", "mods/copis_things/files/scripts/gun/gun_append.lua")
        -- Rework spells
        ModLuaFileAppend("data/scripts/gun/gun_actions.lua", "mods/copis_things/files/scripts/gun/gun_actions_rework.lua")
        -- Add spells
        ModLuaFileAppend("data/scripts/gun/gun_actions.lua", "mods/copis_things/files/scripts/gun/gun_actions.lua")
    end,

    perks = function ()
        -- Add perks
        ModLuaFileAppend("data/scripts/perks/perk_list.lua", "mods/copis_things/files/scripts/perk/perk_list.lua")
        -- Edit perk.lua
        ModLuaFileAppend("data/scripts/perks/perk.lua", "mods/copis_things/files/scripts/perk/perk_append.lua")
    end,

    translations = function ()
        local translations = ModTextFileGetContent( "data/translations/common.csv" );
        if translations ~= nil then
            while translations:find("\r\n\r\n") do
                translations = translations:gsub("\r\n\r\n","\r\n");
            end
            local files = {"perks", "actions", "effects", "other"}
            for i=1, #files do
                local new_translations = ModTextFileGetContent( table.concat({"mods/copis_things/files/translations/", files[i], ".csv"}) );
                translations = translations .. new_translations;
            end
            ModTextFileSetContent( "data/translations/common.csv", translations );
        end
    end,

    greeks = function ()
        local path = "data/entities/animals/boss_alchemist/death.lua"
        local contents = ModTextFileGetContent(path)
        local greeks = {
            psi = ModSettingGet("copis_things_action_enabled_COPIS_THINGS_PSI") or true,
            delta = ModSettingGet("copis_things_action_enabled_COPIS_THINGS_DELTA") or true
        }
        -- inject greeks
        contents = contents:gsub(
            [[local opts = { ]],
            table.concat{[[local opts = { ]] , greeks.psi and [["COPIS_THINGS_PSI", ]] or "", greeks.delta and [["COPIS_THINGS_DELTA", ]] or ""}
        )
        ModTextFileSetContent(path, contents)
    end,

    statuses = function ()
        -- Add statuses
        ModLuaFileAppend("data/scripts/status_effects/status_list.lua", "mods/copis_things/files/scripts/status/status_list.lua")
    end,

    materials = function ()
        ModMaterialsFileAdd("mods/copis_things/files/materials_nugget.xml")
        ModMaterialsFileAdd("mods/copis_things/files/materials_rainbow.xml")
        ModMaterialsFileAdd("mods/copis_things/files/materials_test.xml")
    end,

}

local experimental = {

    loadspell = function ()
        if ModSettingGet("CopisThings.do_starting_crap") then
            local flag = "copis_things_spell_spawned"
            if not GameHasFlagRun(flag) then
                local pos = {
                    x = tonumber(MagicNumbersGetValue("DESIGN_PLAYER_START_POS_X")),
                    y = tonumber(MagicNumbersGetValue("DESIGN_PLAYER_START_POS_Y")),
                }
                dofile("data/scripts/gun/gun.lua")
                SetRandomSeed(420, 69)
                local result = actions[Random(1, #actions)]
                CreateItemActionEntity( result.id, pos.x, pos.y )
                --[[local wands = {
                    "experimental/delaywand/wand",
                    "experimental/chargewand/wand",
                    "experimental/blinkwand/wand",
                }
                local result = wands[Random(1, #wands)]
                EntityLoad(table.concat{"mods/copis_things/files/entities/items/wands/", result, ".xml"}, pos.x, pos.y)]]
                GameAddFlagRun(flag)
            end
        end
    end,

    spell_visualizer = function ()
        if ModSettingGet("CopisThings.do_spell_visualizer") then
            local flag = "copis_things_spell_visualizer"
            if not GameHasFlagRun(flag) then
                local pos = {
                    x = tonumber(MagicNumbersGetValue("DESIGN_PLAYER_START_POS_X") - 100),
                    y = tonumber(MagicNumbersGetValue("DESIGN_PLAYER_START_POS_Y") - 50),
                }

                function spawn_spell_visualizer( x, y )
                    EntityLoad( "data/entities/buildings/workshop_spell_visualizer.xml", x, y )
                    EntityLoad( "data/entities/buildings/workshop_aabb.xml", x, y )
                end

                spawn_spell_visualizer( pos.x, pos.y )

                GameAddFlagRun(flag)
            end
        end
    end

}

--#endregion

--#region callbacks
--[[
  ██████████          ██        ██              ██              ████████████          ██          ██████████    ██        ██    ██████████    
██          ██      ██  ██      ██              ██              ██          ██      ██  ██      ██          ██  ██      ██    ██          ██  
██                ██      ██    ██              ██              ██          ██    ██      ██    ██              ██    ██      ██              
██              ██          ██  ██              ██              ████████████    ██          ██  ██              ██████          ██████████    
██              ██████████████  ██              ██              ██          ██  ██████████████  ██              ██    ██                  ██  
██          ██  ██          ██  ██              ██              ██          ██  ██          ██  ██          ██  ██      ██    ██          ██  
  ██████████    ██          ██  ██████████████  ██████████████  ████████████    ██          ██    ██████████    ██        ██    ██████████    
]]

function OnModInit()
    local flag = "this_should_never_spawn"
    if HasFlagPersistent(flag) then
        RemoveFlagPersistent(flag)
    end
    if HasFlagPersistent("copis_things_meta_spell") then
        AddFlagPersistent("copis_things_meta_spell_action")
    else
        RemoveFlagPersistent("copis_things_meta_spell_action")
    end
    content.actions()
    content.perks()
    content.translations()
    content.greeks()
    content.statuses()
    content.materials()
    --compatibility.setupModCompat()
end

function OnWorldInitialized()
    GlobalsSetValue("copis_things_version", COPIS_THINGS_VERSION)
    Gui:Setup()
    experimental.loadspell()
    experimental.spell_visualizer()
    GamePrint(("Copi's things INDEV %s"):format(COPIS_THINGS_VERSION))
end

function OnWorldPreUpdate()
    Gui:Update()
end

function OnModPreInit()
	AddFlagPersistent("sp_nolla")
end

function OnPlayerSpawned()
    Gui:PlayerSpawned()
	print("If you're arvi, hi!!!")
end

function OnWorldPostUpdate()
    Gui:Tr()
end

--#endregion
-- what the FUCK is this file