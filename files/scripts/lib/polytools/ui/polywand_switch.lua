dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/gun/procedural/gun_action_utils.lua")
dofile_once("[POLYTOOLS_PATH]disco_util/disco_util.lua")

local wand = Entity.Current()
local owner = wand:root()

local ctrl = owner.ControlsComponent
if ctrl then
    local now = GameGetFrameNum()
    local alt_fire = ctrl.mButtonDownThrow and ctrl.mButtonFrameThrow == now
    if alt_fire then
        print("alt fire!")
        -- Move the first spell in the wand to the back

        local spells = wand:children()
        local new_order = {}
        for k, v in spells:ipairs() do
            v:setParent(nil)
            local slot = v.ItemComponent.inventory_slot
            if k == 1 then
                slot.x = spells:len() - 1
            else
                slot.x = k - 2
            end
            v.ItemComponent.inventory_slot = slot
            new_order[slot.x + 1] = v
        end
        for k, v in pairs(new_order) do v:setParent(wand) end
        wand.ItemComponent.ui_sprite = new_order[1].ItemComponent.ui_sprite
    end
end
