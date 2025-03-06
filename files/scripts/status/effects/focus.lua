local entity_id = GetUpdatedEntityID()
local GEC = EntityGetFirstComponentIncludingDisabled(entity_id, "GameEffectComponent") ---@cast GEC number
local UIC = EntityGetFirstComponent(entity_id, "UIIconComponent") ---@cast UIC number
local PEC = EntityGetFirstComponent(entity_id, "ParticleEmitterComponent") ---@cast PEC number
local SPEC = EntityGetFirstComponentIncludingDisabled(entity_id, "SpriteParticleEmitterComponent") ---@cast SPEC number
local focus = math.max(0, ComponentGetValue2(GEC, "frames")-1)
ComponentSetValue2(GEC, "frames", focus)
ComponentSetValue2(PEC, "count_min", (3-math.floor(focus/120))*2)
ComponentSetValue2(PEC, "count_max", (10-math.floor(focus/40))*2)
EntitySetComponentIsEnabled(entity_id, SPEC, focus == 0)
ComponentSetValue2(UIC, "icon_sprite_file", table.concat{"mods/copis_things/files/ui_gfx/status_indicators/focus", focus == 0 and "" or "_less", ".png"})
ComponentSetValue2(UIC, "description", GameTextGet("$effectdesc_copith_focus", ("%i%%a"):format(tostring((240 - focus)/2.40))))