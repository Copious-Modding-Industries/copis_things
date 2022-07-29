---@diagnostic disable: missing-parameter
dofile_once("mods/copis_things/files/scripts/lib/disco_util/disco_util.lua")

local self = Entity.Current()
if not self:parent() then
    local x, y = self:transform()
    local nearby = Entity.GetInRadius(x, y, 3)
    local host = nearby and nearby:search(function(ent) return ent:name() == "larpa_host" end)
    if host then
        self:setParent(host)
        local this_script = Component(GetUpdatedComponentID(), self:id())
        this_script.remove_after_executed = true
    end
end
