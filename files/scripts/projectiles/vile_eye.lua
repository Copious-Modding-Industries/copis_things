local lifetime = GameGetFrameNum() - GetValueInteger("vile_eye_created", GameGetFrameNum())
local entity_id = GetUpdatedEntityID()
local projectile = EntityGetFirstComponentIncludingDisabled( entity_id, "ProjectileComponent" ) --[[@cast projectile number]]
local shooter = ComponentGetValue2( projectile, "mWhoShot" ) or 0
if shooter > 0 then

	local controlscomp = EntityGetFirstComponentIncludingDisabled(shooter, "ControlsComponent")
	local PSPC = EntityGetFirstComponentIncludingDisabled(shooter, "PlatformShooterPlayerComponent")
	if not PSPC or not controlscomp then EntityKill(entity_id) return end

	if GameGetFrameNum() - ComponentGetValue2(controlscomp, "mButtonFrameDown") >= 210 and ComponentGetValue2(controlscomp, "mButtonDownDown") then
		local IGC = EntityGetFirstComponentIncludingDisabled(shooter, "InventoryGuiComponent") --[[@cast IGC number]]
		ComponentSetValue2(IGC, "mBackgroundOverlayAlpha", 9)
		EntityKill(entity_id)
	end


	local iris = (function ()
		local SPECs = EntityGetComponentIncludingDisabled(entity_id, "SpriteParticleEmitterComponent") or {}
		for i=1, #SPECs do if ComponentGetValue2(SPECs[i], "sprite_file") == "mods/copis_things/files/projectiles_gfx/vile_eye_iris.png" then return SPECs[i] end end
	end)()
	local nerves = (function ()
		local children = EntityGetAllChildren(entity_id) or {}
		for i=1, #children do
			if EntityGetName(children[i]) == "nerves" then return EntityGetFirstComponentIncludingDisabled(children[i], "InheritTransformComponent") end
		end
	end)() --[[@cast nerves number]]
	if lifetime == 0 then
		local IGC = EntityGetFirstComponentIncludingDisabled(shooter, "InventoryGuiComponent") --[[@cast IGC number]]
		ComponentSetValue2(IGC, "mBackgroundOverlayAlpha", 9)
	end
	local x, y = EntityGetTransform(entity_id)
	local r = 3.5
	local mx, my = ComponentGetValue2(PSPC, "mSmoothedAimingVector")
	ComponentSetValue2(PSPC, "mDesiredCameraPos", x+mx*25, y+my*25)
	ComponentSetValue2(iris, "randomize_position", mx*r, my*r, mx*r, my*r)
	ComponentSetValue2(nerves, "Transform", mx*-r, my*-r, 0, 1, 1)
else
	EntityKill(entity_id)
end