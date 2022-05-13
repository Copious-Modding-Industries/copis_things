function add_projectile_repeating_trigger_timer( entity_filename, delay_frames, action_draw_count )
    if reflecting then 
        Reflection_RegisterProjectile( entity_filename )
        return 
    end

    BeginProjectile( entity_filename )
    BeginTriggerTimer( delay_frames )
        draw_shot( create_shot( action_draw_count ), true )
    BeginTriggerTimer( delay_frames )
        draw_shot( create_shot( action_draw_count ), true )
    BeginTriggerTimer( delay_frames )
        draw_shot( create_shot( action_draw_count ), true )
    EndTrigger()
    EndProjectile()
end