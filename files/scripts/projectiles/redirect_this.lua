---@diagnostic disable: param-type-mismatch, redundant-parameter
local entity_id = GetUpdatedEntityID();
local projectile = EntityGetFirstComponentIncludingDisabled( entity_id, "ProjectileComponent" ) --[[@cast projectile number]]
local lifetime = GetValueInteger("redirect_this_lifetime", 0)
local shooter = ComponentGetValue2( projectile, "mWhoShot" ) or 0

if shooter > 0 then
	local controls = EntityGetFirstComponentIncludingDisabled(shooter, "ControlsComponent")
	local velocity = EntityGetFirstComponentIncludingDisabled(entity_id, "VelocityComponent")
	local proj_lifetime = ComponentGetValue2( projectile, "lifetime" ) or 0
	if not controls or not velocity then return end

	local velcomp = EntityGetFirstComponent(entity_id, "VelocityComponent") --[[@cast velcomp number]]
	local vel_x, vel_y = ComponentGetValue2(velcomp, "mVelocity")
	local x, y = EntityGetTransform(entity_id)
	local cx, cy = ComponentGetValue2( controls, "mMousePosition" )
	local angle = math.atan2( cy-y, cx-x )
	local vel_x_new = math.cos( angle )
	local vel_y_new = math.sin( angle )

	local dist = 42
	for i=0, dist do
		GameCreateCosmeticParticle("spark_red", x+vel_x_new*i, y+vel_y_new*i, 1, 0, 0, 0, 0.05, 0.05, true, true, false, false, 0, 0)
	end

	if ComponentGetValue2( controls, "mButtonFrameFire" ) == GameGetFrameNum() or (lifetime > math.max(1, math.min(15,proj_lifetime/4)) and ComponentGetValue2( controls, "mButtonDownFire" )) then
		EntityRemoveComponent(entity_id, GetUpdatedComponentID())
		local magnitude = ( vel_x * vel_x + vel_y * vel_y )^0.5
		ComponentSetValue2(velcomp, "mVelocity", vel_x_new*magnitude, vel_y_new*magnitude)
	end

end

SetValueInteger("redirect_this_lifetime", lifetime+1)