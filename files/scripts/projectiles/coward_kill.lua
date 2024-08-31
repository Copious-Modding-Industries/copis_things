local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetFirstHitboxCenter( entity_id ) --[[@cast pos_x number]] --[[@cast pos_y number]]

-- get shooter
local comp = EntityGetFirstComponent( entity_id, "ProjectileComponent" ) --[[@cast comp number]]
local who_shot = ComponentGetValue2( comp, "mWhoShot")
local mortals = EntityGetInRadiusWithTag(pos_x, pos_y, 16, "mortal")

for i=1, #mortals do
	local mortal = mortals[i]
	if EntityGetComponent(mortal, "GenomeDataComponent") ~= nil and EntityGetHerdRelation(who_shot, mortal) < 70 and mortal ~= who_shot then
		EntityKill(entity_id)
	end
end