dofile_once("mods/copis_things/files/scripts/lib/disco_util/disco_util.lua")
local self = Entity.Current()

if self.VelocityComponent ~= nil then
    local m_velocity = self.VelocityComponent.mVelocity
    local vx = m_velocity.x
    local vy = m_velocity.y
    local magnitude = math.sqrt( vx * vx + vy * vy );
    local frames = GameGetFrameNum() - self.var_int.copi_chaotic_burst_frame or GameGetFrameNum()
    local scale = math.random() * math.pow( magnitude, 0.6 ) / 60 * math.min( 1, frames * 0.20 );
    local angle = math.atan2( vy, vx ) + ( math.random() - 0.5 ) * math.pi * scale;
    m_velocity.x = math.cos( angle ) * magnitude
    m_velocity.y = math.sin( angle ) * magnitude
    self.VelocityComponent.mVelocity = m_velocity
end

self.var_int.copi_chaotic_burst_frame = GameGetFrameNum()