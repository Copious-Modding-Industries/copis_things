---@class Gui
local Gui = {
	obj = nil
}


function Gui:Setup()
	local mods_res = tonumber(GlobalsGetValue("mod_button_tr_width", "0"))
	GlobalsSetValue("copis_things_mod_button_reservation", tostring(mods_res))
	GlobalsSetValue("mod_button_tr_width", tostring(mods_res + 15))
end

function Gui:Update()
	self.obj = self.obj or GuiCreate()
	GuiStartFrame( self.obj )
	GuiIdPushString( self.obj, "Copis_Things_Gui" )
	-- ID Stuff
	local id = 0
	local function new_id()
		id = id + 1
		return id
	end
	local curr_res = dofile("mods/copis_things/files/scripts/gui/compat_crap.lua")
	local opened = dofile("mods/copis_things/files/scripts/gui/button.lua")(self.obj, new_id)
	GlobalsSetValue( "mod_button_tr_current", tostring( curr_res + 15 ) );
	if opened then
		MenuOpen = not (MenuOpen or false)
	end
	if MenuOpen then
	-- sorry this isnt done motivation issue lolololol
	end

	-- Gui End
	GuiIdPop( self.obj )
end

function Gui:Tr()
	if GlobalsGetValue( "config_mod_button_tr_max", "0" ) == "0" then
		local current = GlobalsGetValue( "mod_button_tr_current", "0" )
		GlobalsSetValue( "config_mod_button_tr_max", current or "0" );
	end
	GlobalsSetValue( "mod_button_tr_current", "0" );
end

function Gui:PlayerSpawned()
	GlobalsSetValue( "mod_button_tr_width", "0" );
end

return Gui