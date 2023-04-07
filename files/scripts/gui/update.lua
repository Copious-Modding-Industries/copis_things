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

local opened = dofile("mods/copis_things/files/scripts/gui/button.lua")(Gui, new_id)
if opened then
    MenuOpen = not (MenuOpen or false)
end
if MenuOpen then
    
end

-- Gui End
GuiIdPop( Gui )