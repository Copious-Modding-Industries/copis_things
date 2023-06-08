local entity_id = GetUpdatedEntityID()
local velcomp = EntityGetFirstComponentIncludingDisabled(entity_id, "VelocityComponent") --[[@cast velcomp number]]
local vx, vy = ComponentGetValue2(velcomp, "mVelocity")
ComponentSetValue2(velcomp, "mVelocity", vx, vy-3)

-- TODO: make this a one-off change to the gravity of the card then revert it in pickup script
-- Jitter is annoying