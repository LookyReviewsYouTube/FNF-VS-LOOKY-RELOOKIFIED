function onCreatePost()
    if modchart then
        setProperty("camHUD.alpha", 0)
        setProperty("cpuControlled", true)
    end

    setupMods()

    setupStart()

    setupEvents()
end

function setupStart()
    setMod("bfStealth", 1)
    setMod("opStealth", 1)
    setMod("middle", 1)
end

function setupMods()
    -- bf
    startMod("bfStealth", "StealthModifier", "player", -1)
    startMod("bfXModifier", "XModifier", "player", -1)
    startMod("bfTipsy", "TipsyYModifier", "player", -1)
    startMod("bfDrunk", "DrunkYModifier", "player", -1)
    startMod("bfReNote", "ReverseNotesModifier", "player", -1)
    startMod("bfShrink", "ShrinkModifier", "player", -1)
    startMod("bfSudden", "SuddenModifier", "player", -1)
    startMod("bfFlip", "FlipModifier", "player", -1)
    startMod("bfAngle", "ConfusionModifier", "player", -1)
    startMod("bfNotes", "NotesModifier", "player", -1)
    -- op
    startMod("opStealth", "StealthModifier", "opponent", -1)
    startMod("opX", "XModifier", "opponent", -1)
    startMod("opY", "YDModifier", "opponent", -1)
    startMod("opZ", "ZModifier", "opponent", -1)
    startMod("opShake", "ShakeNotesModifier", "opponent", -1)
    startMod("opStrumAngle", "StrumAngleModifier", "opponent", -1)
    startMod("opSkewX", "SkewXModifier", "opponent", -1)
    startMod("opOpSwap", "SwapPlayfieldModifier", "opponent", -1)
    startMod("opLine", "StrumLineRotateModifier", "opponent", -1)
    startMod("opRe", "ReverseModifier", "opponent", -1)
    startMod("opFlip", "FlipModifier", "opponent", -1)
    startMod("opShrink", "ShrinkModifier", "opponent", -1)
    startMod("opInvert", "InvertModifier", "opponent", -1)
    startMod("opSudden", "SuddenModifier", "opponent", -1)
    -- both
    startMod("middle", "MiddleModifier", "", -1)
    startMod("beatX", "BeatXModifier", "", -1)
end

function setupEvents()

    set(64, "0, bfStealth")
    for beat = 0, (4 * 16) - 1 do
        local time = 64 + beat
        local inten = (beat % 4 == 0 and 1 or -1)

        set(time, [[
            ]] .. 2 * inten .. [[, bfTipsy,
            ]] .. 2 * inten .. [[, bfDrunk,
            ]] .. 100 * inten .. [[, bfXModifier
        ]])

        ease(time, 1, "circOut", [[
            0, bfTipsy,
            0, bfDrunk,
            0, bfXModifier
        ]])
    end
    ease(128, 4, "quadOut", [[
        0, opStealth,
        0, middle
    ]])

    set(192, "2, beatX")
    ease(255, 1, "circOut", "0, beatX")
    ease(256, 1, "circOut", [[
        0.5, bfReNote, 
        -1, bfShrink, 
        1, bfSudden, 
        4.5, bfSudden:offset
    ]])
    ease(256, 0.5, "circOut", "0.5, opOpSwap, 1, bfStealth")
    coolVisual(256, true)

    if downscroll then
        ease(269, 2, "circOut", "-200, bfStrums:y,  -200, bfNotes:y")
        ease(272, 2, "circOut", "-720, bfStrums:y, 0, bfNotes:y")
    else
        ease(269, 2, "circOut", "300, bfStrums:y, 300, bfNotes:y")
        ease(272, 2, "circOut", "720, bfStrums:y, 0, bfNotes:y")
    end
    
    set(269, "0, bfReNote, 0, bfSudden, 0, bfShrink")
    set(272, "0.5, bfReNote, 1, bfSudden, -1, bfShrink")
    set(278, "0, bfReNote, 0, bfSudden, 0, bfShrink")
    ease(278, 2, "circOut", "200, bfNotes:yD")
    ease(279, 2, "quadOut", "0, bfNotes:yD, 0, bfStrums:y")

    set(256, "20, opShake, 20, opWiggle, 400, opX, -30, opLine:y")
    ease(256, 2, "quartOut", "0, opShake, 0, opWiggle, 0, opX, 0, opLine:y")
    coolVisual(256, false)

    set(260.5, "40, opShake")
    ease(260.5 + 0.5, 0.1, "quartOut", "0, opShake")

    ease(263, 0.5, "quartOut", "20, opShake, -10, opWiggle, -200, opX, 25, opLine:y")
    ease(263 + 0.5, 0.5, "quartOut", "0, opShake, 0, opWiggle, 0, opX, 0, opLine:y")

    ease(264, 0.1, "quartOut", "40, opShake, -40, opWiggle, 200, opX, -30, opLine:y")
    ease(265 + 0.1, 0.5, "quartOut", "0, opShake, 0, opWiggle, 0, opX, 0, opLine:y")

    set(266, "20, opStrumAngle, 20, opShake, 20, opWiggle")
    ease(266, 1, "quartOut", "0, opStrumAngle, 0, opShake, 0, opWiggle")

    ease(270, 0.5, "quartIn", "0.2, opRe, -2, opShrink, 40, opShake, 2, opParra, 1, opSudden, 4.5, opSudden:offset")
    ease(270 + 2, 2, "quartOut", "0, opRe, 0, opShrink, 0, opShake, 0, opParra, 0, opSudden")

    ease(276.5, 1, "quartOut", "1, opRe, 180, opStrumAngle")
    ease(278, 1, "quartOut", "0, opRe")
    ease(278.5, 1, "circOut", "0, opStrumAngle")

    ease(277, 0.5, "quartOut", "1, opInvert")
    ease(277 + 0.5, 0.5, "quartOut", "0, opInvert, 1, opFlip")
    ease(277 + 1, 0.5, "quartOut", "0, opFlip")

    ease(281, 0.5, "quartOut", "1, opInvert")
    ease(281 + 0.5, 0.5, "quartOut", "0, opInvert, 1, opFlip")
    ease(281 + 1, 0.5, "quartOut", "0, opFlip")

    ease(283, 0.2, "circOut", "200, opParra")
    ease(283 + 0.2, 1, "circOut", "0, opParra")

    ease(286, 0.2, "circOut", "2, opParra, 200, opX, 320, opY, -90, opStrumAngle")
    ease(286 + 2, 1, "circOut", "0, opParra, 0, opX, 0, opY, 0, opStrumAngle")

    ease(288, 0.5, "circOut", "1, opFlip")
    ease(288 + 0.5, 0.5, "quartOut", "1, opRe, 1, opInvert, 0, opFlip")
    ease(288 + 1, 0.5, "circOut", "0, opRe, 0, opInvert")

    ease(291, 0.5, "quartOut", "1, opInvert")
    ease(291 + 0.5, 0.5, "quartOut", "0, opInvert, 1, opFlip")
    ease(291 + 1, 0.5, "quartOut", "0, opFlip")

    ease(295, 2, "quartOut", "100, opskewFieldX")
    ease(297, 2, "circOut", "0, opskewFieldX")
end

function onBeatHit()
    if curBeat == 64 then
        cameraFlash("other", "0xFFFFFF", 1)
        setProperty("camHUD.alpha", 1)
    end
end

function coolVisual(beat, value)
    if value == true then
        if downscroll then
            ease(beat, 0.5, "circOut", [[
                4, bfStrumTipsy,
                -0.25, bfFlip
            ]])
            ease(beat + 0.5, 0.5, "quadOut", "0, bfStrumTipsy, 0, bfFlip")
            ease(beat, 4, "circIn", "-720, bfStrums:y")
        else
            ease(beat, 0.5, "circOut", [[
                -4, bfStrumTipsy,
                -0.25, bfFlip
            ]])
            ease(beat + 0.5, 4, "quadOut", "0, bfStrumTipsy, 0, bfFlip")
            ease(beat, 4, "circIn", "720, bfStrums:y")
        end
        ease(beat, 1, "circOut", "720, bfAngle")
        ease(beat + 1, "circIn", "0, bfAngle")
        set(beat + 5, "1, bfDarken")
    else
        ease(beat, 4, "circIn", "0, bfStrums:y")
        set(beat + 5, "0, bfDarken")
    end
end
