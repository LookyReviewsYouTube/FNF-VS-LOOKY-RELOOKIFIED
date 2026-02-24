local modcharts = true
local defaultX = {}
local defaultY = {}
local switch = 1

function onSongStart()
    for strum = 0,7 do
        table.insert(defaultX, getPropertyFromGroup('strumLineNotes', strum, 'x'))
        table.insert(defaultY, getPropertyFromGroup('strumLineNotes', strum, 'y'))
    end
end

function onEvent(n, v1)
    if n == 'BassBounce' then
        switch = -switch
        local usealt = (v1 == '1') or (switch == -1)
        
        noteBounce('playerStrums', usealt)
        noteBounce('opponentStrums', usealt)
        
        for i = 0, 7 do
            noteTweenAngle('resetAng'..i, i, 0, 0.6, 'bounceOut')
            noteTweenY('resetY'..i, i, defaultY[i+1], 0.6, 'bounceOut')
        end
    end
end

function noteBounce(side, alt)
    local strumIDs = {
        ['playerStrums'] = {0, 1, 2, 3},
        ['opponentStrums'] = {4, 5, 6, 7}
    }
    
    local notes = strumIDs[side]
    
    if alt then
        setPropertyFromGroup(side, 0, 'angle', 10)
        setPropertyFromGroup(side, 0, 'y', defaultY[notes[1]+1] - 20)
        
        setPropertyFromGroup(side, 1, 'angle', -10)
        setPropertyFromGroup(side, 1, 'y', defaultY[notes[2]+1] - 40)
        
        setPropertyFromGroup(side, 2, 'angle', 10)
        setPropertyFromGroup(side, 2, 'y', defaultY[notes[3]+1] - 40)
        
        setPropertyFromGroup(side, 3, 'angle', -10)
        setPropertyFromGroup(side, 3, 'y', defaultY[notes[4]+1] - 20)
    else
        setPropertyFromGroup(side, 0, 'angle', -10)
        setPropertyFromGroup(side, 0, 'y', defaultY[notes[1]+1] - 20)
        
        setPropertyFromGroup(side, 1, 'angle', 10)
        setPropertyFromGroup(side, 1, 'y', defaultY[notes[2]+1] - 40)
        
        setPropertyFromGroup(side, 2, 'angle', -10)
        setPropertyFromGroup(side, 2, 'y', defaultY[notes[3]+1] - 40)
        
        setPropertyFromGroup(side, 3, 'angle', 10)
        setPropertyFromGroup(side, 3, 'y', defaultY[notes[4]+1] - 20)
    end
end