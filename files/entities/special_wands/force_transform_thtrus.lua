
--[[
player = EntityGetRootEntity(wand)
player_x, player_y = EntityGetTransform(player)
comp = EntityGetFirstComponent(player, "HotspotComponent", "hand")
local hand_x, hand_y = ComponentGetValue2(comp, "offset")
EntitySetTransform(wand, player_x+hand_x, player_y+hand_y)
]]--