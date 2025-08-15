local function buff()
	GamePrint("HEY!")
end

---@diagnostic disable-next-line: lowercase-global
function damage_received(damage, message, entity_thats_responsible, is_fatal)
	GamePrint"!!!!"
	if message~="$damage_electricity" then return end
	local entity_id = GetUpdatedEntityID()
	local dmc = EntityGetFirstComponent(entity_id, "DamageModelComponent")
	if dmc then
		buff()
		SetValueNumber("charge", GetValueNumber("charge", 0)+damage/2)
	end
end
GamePrint(tostring(GetValueNumber("charge", 0)))

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
local tgts = EntityGetInRadius(x, y, 32) or {}
for i=1, tgts do
	if EntityGetFirstComponent(tgts[i], "ElectricityComponent") then
		buff()
		break
	end
end