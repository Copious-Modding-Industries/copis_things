local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )
local tx, ty = 0, 0
local vscs = EntityGetComponent( entity_id, "VariableStorageComponent" ) or {}
for i=1, #vscs do
	local name = ComponentGetValue( vscs[i], "name" )
	if name == "start_x" then
		tx = tonumber(ComponentGetValue2( vscs[i], "value_string")) or 0
	elseif name == "start_y" then
		ty = tonumber(ComponentGetValue2( vscs[i], "value_string")) or 0
	end
end
local ray_x = tx - x
local ray_y = ty - y
local dist = ((ray_x*ray_x)+(ray_y*ray_y))^0.5
local run, rise = ray_x/dist, ray_y/dist
for i=0, dist, 16 do
	---@diagnostic disable-next-line: undefined-global
	GameCreateSpriteForXFrames(table.concat{"mods/copis_things/files/particles/lightning_step/lightning_step_",math.random(1,7),".png"}, (x+run*i)+math.random(-1,1), (y+rise*i)+math.random(-1,1), true, 0, 0, math.random(6,8), true)
end