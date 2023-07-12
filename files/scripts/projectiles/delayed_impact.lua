dofile_once("data/scripts/lib/utilities.lua")

SetRandomSeed( GameGetFrameNum(), x + y + entity );
if Random() <= 0.25 then
    shoot_projectile_from_projectile( entity, "data/entities/projectiles/deck/purple_explosion.xml", x + Random( -4, 4 ), y + Random( -4, 4 ), 0, 0 );
end


-- Handle Shooting
local shoot_x, shoot_y = x + dist_x, y + dist_y
local projectile_id = EntityLoad(projectile, shoot_x, shoot_y)
local projcomp = EntityGetFirstComponent(projectile_id, "ProjectileComponent") --[[@cast projcomp number]]
local velcomp = EntityGetFirstComponent(projectile_id, "VelocityComponent") --[[@cast velcomp number]]
local genome = EntityGetFirstComponent(shooter, "GenomeDataComponent")
local herd_id = genome and ComponentGetValue2(genome, "herd_id") or -1
local velocity = math.random(vel_min, vel_max)
local vel_x, vel_y = aim_x * velocity, aim_y * velocity
GameShootProjectile(shooter, shoot_x, shoot_y, x + vel_x, y + vel_y, projectile_id, true)
ComponentSetValue2(projcomp, "mWhoShot", shooter)
ComponentSetValue2(projcomp, "mShooterHerdId", herd_id)
ComponentSetValue2(velcomp, "mVelocity", vel_x, vel_y)


-- TODO: INVESTIGATE EXPLOSIONCOMP ANDOR USE A PROJCOMP, MAKE IT GO BOOM AFTER A SECOND WITH MIRRORED STATS TO PROJ.
local entity_id = GetUpdatedEntityID()
local projcomp = EntityGetFirstComponent(entity_id, "ProjectileComponent") --[[@cast projcomp number]]
local proj_x, proj_y, proj_r = EntityGetTransform(entity_id)
local new_entity = EntityCreateNew()
EntitySetTransform(new_entity, proj_x, proj_y, proj_r)
EntityAddComponent2(new_entity, "ExplosionComponent", {
    
})