return function (shooter)
	local target_x, target_y = EntityGetTransform(shooter)
	local vtarget_x, vtarget_y = target_x, target_y
	local inventory = EntityGetFirstComponent(shooter, "Inventory2Component")
	if inventory then
		local active_wand = ComponentGetValue2(inventory, "mActiveItem")
		if EntityHasTag(active_wand, "wand") then
			local _, _, rot = EntityGetTransform(active_wand)
			local HotspotComponent = EntityGetFirstComponentIncludingDisabled(active_wand, "HotspotComponent", "shoot_pos")
			if HotspotComponent then
				local ox, oy = ComponentGetValueVector2(HotspotComponent, "offset")
				local tx = math.cos(rot) * ox - math.sin(rot) * oy
				local ty = math.sin(rot) * ox + math.cos(rot) * oy
				vtarget_x, vtarget_y = vtarget_x + tx, vtarget_y + ty - 4
			end
		end
	end
	return vtarget_x, vtarget_y, target_x, target_y
end