local entity_id = GetUpdatedEntityID()
local projcomp = EntityGetFirstComponent(entity_id, "ProjectileComponent")
if projcomp then
    local handler = ComponentGetValue2(projcomp, "mEntityThatShot")
    print(EntityGetName(handler))
end