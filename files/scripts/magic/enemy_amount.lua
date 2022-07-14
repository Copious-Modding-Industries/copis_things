dofile_once("data/scripts/lib/utilities.lua")
local entity_id = GetUpdatedEntityID()
local money

local x, y = EntityGetTransform(EntityGetWithTag( "player_unit" )[1])

local enemies = EntityGetInRadiusWithTag( x, y, 200, "enemy")

edit_component( entity_id, "SpriteComponent", function(comp,vars)
	vars.text = #enemies
	EntityRefreshSprite( entity_id, comp )
end)
