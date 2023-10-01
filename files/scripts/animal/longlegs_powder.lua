local entity_id = GetUpdatedEntityID()
local x, y      = EntityGetTransform(entity_id)

-- dc 5 hamis check
if math.random(1, 20) == 5 then
	EntityLoad("data/entities/animals/longleg.xml", x, y)
end

EntityKill(entity_id)