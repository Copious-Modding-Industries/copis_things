local entity_id = GetUpdatedEntityID()
local projcomp = EntityGetFirstComponent(entity_id, "ProjectileComponent") --[[@cast projcomp number]]
local extra_entities = ComponentObjectGetValue2(projcomp, "config", "extra_entities")   --[[@cast extra_entities string]]
ComponentObjectSetValue2(projcomp, "config", "extra_entities", extra_entities:gsub("mods/copis_things/files/entities/misc/larpa_but_good.xml,", "", 1))


local proj = ComponentGetMembers(projcomp) --[[@cast proj table]]

print(string.rep("\n", 3))
print(string.rep("-", 121))
for key, value in pairs(proj) do
    print(string.format("%-60s | %60s", tostring(key), GameTextGetTranslatedOrNot(tostring(value))))
end


--[=[
local velcomp = EntityGetFirstComponent(entity_id, "VelocityComponent") --[[@cast velcomp number]]
local vel = ComponentGetMembers(velcomp) --[[@cast vel table]]
print(string.rep("\n", 3))
print(string.rep("-", 101))
for key, value in pairs(vel) do
    print(string.format("%-50s | %50s", tostring(key), GameTextGetTranslatedOrNot(tostring(value))))
end]=]