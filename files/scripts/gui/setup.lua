-- Gui Setup
Gui = Gui or GuiCreate()
GuiStartFrame( Gui )
GuiIdPushString( Gui, "Copis_Things_Gui" )
-- ID Stuff
id = 0
local function new_id()
    id = id + 1
    return id
end

return id, new_id