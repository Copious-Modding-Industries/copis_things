
local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )
local mortals = EntityGetInRadiusWithTag(x, y, 256, "mortal") or {}
for i=1, #mortals do
	if not EntityHasTag(mortals[i], "hittable") then goto skip end
	local children = EntityGetAllChildren(mortals[i]) or {}
	for j=1, #children do
		if EntityGetName(children[j]) == "arcanum_accelerant" then
			goto skip
		end
	end
	EntityAddChild(mortals[i], EntityLoad("mods/copis_things/files/entities/misc/status_entities/arcanum/accelerant.xml"))
	::skip::
end