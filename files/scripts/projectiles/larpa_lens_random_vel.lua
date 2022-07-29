---@diagnostic disable: undefined-field
dofile_once("mods/copis_things/files/scripts/lib/disco_util/disco_util.lua")

local self = Entity.Current()
if not self.VelocityComponent then return end
local vel = self.VelocityComponent.mVelocity
local speed = math.sqrt(vel.x ^ 2 + vel.y ^ 2)
local angle = math.atan2(vel.y, vel.x)
local cone = 30 * math.pi / 180
angle = angle + cone * (math.random() - 0.5)
vel.x = speed * math.cos(angle)
vel.y = speed * math.sin(angle)
self.VelocityComponent.mVelocity = vel
