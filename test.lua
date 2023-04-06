do
    local projectile = nil
    for extra_entity in string.gmatch(c.extra_entities, '([^,]+)') do
        local new_entity = EntityLoad(extra_entity)
        EntityAddChild(projectile, new_entity)
    end
end




dofile_once("data/scripts/lib/utilities.lua")
-- load random stuff
local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
local self_velcomp = EntityGetFirstComponentIncludingDisabled( entity_id, "VelocityComponent" )
local self_projcomp = EntityGetFirstComponentIncludingDisabled(entity_id, "ProjectileComponent")
if self_projcomp and self_velcomp then
    local vel_x, vel_y = ComponentGetValueVector2( self_velcomp, "mVelocity" )
    local currbiome = tostring(BiomeMapGetName( pos_x, pos_y ))
    local shooter = ComponentGetValue2(self_projcomp, "mWhoShot")

    local biome_projectiles = {
        grenades = {
            ["Blast Pit"]       = {"mine", 265, 0.12},
            ["$biome_snowcave"] = {"ice", 150, 0.0},
        }
    }

    -- Set projs
    local projectiles = {
        {"light_bullet", 800, 0.10},
        {"bullet", 625, 0.8},
        {"bubbleshot", 250, 0.40},
        {"spitter", 500, 0.40},
        {"rubber_ball", 700, 0.14},
        biome_projectiles["grenades"][currbiome] or {"grenade", 265, 0.12},
    }

    -- make all projectiles from one shooter the same kind
    math.randomseed(entity_id)

    -- pick projectile based on the shooter id
    local projectile = projectiles[math.random(1, #projectiles)]

    -- re-randomize for spread and velocity
    math.randomseed(GameGetFrameNum(), entity_id)

    -- variation of speed above
    local var = projectile[3]

    -- 'length' is the base speed, it is multiplied by the variation value
    local length = projectile[2] * math.random(1 - var/2, 1 + var/2)

    -- set angle to fire at
    local angle = math.atan2( vel_y, vel_x ) + math.rad(math.random(-10,10))

    -- turn that into velocity
    vel_x = math.cos(angle) * length
    vel_y = math.sin(angle) * length

    -- offset pos
    pos_x = pos_x + math.random(-2, 2)
    pos_y = pos_y + math.random(-1, 1)

    -- shoot to kill
    do  -- Shooty logic
        local fired_shot = EntityLoad( table.concat{"data/entities/projectiles/mimic_", projectile[1], ".xml"}, x, y )
        local fired_projcomp = EntityGetFirstComponentIncludingDisabled(fired_shot, "ProjectileComponent")
        local fired_velcomp = EntityGetFirstComponentIncludingDisabled(fired_shot, "ProjectileComponent")
        if fired_projcomp and fired_velcomp then
            ComponentSetValue2(fired_projcomp, "mWhoShot", shooter)
            ComponentSetValue2(fired_projcomp, "mEntityThatShot", entity_id )
            GameShootProjectile( shooter, pos_x, pos_y, pos_x+vel_x, pos_y+vel_y, fired_shot, true, entity_id )
            ComponentSetValueVector2( fired_velcomp, "mVelocity", vel_x, vel_y)
        end
    end
end