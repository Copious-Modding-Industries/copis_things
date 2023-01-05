local entity = GetUpdatedEntityID()
local dmcs = EntityGetComponent( entity, "DamageModelComponent" );
local invincibility_left = 0;
for _, damage_model in ipairs( dmcs ) do
    local invincibility_frames = ComponentGetValue2( damage_model, "invincibility_frames" );
    if invincibility_frames > invincibility_left then
        invincibility_left = invincibility_frames;
    end
end

if invincibility_left > 0 then
    local alpha = math.floor( GameGetFrameNum() / 2 ) % 2
    if invincibility_left == 1 then
        alpha = 1
    end
    local spritecomps = EntityGetComponentIncludingDisabled( entity, "SpriteComponent" ) or {}
    for _, sprite in ipairs( spritecomps ) do
        ComponentSetValue2( sprite, "alpha", alpha )
    end
end