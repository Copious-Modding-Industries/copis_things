local entity_id = GetUpdatedEntityID()
local vscs = EntityGetComponent(entity_id, "VariableStorageComponent") or {}
for i=1,#vscs do
    local comp = vscs[i]
    local name = ComponentGetValue2(comp, "name")
    if name == "riphook_victim" then
        local victim = ComponentGetValue2(comp, "value_int")
        if EntityGetIsAlive(victim) then
            local children = EntityGetAllChildren(victim) or {}
            for j = 1, #children do
                if EntityGetName(children[j]) == "riphooked" then
                    EntityKill(children[j])
                end
            end
        end
        break
    end
end