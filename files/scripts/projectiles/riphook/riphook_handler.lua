local entity_id = GetUpdatedEntityID()
local vscs = EntityGetComponent(entity_id, "VariableStorageComponent") or {}
for i=1,#vscs do
    local comp = vscs[i]
    local name = ComponentGetValue2(comp, "name")
    if name == "riphook_victim" then
        local victim = ComponentGetValue2(comp, "value_int")
        if EntityGetIsAlive(victim) then
            -- vel hax
            local cdc = EntityGetFirstComponent(victim, "CharacterDataComponent") --[[@cast cdc number]]
            if cdc then
                local velocity  = EntityGetFirstComponent(entity_id, "VelocityComponent") --[[@cast velocity number]]
                local vel_x, vel_y = ComponentGetValue2( velocity, "mVelocity")
                ComponentSetValue2(cdc, "mVelocity", vel_x, vel_y)
            end

            -- Move victim to hook
            local hook_x, hook_y = EntityGetTransform(entity_id)
            EntitySetTransform(victim, hook_x, hook_y)
        else
            -- Dislodge
            EntityRemoveComponent(entity_id, GetUpdatedComponentID())
        end
        break
    end
end