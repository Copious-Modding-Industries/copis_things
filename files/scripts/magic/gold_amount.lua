dofile_once("data/scripts/lib/utilities.lua")
local entity_id = GetUpdatedEntityID()
local money

local wallet = EntityGetFirstComponent(EntityGetWithTag( "player_unit" )[1], "WalletComponent")
if (wallet ~= nil) then
    money = ComponentGetValueInt(wallet, "money")
end

edit_component( entity_id, "SpriteComponent", function(comp,vars)
	vars.text = "$"..money
	EntityRefreshSprite( entity_id, comp )
end)
