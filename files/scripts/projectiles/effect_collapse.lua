-- Get entity IDs
local entity_id	= GetUpdatedEntityID()
local victim_id	= EntityGetRootEntity(entity_id)
local children	= EntityGetAllChildren(victim_id) or {}
local stacks	= 0
for i=1, #children do
	if EntityGetName(children[i]) == "collapse" then
		stacks = stacks + 1
		EntityKill(children[i])
	end
end

local x, y = EntityGetTransform(victim_id)
GameCreateCosmeticParticle("spark_red", x, y, 64, 100, 100, 0, 1, 1, true, true, true, true)
EntityLoad("mods/copis_things/files/entities/particles/collapse.xml", x, y)
GamePlaySound("data/audio/Desktop/explosion.bank", "explosions/holy", x, y)
EntityInflictDamage(victim_id, (stacks/25)*15, "DAMAGE_POISON", "$death_collapse", "DISINTEGRATED", 0, 0)