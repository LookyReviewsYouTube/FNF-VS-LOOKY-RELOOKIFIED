-- bounceNotes.lua

local bounceHeight = 20      -- Pixels the notes will move up
local bounceSpeed = 0.15     -- Time it takes to go up/down
local bounceDelay = 0.01     -- Slight delay before resetting
local targetSong = 'kaiju-paradise'  -- Change to your song folder name!

local defaultY = {}

function onCreatePost()
    if songName ~= targetSong then return end

    -- Save the default Y positions of notes (0-7 = opponent + player)
    for i = 0, 7 do
        defaultY[i] = getPropertyFromGroup('strumLineNotes', i, 'y')
    end
end

function onBeatHit()
    if songName ~= targetSong then return end

    for i = 0, 7 do
        if defaultY[i] ~= nil then
            -- Move note up
            noteTweenY('noteUp'..i, i, defaultY[i] - bounceHeight, bounceSpeed, 'circOut')
            -- Reset note back down a moment later
            runTimer('noteReset'..i, bounceSpeed + bounceDelay)
        end
    end
end

function onTimerCompleted(tag)
    if songName ~= targetSong then return end

    for i = 0, 7 do
        if tag == 'noteReset'..i then
            noteTweenY('noteDown'..i, i, defaultY[i], bounceSpeed, 'circIn')
        end
    end
end
