local pos_x, pos_y = EntityGetTransform(GetUpdatedEntityID())

local offsetList = {
    {-1, -1, 0xff0000ff},
    {0, 1, 0xff0000ff},
    {1, 1, 0xff0000ff},
    {-2, 0, 0xff0000ff},
    {-1, 0, 0xff0000ff},
    {0, 0, 0xffffef85},
    {1, 0, 0xffffef85},
    {-2, 1, 0xff0000ff},
    {-1, 1, 0xff0000ff},
    {0, 1, 0xff0000ff},
    {1, 1, 0xff0000ff},
    {-1, 2, 0xff0000ff},
    {1, 2, 0xff0000ff},
}

for i=1, #offsetList do
    GameCreateCosmeticParticle( "spark", math.floor(pos_x) + offsetList[i][1], math.floor(pos_y) + offsetList[i][2], 1, 0, 0, offsetList[i][3], 5, 5, false, true, false, false)
end