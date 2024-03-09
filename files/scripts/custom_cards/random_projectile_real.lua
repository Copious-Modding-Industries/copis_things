local entity_id = GetUpdatedEntityID()
local v = ((Random()+math.sin(GameGetFrameNum()/32)) - GameGetFrameNum()%2)-(math.random(-1,0)*math.random(0,1))
local spritecomp = EntityGetFirstComponentIncludingDisabled(entity_id, "SpriteComponent", "item_identified") --[[@cast spritecomp number]]
ComponentSetValue2(spritecomp, "alpha", math.random()*3)
if v < 0 then return end
local itemcomp = EntityGetFirstComponentIncludingDisabled(entity_id, "ItemComponent") --[[@cast itemcomp number]]
local path = table.concat{"mods/copis_things/files/ui_gfx/gun_actions/extra_gfx/random_projectile_real/sprite_", tostring(math.random(1, 224)), ".png" }
ComponentSetValue2(itemcomp, "ui_sprite", path)
ComponentSetValue2(spritecomp, "image_file", path)
ComponentSetValue2(itemcomp, "item_name", (function(len) local str = {} for i = 1, len do str[i] = string.char(math.random(48, 125)) end return table.concat(str) end)(math.random(12,24)))