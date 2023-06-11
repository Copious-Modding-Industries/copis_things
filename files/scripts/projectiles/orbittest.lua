local entity_id = GetUpdatedEntityID()
local velcomp = EntityGetFirstComponent(entity_id, "VelocityComponent") --[[@cast velcomp number]]
local vx, vy = ComponentGetValue2(velcomp, "mVelocity")
ComponentSetValue2(velcomp, "mVelocity", -vy, vx)