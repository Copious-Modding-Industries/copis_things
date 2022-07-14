dofile_once("data/scripts/lib/utilities.lua")
local entity_id = GetUpdatedEntityID()
local hp
local max_hp

local damagemodels = EntityGetComponent( EntityGetWithTag( "player_unit" )[1], "DamageModelComponent" )
if( damagemodels ~= nil ) then
    for i,damagemodel in ipairs(damagemodels) do
        hp = ComponentGetValue2( damagemodel, "hp" )
        max_hp = ComponentGetValue2( damagemodel, "max_hp" )
    end
end

edit_component( entity_id, "SpriteComponent", function(comp,vars)
	vars.text = math.floor(hp*25)
	EntityRefreshSprite( entity_id, comp )
end)
