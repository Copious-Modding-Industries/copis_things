local x, y = EntityGetTransform(GetUpdatedEntityID())
PhysicsApplyForceOnArea(
function(entity, body_mass, body_x, body_y, body_vel_x, body_vel_y, body_vel_angular)

return body_x, body_y, 0, -body_mass*9.8, 0 -- forcePosX,forcePosY,forceX,forceY,forceAngular
end, 0, x, y, x, y)