--[[
Hello seeker of knowledge.

Keep your eyes open, for there is much to come.
]]

COPIS_THINGS_VERSION = "vD.5"

-- NOTICE! This is CRAP! I will be REWRITING THIS LIBRARY!
dofile_once("mods/copis_things/files/scripts/lib/polytools/polytools_init.lua").init( "mods/copis_things/files/scripts/lib/polytools/")

---@module "setupCompatibility"
local compatibility = dofile_once("mods/copis_things/files/setupCompatibility.lua")

---@module "gui"
local Gui = dofile_once("mods/copis_things/files/scripts/gui/gui.lua")

---@module "init_content"
local Content = dofile_once("mods/copis_things/init/init_content.lua")
local content = Content.content
local experimental = Content.experimental

function OnModInit()
    content.flag_reset()
    content.actions()
    content.perks()
    content.translations()
    content.greeks()
    content.statuses()
    content.materials()
    compatibility.setup()
end

function OnWorldInitialized()
    Gui:Setup()
    GlobalsSetValue("copis_things_version", COPIS_THINGS_VERSION)
    experimental.loadspell()
    experimental.spell_visualizer()
    GamePrint(("Copi's things INDEV %s"):format(COPIS_THINGS_VERSION))
end

function OnWorldPreUpdate()
    Gui:Update()
end

function OnPlayerSpawned()
    Gui:PlayerSpawned()
end

function OnWorldPostUpdate()
    Gui:Tr()
end

-- I see you peeking in here.. sneaky sneaky :^) 
-- I can't offer you much at the moment, but for being so persistent in your search I do offer my greetings o/
-- As you might've noticed, seeing as you're so observant, there's a lot more comments around this time.
-- To be honest, I've just not been doing the best on motivation and mental health in the past month(s) so modding has been hard
-- Keep this between us, but I personally worry that I might've bitten off more than I can chew with this mod
-- I have no clue what to do about it as is, it's too late to cut down scope but even without adding more scope
-- I just can't keep up with all the crap that needs to get done
-- Hopefully you didn't mind the mini-ramble, enjoy .5!!!
-- - Mr. Copio Thing, 2022