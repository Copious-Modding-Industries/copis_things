local extract = dofile_once("mods/copis_things/files/scripts/lib/proj_data.lua")
local entity_id = GetUpdatedEntityID()
local proj = EntityGetFirstComponentIncludingDisabled( entity_id, "ProjectileComponent" ) --[[@cast proj number]]
local lua = EntityGetFirstComponentIncludingDisabled( entity_id, "LuaComponent" ) --[[@cast lua number]]
local x, y, r = EntityGetTransform(entity_id)
if ComponentGetValue2(lua, "mTimesExecuted") == 0 then
	-- CASE: PROJECTILE JUST CREATED
	-- Store initial velocity for offset
	SetValueNumber("SRS_r", r)
else
	local shooter = ComponentGetValue2( proj, "mWhoShot" )
	local controls = EntityGetFirstComponent(shooter, "ControlsComponent")
	if controls then
		local pcl = EntityGetFirstComponentIncludingDisabled( entity_id, "ParticleEmitterComponent" ) --[[@cast pcl number]]
		local vel = EntityGetFirstComponentIncludingDisabled( entity_id, "VelocityComponent" ) --[[@cast vel number]]
		local aimx, aimy = ComponentGetValue2( controls, "mAimingVectorNormalized" )


		local aim_angle = math.atan2( aimy, aimx )
		if ComponentGetValue2(lua, "mTimesExecuted") == 1 then
			--SetValueNumber("SRS_o", aim_angle-GetValueNumber("SRS_r", 0))
		end
		aim_angle = aim_angle--+GetValueNumber("SRS_o", 0)


		local inventory = EntityGetFirstComponent(shooter, "Inventory2Component")
		if inventory then
			-- Handle shoot dist
			local offset_x, offset_y = 5, 0
			local active_wand = ComponentGetValue2(inventory, "mActiveItem")
			if EntityHasTag(active_wand, "wand") then
				local HotspotComponent = EntityGetFirstComponentIncludingDisabled(active_wand, "HotspotComponent", "shoot_pos")
				if HotspotComponent then
					local wand_x, wand_y, wand_r = EntityGetTransform(active_wand)
					local ox, oy = ComponentGetValue2(HotspotComponent, "offset")
					local tx = math.cos(wand_r) * ox - math.sin(wand_r) * oy
					local ty = math.sin(wand_r) * ox + math.cos(wand_r) * oy
					offset_x, offset_y = tx, ty
				end
			end


			local mx, my = ComponentGetValue2(controls, "mMousePosition")
			local vx, vy = mx-x, my-y


			local mag = (vx*vx+vy*vy)^2
			ComponentSetValue2( vel, "mVelocity", (vx)*12, (vy)*12 )
			ComponentSetValue2( pcl, "image_animation_file", table.concat{"mods/copis_things/files/particles/image_emitters/flurry", vx>0 and "2" or "", ".png"})
			print(table.concat{"mods/copis_things/files/particles/image_emitters/flurry", vx>0 and "2" or "", ".png"})




			-- Transform
			local wx, wy = EntityGetTransform( active_wand )
			EntityApplyTransform( wx + offset_x * math.cos( aim_angle ), wy + offset_y * math.sin( aim_angle ) )
			-- Velocity
		end

		-- Cause the trigger to hit, firing the payload.
		if ComponentGetValue2( controls, "mButtonDownFire" ) == false then
			local vx, vy = ComponentGetValue2( vel, "mVelocity")
			local angle = math.atan2( vy, vx )
			ComponentSetValue2( vel, "mVelocity", math.cos( angle ) * 100, math.sin( angle ) * 100 )
			ComponentSetValue2( proj, "mLastFrameDamaged", -1 )
		end
	end
end
