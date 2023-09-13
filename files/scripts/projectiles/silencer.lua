local entitiy_id = GetUpdatedEntityID()
local acs = EntityGetComponentIncludingDisabled(entitiy_id, "AudioComponent") or {}
for i=1, #acs do
	ComponentSetValue2(acs[i], "remove_latest_event_on_destroyed", true)
	ComponentSetValue2(acs[i], "send_message_on_event_dead", true)
	ComponentSetValue2(acs[i], "event_root", "")
	ComponentSetValue2(acs[i], "file", "")
	EntityRemoveComponent(entitiy_id, acs[i])
end
local alcs = EntityGetComponentIncludingDisabled(entitiy_id, "AudioLoopComponent") or {}
for i=1, #alcs do
	ComponentSetValue2(alcs[i], "m_volume", 0)
	EntityRemoveComponent(entitiy_id, alcs[i])
end