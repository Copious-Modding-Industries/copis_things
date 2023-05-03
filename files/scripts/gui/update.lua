-- Gui Setup
Gui = Gui or GuiCreate()
GuiStartFrame( Gui )
GuiIdPushString( Gui, "Copis_Things_Gui" )
-- ID Stuff
local id = 0
local function new_id()
    id = id + 1
    return id
end
local curr_res = dofile("mods/copis_things/files/scripts/gui/compat_crap.lua")
local opened = dofile("mods/copis_things/files/scripts/gui/button.lua")(Gui, new_id)
GlobalsSetValue( "mod_button_tr_current", tostring( curr_res + 15 ) );
if opened then
    MenuOpen = not (MenuOpen or false)
end
if MenuOpen then
   -- sorry this isnt done motivation issue lole 
end

-- Gui End
GuiIdPop( Gui )