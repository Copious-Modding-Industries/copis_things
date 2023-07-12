local effect_id = GetUpdatedEntityID()
local victim_id = EntityGetRootEntity(effect_id)
local controlscomp = EntityGetFirstComponentIncludingDisabled(victim_id, "ControlsComponent")
local animalaicomp = EntityGetFirstComponent(victim_id, "AnimalAIComponent")
if animalaicomp then
    ComponentSetValue2(animalaicomp, "sense_creatures",  false) --idk I think this might be *too* fucked up
end
if controlscomp then
    -- SPASM BITCH SPASM! todo: figure out forcing enemies to attack
    ComponentSetValue2(controlscomp, "mButtonDownFly",   false)
    ComponentSetValue2(controlscomp, "mButtonDownRight", math.random()>0.5)
    ComponentSetValue2(controlscomp, "mButtonDownLeft",  math.random()>0.5)
    ComponentSetValue2(controlscomp, "mButtonDownDown",  math.random()>0.5)
    ComponentSetValue2(controlscomp, "mButtonDownUp",    math.random()>0.5)
    ComponentSetValue2(controlscomp, "mButtonDownJump",  math.random()>0.5)
end

local owner_id = nil
local vscs = EntityGetComponentIncludingDisabled(effect_id, "VariableStorageComponent") or {}
for i=1, #vscs do
    local vsc = vscs[i]
    if ComponentGetValue2(vsc,"name") == "projectile_who_shot" then
        owner_id = ComponentGetValue2(vsc,"value_int")
        break
    end
end

if not owner_id then return end
if EntityGetIsAlive(owner_id) then
    local inv2comp = EntityGetFirstComponentIncludingDisabled(owner_id, "Inventory2Component")
    if inv2comp then
        local activeitem = ComponentGetValue2(inv2comp, "mActiveItem")
        if EntityHasTag(activeitem, "wand") then
            local ability = EntityGetFirstComponentIncludingDisabled(activeitem, "AbilityComponent") --[[@cast ability number]]
            local mana = ComponentGetValue2(ability, "mana")
            if mana >= 1 then
                ComponentSetValue2(ability, "mana", mana - 1)
            else
                EntityKill(effect_id)
                local x, y = EntityGetTransform(effect_id)
                GamePlaySound("data/audio/Desktop/items.bank", "magic_wand/out_of_mana", x, y)
            end
        else
            EntityKill(effect_id)
        end
    end
else
    EntityKill(effect_id)
end