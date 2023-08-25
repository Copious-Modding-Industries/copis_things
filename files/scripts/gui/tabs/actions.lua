local function actions(gui, id_fn)
    dofile_once('data/scripts/gun/gun.lua')

    -- Lookup table of spells
    ActionsIndexed = ActionsIndexed or ( function (spells)
            local indexed = {}
            for i = 1, #spells do
                indexed[spells[i].id] = spells[i]
            end
            return indexed
        end
    )(actions)

    -- Alphabetical list of spell categories
    Alphabetical = Alphabetical or (function (spells)
        local sorted = {}
        for i = 1, #spells do
            local letter = (GameTextGetTranslatedOrNot(spells[i].name):sub(1,1):upper() or '?')
            sorted[letter][#sorted[letter]+1] = spells[i].id
        end
        return sorted
    end)(actions)

    for category, spells in pairs(Alphabetical) do
        for i=1,#spells do
            GuiImageButton(gui, id_fn(), 0, 0, '', ActionsIndexed[spells[i]].sprite)
        end
    end
end
return actions