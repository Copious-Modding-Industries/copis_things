local lifetime = GameGetFrameNum() - GetValueInteger("vile_eye_created", GameGetFrameNum())
local entity_id = GetUpdatedEntityID()
local projectile = EntityGetFirstComponentIncludingDisabled( entity_id, "ProjectileComponent" ) --[[@cast projectile number]]
local shooter = ComponentGetValue2( projectile, "mWhoShot" ) or 0
if shooter > 0 then
	local PSPC = EntityGetFirstComponentIncludingDisabled(shooter, "PlatformShooterPlayerComponent")
	if not PSPC then EntityKill(entity_id) return end
	if lifetime == 0 then
		local IGC = EntityGetFirstComponentIncludingDisabled(shooter, "InventoryGuiComponent") --[[@cast IGC number]]
		ComponentSetValue2(IGC, "mBackgroundOverlayAlpha", 9)
	end
	local x, y = EntityGetTransform(entity_id)
	local mx, my = ComponentGetValue2(PSPC, "mSmoothedAimingVector")
	ComponentSetValue2(PSPC, "mDesiredCameraPos", x+mx*25, y+my*25)
else
	EntityKill(entity_id)
end