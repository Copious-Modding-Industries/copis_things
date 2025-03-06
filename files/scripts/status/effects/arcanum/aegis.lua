---@diagnostic disable-next-line: lowercase-global
function damage_about_to_be_received( damage, x, y, entity_thats_responsible, critical_hit_chance )
	if damage <= 0 then return damage, critical_hit_chance end
	local entity_id = GetUpdatedEntityID()
	local dmc = EntityGetFirstComponent(EntityGetRootEntity(entity_id), "DamageModelComponent")
	if dmc then ComponentSetValue2( dmc, "invincibility_frames", ComponentGetValue2( dmc, "invincibility_frames")+90) end
	GamePlaySound("data/audio/deskop/animals.bank", "animals/iceskull/death", x, y)
	EntityKill(entity_id) return 0, 0
end

--[[
	<SpriteComponent image_file="mods/copis_things/files/particles/aegis.png"
		offset_y="5" has_special_scale="1" special_scale_x="1" special_scale_y="1" alpha="0.35" sprite_centered="1"
	/>
]]

local entity_id = GetUpdatedEntityID()
if ComponentGetValue2(GetUpdatedComponentID(), "mTimesExecuted") == 1 then
	local root = EntityGetRootEntity(entity_id)
	local hbc = EntityGetFirstComponent(root, "HitboxComponent")
	if not hbc then SetValueNumber("width", 8) return end
	local diameter = ComponentGetValue2(hbc, "aabb_max_x")-ComponentGetValue2(hbc, "aabb_min_x")+2
	SetValueNumber("width", diameter)
	for i=1, math.floor((math.pi*diameter)/8) do
		EntityAddComponent2(entity_id, "SpriteComponent", {
			image_file="mods/copis_things/files/particles/aegis.png",
			has_special_scale=true,
			special_scale_x=1,
			special_scale_y=1,
			alpha=0.35,
		})
	end
else
	local spcs = EntityGetComponent(entity_id, "SpriteComponent") or {}
	for i=1, #spcs do
		local x = ((GameGetFrameNum()+entity_id)/35)+(i*2*math.pi/#spcs)
		ComponentSetValue2(spcs[i],	"offset_x",			GetValueNumber("width", 8)*math.cos(x)/math.sin(x))
		ComponentSetValue2(spcs[i],	"special_scale_x",	math.sin(x))
		ComponentSetValue2(spcs[i],	"offset_y",			6+math.sin(x))
		ComponentSetValue2(spcs[i],	"z_index",			(math.sin(x)>=0 and 10 or -10))
		EntityRefreshSprite(entity_id, spcs[i])
	end
end