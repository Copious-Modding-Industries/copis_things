dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

local satelliteOrbitalPeriod = 100
local satelliteOrbitalRadius = 100



--[[


edit_component( entity_id, "VelocityComponent", function(comp,vars)
    local vel_x, vel_y = ComponentGetValue2( comp, "mVelocity")

    local len = math.sqrt((mouse_x*mouse_x) + (mouse_y*mouse_y))

    local force_x = vel_x + (mouse_x-pos_x)/len * speed
    local force_y = vel_y + (mouse_y-pos_y)/len * speed

	ComponentSetValueVector2( comp, "mVelocity", force_x, force_y)
    ComponentSetValue2( comp, "gravity_x", 0 )
    ComponentSetValue2( comp, "gravity_y", 0 )
end)

edit_component2( entity_id, "VelocityComponent", function(comp,vars)
    vars.gravity_y = 0
    vars.air_friction= 4
    vars.mass= 0
  end)


]]--