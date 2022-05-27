dofile("data/scripts/lib/utilities.lua")
local EZWand = dofile_once("mods/copis_things/lib/EZWand/EZWand.lua")
local wand = EZWand.GetHeldWand()
local free_slots_count = wand:GetFreeSlotsCount()
local entity_id = GetUpdatedEntityID()
local root_id = EntityGetRootEntity( entity_id )
local comp = EntityGetFirstComponent( entity_id, "ProjectileComponent")
local x, y = EntityGetTransform( entity_id )
local who_shot
if ( comp ~= nil ) then
	who_shot = ComponentGetValue2( comp, "mWhoShot" )
end
if ( who_shot ~= nil ) and ( comp ~= nil ) then

	local damage = ComponentGetValue2( comp, "damage" )
	local expdamage = ComponentObjectGetValue( comp, "config_explosion", "damage" )
	local exprad = ComponentObjectGetValue( comp, "config_explosion", "explosion_radius" )

	damage = damage + math.min( 120, free_slots_count * 0.25 )
	expdamage = expdamage + math.min( 120, free_slots_count * 0.25 )
	exprad = math.max( exprad,  math.min( 120, math.floor( exprad + math.log( free_slots_count * 5.5 ) ) ) )

	ComponentSetValue2( comp, "damage", damage )
	ComponentObjectSetValue( comp, "config_explosion", "damage", expdamage )
	ComponentObjectSetValue( comp, "config_explosion", "explosion_radius", exprad )

	local effect_id = EntityLoad("data/entities/particles/tinyspark_red_large.xml", x, y)
	EntityAddChild( root_id, effect_id )

	edit_component( effect_id, "ParticleEmitterComponent", function(comp3,vars)
		local part_min = math.min( math.floor( free_slots_count * 0.5 ), 100 )
		local part_max = math.min( free_slots_count + 1, 120 )
		ComponentSetValue2( comp3, "count_min", part_min )
		ComponentSetValue2( comp3, "count_max", part_max )
	end)
end