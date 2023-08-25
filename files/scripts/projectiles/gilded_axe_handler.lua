-- Gather data
local entity_id = GetUpdatedEntityID()
local vscs = EntityGetComponent(entity_id, "VariableStorageComponent") or {}
local embedded_id   = nil
local offset_x      = nil
local offset_y      = nil
for i=1,#vscs do
    local comp = vscs[i]
    local name = ComponentGetValue2(comp, "name")
    if name == "gilded_axe_embedded_id" then
        embedded_id = ComponentGetValue2(comp, "value_int")
    elseif name == "gilded_axe_embedded_offset_x" then
        offset_x = ComponentGetValue2(comp, "value_float")
    elseif name == "gilded_axe_embedded_offset_y" then
        offset_y = ComponentGetValue2(comp, "value_float")
    end

    if embedded_id and offset_x and offset_y then
        break
    end
end

if EntityGetIsAlive(embedded_id) then
    -- Move axe onto victim
    if offset_x and offset_y then
        local victim_x, victim_y, victim_rot, victim_sx, victim_sy = EntityGetTransform(embedded_id)
        offset_x = offset_x * victim_sx
        offset_y = offset_y * victim_sy
        local cosine = math.cos(victim_rot)
        local sine   = math.sin(victim_rot)
        local axe_x = cosine * offset_x - sine   * offset_y
        local axe_y = sine   * offset_x + cosine * offset_y
        EntitySetTransform(entity_id, (victim_x + axe_x), (victim_y + axe_y))
    end

    -- Speed up held wand
    local projcomp = EntityGetFirstComponent(entity_id, "ProjectileComponent")
    if projcomp then
        local shooter = ComponentGetValue2(projcomp, "mWhoShot")
        local inv2comp = EntityGetFirstComponentIncludingDisabled(shooter, "Inventory2Component")
        if inv2comp then
            local activeitem = ComponentGetValue2(inv2comp, "mActiveItem")
            if EntityHasTag(activeitem, "wand") then
                local now = GameGetFrameNum()
                local ability = EntityGetFirstComponentIncludingDisabled(activeitem, "AbilityComponent") --[[@cast ability number]]
                local rnfu = ComponentGetValue2(ability, "mReloadNextFrameUsable")
                local rfl  = ComponentGetValue2(ability, "mReloadFramesLeft")
                ComponentSetValue2(ability, "mReloadNextFrameUsable",   now+math.max(1,((rnfu-now)/1.05)) -0.5)
                ComponentSetValue2(ability, "mReloadFramesLeft",        math.max(1,(rfl/1.05)             -0.5))
            end
        end
    end

else
    local projcomp = EntityGetFirstComponent(entity_id, "ProjectileComponent")
    if projcomp then
        ComponentSetValue2(projcomp, "on_death_explode", true)
    end
    EntityKill(entity_id)

--[[                            EntityKill entity_id... NOW!

:^!YB@#PYG@@P~::::::::::.:::::^^!!!!!777~^7?7!:.:!??7!7!^^:.....               .^B#~.                   
JB##BY!^^Y&@G!:::::::^^^^^~~!7???^::^~... ..     ..~~^:^77~~::.....             :G&7:                   
5&BP5Y7~~Y&@G7^^^^^^~~777J???7^...                      .~~77!~^:........       .?&#~.                  
PBPYJ5GP77P@@G?~~~~!???77!.        .                       .^:!7!~^::.......... .7&#~.                  
GG7~~!?BBJ5&@#GPYJ??YJ:                                       .:.^7!!^::........^5@P:.........          
7P5JY5GBG?Y&@GYPB&G5Y~.  .     .                            ..   .^^~7!~::....:!5&&?................    
Y5B&&G5J?JJ5&@&GB&#GJ:..                                    .!:..   .75P!:...!B@@&P^...............     
?5#&&55PGG##&@&P5B@#Y:..                                     :!~... .~B#?~~7J#@&&@P^...............     
!JB&GYYYY5&@@@&GG&@B!..            .:         ...^.           .!PGJ^J&@&GB&&&&P?Y&#~.............       
?P&GY?????JYP#@@@@#Y:.             :J~:.....:^5YP~.         ..~P@@@#@@@@@&PJ?7~^7B&J^..........         
JGG5YYYJ?77??5#@@@&?.       .:^77?Y5##GGGBBGGB&@&P?!~:..  .~B#&@@@@@@@@&P?!^^^::^Y&#!.......            
5P55555YJ?JJYP&@@@@G^   .^~!J5GBBBGGB##BB#BBB#&@@&##GGGGY??#@@@@@@@&&#P5?!^^::..:J&5^..                 
J5P5YJJJY5PB#&@@&&@@P^^!77?J?JY5PGGB#&&#####&&@@@@@&#GGGG#@@@@@@#P?777?J7~:...^7P#@5^                   
?YPP5YJJYG&@&&##B#&@@####&&#5YY5G#&&&&&###&&&@@@@@@@&BB#&@@@@&#BJ~~~~!J57~~!7JGBGB&5:                   
5PGGGPP5PG&#GPPGB#@@@@@&#B#@#GPPGB&@@&&&&&@@@@@&&&@@&##@@@@#BGGP!::^^~5PJG&@@@&7::^:.                   
###BBBBGB#&BGPPG#@@&&&&G7?5B&&##&&@@@@@@@@@@@@&&&&&@@@&@@&#GP5P57^^~^~77J&@@@@5^....                    
&&&####&&#BGP5PB@@#&@@&5?5#B##&@@@@@@&&&&&&&@&&&&&&&@@@@@@&#G5YY5J~~7JYG#@@@@@Y:....                    
##&&&&@&#GGP55P#@@##@#G??Y#&BPG&@###&&&&&&&&&&&&&&&&&&####&&BPYJYY~~?G&@@@@&GJ^....... ..               
&&@@@@&#BBGP5PB@@&##&#G!:~Y&BGB@BJJY5PB#####BGP5J?77?JJYYYP##GPYJJ7?5#@@&#Y!::.............             
&@@@@@&&&&&&##@@@@&&&&B7!J#@@@@@@#PJ7?YG####G5JY5PB&&@@&#GP#@@@GYJ5#&&@@#BP!:...............            
@@@&&&@@@&##&@@@@&PB&#B5JJP@@@@@@@&BJ!5#&&&#BPPB&@@@@@@@@@@@@@@&#B#&@@@@#5GBY~:.....................    
&&&##&@@@@&&@@@&&B?B#PYJ5PB&@@@@@@@&5?G#&&&#B#&&&@@@@@@@@@&&&@@@@@&@@@@@#JY&#&J^:...........  ......    
@&&&#&@@@@&#&@@&&G5&#5YG####&&@@&&&GJ5##&&####&&&&@@@@@@@&&####&@@@@@@&B#775BB&5~...........   .. ..    
@@&&&#&@@@&BB&@@&GP&#55GB###&&&&&#GYJP##&&####&&&&&@@@@@@&&###&&&#B####BB!~??7G&P7:.........       .    
@@&&&&@&#BGPG#@&&J7@#P5PBB##&&&##GY?YB##&#BB###&&&&&&@@@@&&#&&&BP5?555G&Y~^^::!P@B~.........       .    
@@&@@@&&BGPPG#&B&J^&&GY5GB######B5?YB&&&&&#BBB#&&&&&&@@&&&####BPYY7B&G#&7~^:..~P@&5^................    
@@&&&&@&BGPPPB#G##!#@BJJPBB#####BYJJG#&&&&####B#&&&&&&&&&#BBBBG5YY7BGG&P~^::..:!5B&#5!^.............    
@@@@@&&#BGP55GB5G&7P@BY?YPB###&#57~.^75GGY~^75B#&&&&&&&&#BBBBBG55J7GB&#?~^:.....:~P@&##Y~...........    
Y5Y5G##BBGP555B5YPPP&BPPY5GBB#BGP5J!~~75GBBBGG#&&&&&&&###BBBBBGPP7JB#@#J~::......:~5###@Y^..........    
^:::^?G#BBGP5YYJJJ5Y&BPGP?5PPGGGGGGPJ7P#5P###&&&&&&###BBBBBBGPGGPJ5GP5#&Y~:.......^7B@&@5^..........    
:::::^?BBBGGPYJ??JJYB&GGG?7?J5555Y?!~5#BYYG55PB##&#BBGBGGGGGPPGGG5?!~!JB&J^:......^J&G#@#!:.........    
::::::!GGGGGP5YJJJYY?##BGGY5?7JJYYY55GBBB##BPPGBB#GGGGGGGGGPPGGJ??!~^^^7G&J~:....:^5B?J#@&5~:.......    
:.::::~7~!JPP5Y?7?JJ?5#&###B??J!~!7???7J???J5YY5YYY5PGGGGGGPPGY!Y7~^^::!5@&GJ^:..:^5B?Y&@@@&P7^.....    
::::::^~^^~!~~:..:^~?YG&&#&B?77J5GB#BBBBBBBBGPYYPP5PGGGGGGGP5?^?P!~^:::!P#5P#7^:..:~YGB&@BB&@@G~....    
~^^^^^^^~~!7J?77!7J5PGGG&@&#5Y5P5G&&&&@@@@&&BGBBBBP5PPPPGPP?^::YG7~^^:^7#&Y7JPY~:::~J5&#@G?Y&@@Y^:..    
~~~~7Y55PB#&&######BBB###&@&BP5?!~7JYY5YYYJJY5GGGGGPPPGGG5~..755P57!~~!P&@#G5YPB?^^7GY&&@#PB@@##P~^:    
^~7P&@&##G5?!~~~~~^^^^~!7?B&G7!~~~!!!!!~7?YPGGGGGGGGGGGP?: :JPP5J5P?7?P&GJ7JGB###P!J#G&@&YJB@&YY#BPY    
^?#@&5!^^:::::::::...::^~77PB5!!7?J5PGB#&&&&###BBBGGPJ!:.:?YPPPPY?5G55#5?~^^^!Y&GGBB##B@P~:!BB!^~7JP    
?#@B7:....::::::::.....::^~77JJ7!7?YPGBB##BBBBBGGPJ7^..:!YPPGGGP5JY5G&#57~~^^^7G#5PY!!5&J::~GG^...:~    
Y@@P~........::::........:^!!:..::^!7JY5P55YJJJ?!^.  :!J5PGGBBBG5YY5PBGBGPJ7!!!JBBJY7YBG~.:~BG?!^..:    
G@@&5~:..................:^~7Y:      ..:::^:...    .~JY5PGGGBBGP5Y5PGGGGGGBGJ^~JG&Y7!P#J^...^?5#~...    
@&#GPP5~:... .........:::^~!::7:                 :~?Y5PGGGGBBBGGGPPGBBBBBBBG7. :?#G?75&?:   .:JG~::.    
?^::^!G!:.......::^^^^^^^^^.  ~?^:::.        ..~!7J555PGGBBBBBBBBGBB#####BJ:    .^~7Y&G!..:...^P#7:.    
~..:~Y7:...:::^^^::..    .   . ?J~^^:..::::^^~~!7?Y55PGGGBBBBBBBBB###&&G7.      ....~B57^:!?^.:5&#J^    
^.:7PY!...:^~~:.        .!   . :P7^^^^^~7777????JY55PGGGGGGGGBBBB###BY~.     .....  .:^^!!~7J?!7BG5G    
YY77~^:.::^^:          :~:  ..  PP!~~~!7?JJYYYY5PPPGGGGGGGGGBBB##B5!.      ...       .  .:!5Y?PYP#5G    
P~...:^^^:..  .:.     .!:.  ..  :5J~~~~7?JYYYY55PPGGPPPGGGGBBBBY~.       ....        .    .:~7YPB&5!    
]]
end