local entity_id = GetUpdatedEntityID()
local projcomp = EntityGetFirstComponent(entity_id, "ProjectileComponent") --[[@cast projcomp number]]
local types = {
	{ id = "curse",			mult = 1.0},	-- idk its true damage why not
	{ id = "drill",			mult = 0.0},	-- no
	{ id = "electricity",	mult = 0.0},	-- no
	{ id = "explosion",		mult = 0.0},	-- no
	{ id = "fire",			mult = 0.0},	-- no
	{ id = "healing",		mult = 0.5},	-- no
	{ id = "ice",			mult = 0.0},	-- no
	{ id = "melee",			mult = 0.0},	-- no
	{ id = "overeating",	mult = 0.0},	-- lmao how the fuck is a mind laser gonna stuff you till you die
	{ id = "physics_hit",	mult = 0.0},	-- its not really physical
	{ id = "poison",		mult = 1.5},	-- how do you even get poison damage I'm gonna give 1.5x just because its funny
	{ id = "projectile",	mult = 0.0},	-- no
	{ id = "radioactive",	mult = 0.5},	-- idk funny
	{ id = "slice",			mult = 0.0},	-- no
	{ id = "holy",			mult = 0.0},	-- no
}

for i=1, #types do
    local old = ComponentObjectGetValue2(projcomp, "damage_by_type", types[i].id)
    ComponentObjectSetValue2(projcomp, "damage_by_type", types[i].id, old * types[i].mult)
end
ComponentSetValue2(projcomp, "damage", 0)