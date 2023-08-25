local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
local projs = EntityGetInRadiusWithTag(x, y, 512, "player_projectile")
if not projs then return end
for i=1, #projs do
	local proj = projs[i]
	if proj ~= entity_id or EntityGetName(proj) ~= "reel_line" then goto continue end
	local vscs = EntityGetComponent(proj, "VariableStorageComponent")
	for k=1, #vscs do
		local name = ComponentGetValue2(proj, "name")
		if name == "can_connect" then
			
		end
		
	end
	::continue::
end