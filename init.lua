--[[
Hello seeker of knowledge.

Keep your eyes open, for there is much to come.
]]

COPIS_THINGS_VERSION = "0.5.4"

-- NOTICE! This is CRAP! I will be REWRITING THIS LIBRARY!
dofile_once("mods/copis_things/files/scripts/lib/polytools/polytools_init.lua").init("mods/copis_things/files/scripts/lib/polytools/")

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

	actions = function()
		dofile("mods/copis_things/init/handhelds.lua")

		-- Gun Extra Modifiers (status)
		ModLuaFileAppend("data/scripts/gun/gun_extra_modifiers.lua", "mods/copis_things/files/scripts/gun/gun_extra_modifiers.lua")
		-- Edit gun.lua
		ModLuaFileAppend("data/scripts/gun/gun.lua", "mods/copis_things/files/scripts/gun/gun_append.lua")
		-- Force eso spell to end of list
		ModLuaFileAppend("data/scripts/gun/gun.lua", "mods/copis_things/files/scripts/gun/gun_secret_append.lua")
		-- Rework spells
		ModLuaFileAppend("data/scripts/gun/gun_actions.lua", "mods/copis_things/files/scripts/gun/gun_actions_rework.lua")
		-- Add spells
		ModLuaFileAppend("data/scripts/gun/gun_actions.lua", "mods/copis_things/files/scripts/gun/gun_actions.lua")
	end,

	perks = function()
		-- Add perks
		ModLuaFileAppend("data/scripts/perks/perk_list.lua", "mods/copis_things/files/scripts/perk/perk_list.lua")
		-- Edit perk.lua
		ModLuaFileAppend("data/scripts/perks/perk.lua", "mods/copis_things/files/scripts/perk/perk_append.lua")
	end,

	translations = function()
		local translations = ModTextFileGetContent("data/translations/common.csv")
		if translations == nil then return end

		local files = { "perks", "actions", "effects", "other" }
		for i = 1, #files do
			local new_translations = ModTextFileGetContent(table.concat({ "mods/copis_things/files/translations/", files[i], ".csv" }))
			translations = table.concat{translations, "\n", new_translations, "\n"}
		end

		translations = translations:gsub("\r", ""):gsub("\n\n+", "\n")
		ModTextFileSetContent("data/translations/common.csv", translations)
	end,

	greeks = function()
		local path = "data/entities/animals/boss_alchemist/death.lua"
		local contents = ModTextFileGetContent(path)
		local greeks = {
			psi = ModSettingGet("copis_things_action_enabled_COPITH_PSI") or true,
			delta = ModSettingGet("copis_things_action_enabled_COPITH_DELTA") or true,
		}
		-- inject greeks
		contents = contents:gsub(
			[[local opts = { ]],
			table.concat({
				[[local opts = { ]],
				greeks.psi and [["COPITH_PSI", ]] or "",
				greeks.delta and [["COPITH_DELTA", ]] or "",
			})
		)
		ModTextFileSetContent(path, contents)
	end,

	statuses = function()
		-- Add statuses
		ModLuaFileAppend("data/scripts/status_effects/status_list.lua", "mods/copis_things/files/scripts/status/status_list.lua")
	end,

	materials = function()
		ModMaterialsFileAdd("mods/copis_things/files/materials_nugget.xml")
		ModMaterialsFileAdd("mods/copis_things/files/materials_rainbow.xml")
		ModMaterialsFileAdd("mods/copis_things/files/materials_test.xml")
	end,

	--[[
	metaballs = function ()
		local cx, cy = GameGetCameraPos()
		local cbx, cby, cw, ch = GameGetCameraBounds()
		local projs = EntityGetInRadiusWithTag(cx, cy, cw*0.58, "player_projectile") --0.58 is an arcane number
		if #projs>0 then
			local data = {}
			for i=1, #projs do
				data[i] = {}
				data[i].x, data[i].y = EntityGetTransform(projs[i])
			end
			for x=1, cw do
				for y=1, ch do
					local px, py = cbx+x, cby+y
					local sum = 0
					for i=1, #data do
						local pos = data[i]
						sum = sum + 1/((px-pos.x)^2+(py-pos.y)^2)
					end
					if sum > 0.03 then
						-- Drops the particles 
						--GameCreateParticle("copith_metaball_acid", px, py, 1, 0, 0, false, false, false)

						-- Looks like shit
						--GameCreateCosmeticParticle(sum<0.05 and "spark_green" or "acid", px, py, 1, 0, 0, 0, 0.025, 0.025, true, true, false, false, 0, 0)

						-- LAGGY AS FUCK
						--GameCreateSpriteForXFrames("mods/metaball/png.png", px, py, true, 0, 0, 2, false)
					end
				end
			end
		end
	end]]

	patcher = function()
		dofile_once("mods/copis_things/init/enemypatcher/enemypatcher.lua")
	end,
}

local experimental = {

	loadspell = function()
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
				CreateItemActionEntity(result.id, pos.x, pos.y)
				--[[local wands = {
                    "experimental/delaywand/wand",
                    "experimental/chargewand/wand",
                    "experimental/blinkwand/wand",
                }
                local result = wands[Random(1, #wands)]
                EntityLoad(table.concat{"mods/copis_things/files/entities/items/wands/", result, ".xml"}, pos.x, pos.y)]]
				if Random(1, 100000) == 1 then
					-- Can't be bothered to move this to the tower n add mod compat
					EntityLoad("mods/copis_things/files/entities/items/wands/diewand/wand.xml", pos.x, pos.y)
				end
				GameAddFlagRun(flag)
			end
		end
	end,

	spell_visualizer = function()
		if ModSettingGet("CopisThings.do_spell_visualizer") then
			local flag = "copis_things_spell_visualizer"
			if not GameHasFlagRun(flag) then
				local pos = {
					x = tonumber(MagicNumbersGetValue("DESIGN_PLAYER_START_POS_X") - 100),
					y = tonumber(MagicNumbersGetValue("DESIGN_PLAYER_START_POS_Y") - 50),
				}

				function spawn_spell_visualizer(x, y)
					EntityLoad("data/entities/buildings/workshop_spell_visualizer.xml", x, y)
					EntityLoad("data/entities/buildings/workshop_aabb.xml", x, y)
				end

				spawn_spell_visualizer(pos.x, pos.y)

				GameAddFlagRun(flag)
			end
		end
	end,
}

local compatiblity = {
	frostbite = function()
		if ModIsEnabled("conga_temperature_mod") then dofile_once("mods/copis_things/init/compat_frostbite.lua") end
	end,

	grahamth = function()
		if ModIsEnabled("grahamsperks") then dofile_once("mods/copis_things/init/compat_grahamth.lua") end
	end,
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

function OnModPreInit()
	content.patcher()
end

function OnModInit()
	AddFlagPersistent("forced_flag")
	local flag = "this_should_never_spawn"
	if HasFlagPersistent(flag) then RemoveFlagPersistent(flag) end
	if HasFlagPersistent("copis_things_meta_spell") then
		AddFlagPersistent("copis_things_meta_spell_action")
	else
		RemoveFlagPersistent("copis_things_meta_spell_action")
	end
	content.actions()
	content.perks()
	content.translations()
	--content.greeks()
	content.statuses()
	content.materials()
	compatiblity.frostbite()
	compatiblity.grahamth()

	AddFlagPersistent("flag_you_must_have")
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
	--content:metaballs()
end

function OnPlayerSpawned()
	Gui:PlayerSpawned()
	-- Update main
end

function OnWorldPostUpdate()
	Gui:Tr()
end

--#endregion
-- what the FUCK is this file









-- Stolen from my own code in apoth
local pause_gui = GuiCreate()
local offset = ModIsEnabled("Apotheosis") and 48 or 38
--local months = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"}
--, months[m-1], " ", d, ", ", h, ":", m2, ":", s
local msg = "Make sure to take frequent breaks! Stretch, drink water, let your eyes and mind rest. An inattentive witch is a dead one!                   "
local msg_limit = 20
local msg_xlen = 0
-- prebake maximum length
for i=1, msg:len() do
	msg_xlen=math.max(GuiGetTextDimensions(pause_gui, ":3 <"..msg:rep(2):sub(i+1, i+1+msg_limit)), msg_xlen)
end

local scroll = 1
-- 
-- MENU SHIT!!!!!
-- THIS WILL SHOW IN THE PAUSE MENU!!
-- TODO mod compatible method for fitting multiple items 
function OnPausePreUpdate()
	local text_step = math.floor(scroll/8)%msg:len()
	-- y=\max\left(0,\ \operatorname{mod}\left(x,\ 10\right)-5\right)
	-- math.max(1, math.floor(scroll/8)%msg:len()-5)
	local y, m, d, h, m2, s = GameGetDateAndTimeLocal()
	GuiIdPushString(pause_gui, "copith_pause")
	GuiColorSetForNextWidget(pause_gui, 0.35, 0.35, 0.35, 0.5)
	GuiText(pause_gui, 12.5, ({GuiGetScreenDimensions(pause_gui)})[2]/2-offset, table.concat{"Copi's Things - v", COPIS_THINGS_VERSION, " - ", h, ":", m2, ":", s}, 1, "data/fonts/font_pixel.xml")
	GuiColorSetForNextWidget(pause_gui, 0.35, 0.35, 0.35, 0.5)
	GuiText(pause_gui, 160, ({GuiGetScreenDimensions(pause_gui)})[2]/2-offset, ":3 <".. msg:rep(2):sub(text_step+1, text_step+1+msg_limit), 1, "data/fonts/font_pixel.xml")
	GuiColorSetForNextWidget(pause_gui, 0.35, 0.35, 0.35, 0.5)
	GuiText(pause_gui, 160+msg_xlen, ({GuiGetScreenDimensions(pause_gui)})[2]/2-offset, ")", 1, "data/fonts/font_pixel.xml")
	GuiIdPop(pause_gui)
	scroll = scroll + (InputIsKeyDown(225) and 3 or 1)
end
--

-- todo scrollbox-type clipping and speed curve?

--[[
local msg = "Make sure to take frequent breaks! Stretch, drink water, let your eyes and mind rest. An inattentive witch is a dead one."..string.rep(" ", 25)

local pause_fr = 1
local msg_limit = 12

for i=1, 300 do 
	local text_step = i%msg:len()
    print(msg:rep(2):sub(text_step, text_step+msg_limit))
end]]