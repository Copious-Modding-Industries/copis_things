dofile_once("data/scripts/gun/procedural/gun_action_utils.lua")
dofile_once("mods/copis_things/files/scripts/lib/disco_util/disco_util.lua")

-- Init code, called once at turret creation
local self = Entity.Current()
if self.var_bool.initialized then return end

local storage = Entity(EntityGetWithName("turret_storage"))
if not storage then return end
-- Populate our data table from storage
local source = {
    wand = Entity(tonumber(storage.variables.wand)),
    deck = StringSplit(storage.variables.deck, ",", tonumber),
    inventoryitem_id = StringSplit(storage.variables.inventoryitem_id, ",", tonumber)
}
-- kill storage now that we're done with it
storage:kill()

if source.wand == nil then
    print_error("No original wand found for turret")
    self:kill()
    return
end
local inv = self:children():search(function(ent) return ent:name() == "inventory_quick" end)[1]
local my_wand = inv:children():search(function(ent) return ent:hasTag("wand") end)[1]
if my_wand == nil then
    print_error("Turret couldn't find its own wand!")
    self:kill()
    return
end

-- Set my wand stats based on the wand that created me
WandCopy(source.wand, my_wand)
-- Populate the turret wand with copies of the spells recorded by the cast
for k, v in pairs(source.deck) do
    v = Entity(v)
    local action_entity = Entity(CreateItemActionEntity(v.ItemActionComponent.action_id))
    if action_entity ~= 0 then
        action_entity:setParent(my_wand)
        -- Set the turret copy to have the same number of uses as the original
        action_entity.ItemComponent.uses_remaining = v.ItemComponent.uses_remaining
        -- Link the turret to the same spell entry as the original
        action_entity.ItemComponent.mItemUid = source.inventoryitem_id[k]
        action_entity:setEnabledWithTag("enabled_in_world", false)
    end
end
self.var_bool.initialized = true
