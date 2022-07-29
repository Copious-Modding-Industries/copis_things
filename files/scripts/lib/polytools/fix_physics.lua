dofile_once("[POLYTOOLS_PATH]disco_util/disco_util.lua")

local self = Entity.Current()
local pbc = self.PhysicsBodyComponent
if pbc then
    local blacklist = {initial_velocity = true, mBody = true, mBodyId = true, mPixelCount = true,
                       mLocalPosition = true, mRefreshed = true}
    for _, comp in pbc:ipairs() do
        local data = {}
        for k, v in pairs(comp:members()) do if not blacklist[k] then data[k] = comp[k] end end
        comp:remove()
        self:addComponent("PhysicsBodyComponent", data)
    end
end
