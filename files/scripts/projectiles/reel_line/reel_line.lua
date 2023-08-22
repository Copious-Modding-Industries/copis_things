do
	dofile_once("mods/azoth/files/lib/disco_util/disco_util.lua")

	local self = Entity.Current()

	local detect_range = 20

	function SetAnchor(x, y, angle)
		local joint_dist = 4
		local anchor = Entity(EntityLoad("mods/azoth/files/actions/tether/tether_anchor.xml",
										x - 2 * joint_dist * math.cos(angle),
										y - 2 * joint_dist * math.sin(angle)))
		anchor:addComponent("PhysicsJoint2Component", {
			type = "REVOLUTE_JOINT_ATTACH_TO_NEARBY_SURFACE",
			break_force = 10000,
			break_distance = 500,
			break_on_body_modified = false,
			offset_x = 0,
			offset_y = (math.sin(angle) < 0 and -4) or 4,
			body1_id = 0,
			ray_x = 4 * joint_dist * math.cos(angle),
			ray_y = 4 * joint_dist * math.sin(angle)
		})
	end

	function GetClosest(x, y, tags)
		local target = false
		local target_dist = false
		for i = 1, #tags do
			local closest = Entity(EntityGetClosestWithTag(x, y, tags[i]))
			if closest then
				local cx, cy = closest:transform()
				local dist = (cx - x) ^ 2 + (cy - y) ^ 2
				if not target or dist < target_dist then
					target = closest
					target_dist = dist
				end
			end
		end
		return target, target_dist
	end

	local x, y, angle = self:transform()
	local vel = self.VelocityComponent.mVelocity

	if vel.x ^ 2 + vel.y ^ 2 < 1 then
		local active = Entity.GetInRadius(x, y, detect_range):search(
						function(ent)
				return ent:name() == "tether_knot" and ent.var_bool.can_connect
			end)
		if active then
			-- If we already have an active tether then don't tether things to themselves
			return
		end
		-- Search for the closest tetherable thing
		local target, tdist = GetClosest(x, y, {"prop_physics", "item_physics", "tablet"})
		if target and tdist < detect_range ^ 2 then
			-- Found an object that can be tethered
			local children = target:children()
			local effect = children
							and children:search(function(ent)
					return ent:name() == "tether_knot"
				end)
			if effect then
				effect.var_bool.can_connect = true
				effect.ParticleEmitterComponent:setEnabled(true)
				effect:addComponent("LuaComponent", {
					script_source_file = "mods/azoth/files/actions/tether/tether_connect.lua",
					remove_after_executed = true
				})
			else
				target:addGameEffect("mods/azoth/files/actions/tether/tether_knot.xml")
			end
			return
		end
		-- If nothing was found, anchor to the wall
		SetAnchor(x, y, angle)
	else
		local effect = Entity.GetInRadius(x, y, detect_range):search(
						function(ent)
				return ent:name() == "tether_knot" and not ent.var_bool.can_connect
			end)
		if effect then
			effect.var_bool.can_connect = true
			effect.ParticleEmitterComponent:setEnabled(true)
			effect:addComponent("LuaComponent", {
				script_source_file = "mods/azoth/files/actions/tether/tether_connect.lua",
				remove_after_executed = true
			})
		end
	end
end

local entity_id = GetUpdatedEntityID()
local range = 20
