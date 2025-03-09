-- ONLY use latest version of this code across mods
-- Copi tech below.
local ver = 1.0
if ver > (Datat_ver or 0) then
	Datat_ver = ver
	-- Add Datat as a place to insert data. Modders should coordinate on what maps to what.

	function ResetDatat()
		DontTouch_Data = {}
		Datat = setmetatable(
			{__maxindx = -math.huge},
			{__newindex = function(t, k, v)
				if type(k) == "number" and k > t.__maxindx then t.__maxindx = k end
				DontTouch_Data[k] = v
			end}
		)
	end
	ResetDatat()

	if not DidWePatchThisShitCopi then
		-- Patch ConfigGunActionInfo_PassToGame to inject data last minute
		local ConfigGunActionInfo_PassToGame_old = ConfigGunActionInfo_PassToGame
		function ConfigGunActionInfo_PassToGame(...)
			if not reflecting then
				for i=1, math.max(Datat.__maxindx,13) do if not DontTouch_Data[i] then DontTouch_Data[i]="" end end
				c.action_description = table.concat(DontTouch_Data, "\n")
			end
			ConfigGunActionInfo_PassToGame_old(...)
		end
		DidWePatchThisShitCopi = true
	end
end
