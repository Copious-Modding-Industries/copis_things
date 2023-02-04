-- Gun Extra Modifiers (status)
ModLuaFileAppend("data/scripts/gun/gun_extra_modifiers.lua", "mods/copis_things/files/scripts/gun/gun_extra_modifiers.lua")
-- Sprite Swapper (actions)
ModLuaFileAppend("data/scripts/gun/gun_actions.lua", "mods/copis_things/files/scripts/gun/actions_sprite_replace.lua")
-- Edit gun.lua
ModLuaFileAppend("data/scripts/gun/gun.lua", "mods/copis_things/files/scripts/gun/gun_append.lua")
-- Add spells
ModLuaFileAppend("data/scripts/gun/gun_actions.lua", "mods/copis_things/files/actions.lua")

--[[ Dev content ]]
if DebugGetIsDevBuild() then
    -- Add dev spells
    ModLuaFileAppend("data/scripts/gun/gun_actions.lua", "mods/copis_things/files/actions_dev.lua")
end
