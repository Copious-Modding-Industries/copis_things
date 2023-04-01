local shieldrevs = tonumber(GlobalsGetValue("PLAYER_REVS_SHIELD")) or 0
local revs = tonumber(GlobalsGetValue("PLAYER_REVS")) or 0
local card = GetUpdatedEntityID()
local controls_component = EntityGetFirstComponentIncludingDisabled(EntityGetRootEntity(card), "ControlsComponent");
if controls_component ~= nil then
    if not ComponentGetValue2(controls_component, "mButtonDownFire") then
        GlobalsSetValue("PLAYER_REVS", "0")
    end
    if revs < shieldrevs then
        GlobalsSetValue("PLAYER_REVS_SHIELD", tostring(math.max(revs, (shieldrevs/1.1)-1)))
    else
        GlobalsSetValue("PLAYER_REVS_SHIELD", tostring(revs))
    end
end

local shield = EntityGetFirstComponentIncludingDisabled(card, "EnergyShieldComponent")
if shield ~= nil then
    local particles = EntityGetComponentIncludingDisabled(card, "ParticleEmitterComponent") or {}
    local degrees = math.min(80, (shieldrevs ^ (1 / 2.5)) * 5 + 5)
    local radius = math.min(35, (shieldrevs / 35) + 16)
    for i=1, #particles do
        ComponentSetValue2(particles[i], "area_circle_sector_degrees", degrees)
        ComponentSetValue2(particles[i], "area_circle_radius", radius, radius)
    end
    ComponentSetValue2(shield, "sector_degrees", degrees)
    ComponentSetValue2(shield, "radius", radius)
    ComponentSetValue2(shield, "recharge_speed", math.min(100, (shieldrevs / 5) + 5))
    ComponentSetValue2(shield, "max_energy", math.min(100, (shieldrevs / 20) + 1))
end