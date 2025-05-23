-- Stat conversion
--[[
config:lifetime_add		-> hp
config:fire_rate_wait	-> trigger proc rate
config:reload_time		-> trigger proc rate
config:spread_degrees	-> shot spread
config:pattern_degrees	-> multi-shot proc offset

BIND -> mana is drained before HP

Kill copies if summon count > max summon/spell
current_action.inventoryitem_id -> ID for spell


Summon ideas:
- Magma Golem
- Ice Golem
- Earth Golem
- Thunder Golem
- Loot Golem (rare)

]]






local function extract(projc, keys)
	local desc = ComponentObjectGetValue2(projc, "config", "action_description")
	-- Set up vars, iter through desc and store indicies
	local data_lim, indxs = math.max(unpack(keys)), {[0]=0}
	for i=1, data_lim do indxs[i] = desc:find("\n", (indxs[i-1]or 0)+1) end
	indxs[data_lim]=desc:len()

	-- Extract data at requested indicies
	local data = {}
	for i=1, #keys do data[i]=desc:sub((indxs[i-1]or 0)+1,indxs[i])--[[ print(tostring(i), tostring(indxs[i]))]]end
	return unpack(data)
end

return extract
-- EXAMPLE USAGE: local cast_id, thing = extract(projc, {1, 2})


--[[
	-- Extract data at requested indicies
	for i=1, #keys do if not Cache[i] then Cache[i]=desc:sub(indxs[i-1]+1,indxs[i]-1) end end
	return unpack(Cache)
]]