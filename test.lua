do
    local projectile = nil
    for extra_entity in string.gmatch(c.extra_entities, '([^,]+)') do
        local new_entity = EntityLoad(extra_entity)
        EntityAddChild(projectile, new_entity)
    end
end


do
    local action = function()
        local projectile = "mods/copis_things/files/entities/projectiles/dart.xml"
        if not reflecting then
            local caster = GetUpdatedEntityID()
            local controls_component = EntityGetFirstComponentIncludingDisabled(caster, "ControlsComponent")
            if controls_component ~= nil then
                -- Check if  began shooting THIS FRAME
                local shooting_start = ComponentGetValue2(controls_component, "mButtonFrameFire")
                if GameGetFrameNum() == shooting_start then
                    -- Add the projectile
                    add_projectile(projectile)
                end
            end
        else
            -- Reflection data
            Reflection_RegisterProjectile(projectile)
        end
    end
    action()
end


c = {}

-- save and clear c
local old_c = c
c = {}
reset_modifiers( c )

-- make outer trigger
BeginProjectile( "mods/copis_things/files/entities/projectiles/trigger_projectile.xml" )
    BeginTriggerDeath()
        -- clone c
        for k,v in pairs( old_c ) do
            c[k] = v
        end
        -- add stuff
        c.extra_entities = c.extra_entities .. "something.xml,"
        -- draw or beginprojectile here
        register_action( c )
        SetProjectileConfigs()
    EndTrigger()
EndProjectile()

c = old_c




c = {}
reset_modifiers( c )
BeginProjectile("mods/evaisa.materiamancy/files/entities/materiamancy/trigger_projectile.xml")
    BeginTriggerDeath()

        c.extra_entities = c.extra_entities..offset_ent..",mods/evaisa.materiamancy/files/entities/materiamancy/lua.xml,"
        BeginProjectile("mods/evaisa.materiamancy/files/entities/materiamancy/handler_projectile.xml")
            BeginTriggerTimer(Random(30, 120))
                c = {}
                reset_modifiers( c )
                for k,v in pairs(old_c) do
                    c[k] = v
                end
                BeginProjectile("mods/evaisa.materiamancy/files/entities/materiamancy/projectile.xml")

                EndProjectile()
                register_action( c )
            EndTrigger()
        EndProjectile()
        register_action( c )
    SetProjectileConfigs()
    EndTrigger()
EndProjectile()



function find_polymorphed_players()
    local nearby_polymorph = EntityGetWithTag( "polymorphed" ) or {};
    local polymorphed_players = {};
    for _,entity in pairs( nearby_polymorph ) do
        local game_stats = EntityGetFirstComponent( entity, "GameStatsComponent" );
        if game_stats ~= nil then
            if ComponentGetValue2( game_stats, "is_player" ) == true then
                table.insert( polymorphed_players, entity );
            end
        end
    end
    return polymorphed_players;
end

-- Can be swapped with in radius with tag, etc. Just get a list of polied creatures.
local polied = EntityGetWithTag( "polymorphed" ) or {}
local players = {}
for i=1, #polied do
    local statcomp = EntityGetFirstComponent( polied[i], "GameStatsComponent" )
    if statcomp ~= nil then
        if ComponentGetValue2( statcomp, "is_player" ) == true then
            players[#players+1] = polied[i]
        end
    end
end