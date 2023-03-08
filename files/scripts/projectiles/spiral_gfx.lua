local pos_x, pos_y, rot = EntityGetTransform(GetUpdatedEntityID())


for i = 0, -10, -1 do
    local offset = math.sin((GameGetFrameNum() + GetUpdatedComponentID()) - i) * 4
    local wave = {
        x = offset + math.cos( rot ),
        y = math.sin( rot )
    }
    GameCreateCosmeticParticle( "spark", wave.x + pos_x, wave.y + pos_y, 1, 0, 0, 0xff0000ff, 5, 5, false, true, false, false)
end
