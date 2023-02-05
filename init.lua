--[[
Hello seeker of knowledge.

I will speak many words to you through the past present and future.
But for now, rid yourself of this domain, as it is unstable and incomplete.
To base your future on the chaotic state of this project would only worsen them.
Now flee, escape until this primordial slate of commands is in it's final state.
]]

local meta = {

    version = function ()
        GlobalsSetValue("copis_things_version", "v0.2 INDEV")
    end,

}

--[[ STUFF
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
        -- Add spells
        ModLuaFileAppend("data/scripts/gun/gun_actions.lua", "mods/copis_things/files/scripts/gun/gun_actions.lua")
        -- Rework spells
        ModLuaFileAppend("data/scripts/gun/gun_actions.lua", "mods/copis_things/files/scripts/gun/gun_actions_rework.lua")
    end,

    perks = function ()
        -- Add perks
        ModLuaFileAppend("data/scripts/perks/perk_list.lua", "mods/copis_things/files/scripts/perk/perk_list.lua")
    end,

    translations = function ()
        local translations = ModTextFileGetContent( "data/translations/common.csv" );
        if translations ~= nil then
            while translations:find("\r\n\r\n") do
                translations = translations:gsub("\r\n\r\n","\r\n");
            end
            local files = {"perks", "actions"}
            for _, file in ipairs(files) do
                local new_translations = ModTextFileGetContent( table.concat({"mods/copis_things/files/translations/", file, ".csv"}) );
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
    end,

}

--[[ GUI
  ██████████    ██          ██  ██████  
██          ██  ██          ██    ██    
██              ██          ██    ██    
██    ████████  ██          ██    ██    
██          ██  ██          ██    ██    
██          ██  ██          ██    ██    
  ██████████      ██████████    ██████  
]]

local gui = {

    setup = function ()
        local mods_res = tonumber(GlobalsGetValue("mod_button_tr_width", "0"))
        GlobalsSetValue("copis_things_mod_button_reservation", tostring(mods_res))
        GlobalsSetValue("mod_button_tr_width", tostring(mods_res + 15))
    end,

    update = function ()
        dofile("mods/copis_things/files/scripts/gui/update.lua")
    end,

}

--[[ CALLBACKS
  ██████████          ██        ██              ██              ████████████          ██          ██████████    ██        ██    ██████████    
██          ██      ██  ██      ██              ██              ██          ██      ██  ██      ██          ██  ██      ██    ██          ██  
██                ██      ██    ██              ██              ██          ██    ██      ██    ██              ██    ██      ██              
██              ██          ██  ██              ██              ████████████    ██          ██  ██              ██████          ██████████    
██              ██████████████  ██              ██              ██          ██  ██████████████  ██              ██    ██                  ██  
██          ██  ██          ██  ██              ██              ██          ██  ██          ██  ██          ██  ██      ██    ██          ██  
  ██████████    ██          ██  ██████████████  ██████████████  ████████████    ██          ██    ██████████    ██        ██    ██████████    
]]

function OnModInit()
    content.actions()
    content.perks()
    content.translations()
    content.greeks()
    content.statuses()
    content.materials()
end

function OnWorldInitialized()
    meta.version()
    gui.setup()
end

function OnWorldPreUpdate()
    gui.update()
end

GamePrint("Copi's things INDEV 0.01")