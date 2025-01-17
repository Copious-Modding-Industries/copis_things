local path = "mods/grahamsperks/files/pickups/magmastone.xml"
local content = ModTextFileGetContent(path)
content = content:gsub([[_tags="enabled_in_hand"%s*effect="PROTECTION_ELECTRICITY"]],[[_tags="enabled_in_hand,enabled_in_inventory" effect="PROTECTION_ELECTRICITY"]])
content = content:gsub([[_tags="enabled_in_hand"%s*effect="PROTECTION_FIRE"]],[[_tags="enabled_in_hand,enabled_in_inventory" effect="PROTECTION_FIRE"]])
ModTextFileSetContent(path, content)
