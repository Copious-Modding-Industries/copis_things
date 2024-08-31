local entity_id = GetUpdatedEntityID()
local velcomp = EntityGetFirstComponentIncludingDisabled( entity_id, "VelocityComponent" ) --[[@cast velcomp number]]
local pos_x, pos_y = EntityGetTransform( entity_id )



local vel_x, vel_y = ComponentGetValue2( velcomp, "mVelocity") --[[@cast vel_x number]] --[[@cast vel_y number]]

local scale = math.max( math.abs( vel_x ), math.abs( vel_y ) ) * 0.2
local random_adjustment = Random( 0 - scale, scale )

vel_x = vel_x + random_adjustment
vel_y = vel_y + random_adjustment

ComponentSetValueVector2( velcomp, "mVelocity", vel_x, vel_y)