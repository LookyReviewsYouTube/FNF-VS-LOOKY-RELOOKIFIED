local universe = false
function onCreatePost()
    -- debugging bugs
    luaDebugMode = true

    -- offset bingo
    setProperty("boyfriend.y", getProperty("boyfriend.y") + 80)
    setProperty("boyfriend.x", getProperty("boyfriend.x") - 180)

    -- hide gf
    setProperty("gf.visible", false)

    -- preload shit
    timebartextlol()
    thatonebgspritething()
    credicetextshoot()
    crediceimageshoot()
    countDownPRELOAD()
    lightThingPRELOAD()
    camFadePRELOAD()

    -- white bg haha
    makeLuaSprite('whitebgwoah', nil, 0, 0);
    makeGraphic('whitebgwoah', 5000, 2000, "FFFFFF")
    screenCenter('whitebgwoah')
    addLuaSprite('whitebgwoah', false);
    setProperty('whitebgwoah.alpha', 0)

    -- speakerbox
    removeLuaSprite("speakerbox")

    makeAnimatedLuaSprite('speakerbox', 'bg/speaker_bluey', 0, 240);
    addAnimationByPrefix('speakerbox', 'first', 'speaker beat', 15, false);
    setScrollFactor('speakerbox', 0.9, 0.9);
    addLuaSprite('speakerbox', false);

    -- particle
    runHaxeCode([[
        setVar('particleAmount', 0);
        setVar('particleSpeed', 0);
        setVar('showMode', false);
    ]])

    setProperty('particleAmount', 0)
    setProperty('particleSpeed', 0)

    -- hud
    setProperty('timeBar.scale.x', 3.26)
    setTimeBarColors("FF0000", "000000")
    setProperty('timeBar.y', getProperty('timeBar.y') + 25)
    if not downscroll then
        setProperty('timeBar.y', getProperty('timeBar.y') - 60)
        setProperty('NDtimeTxt.y', 10)
    end
    setProperty('timeTxt.visible', false)
    setTextFont('scoreTxt', 'funkin.ttf')
    setObjectCamera('timeTxt', 'other')
    setObjectCamera('timeBar', 'other')

    if universeEngine then
        modchart()
    end
end

function onStepHit()
    if ((curStep == 272) or (curStep == 1696)) then
        cameraFlash("other", "FFFFFF", 1, true)
    end

    if curStep == 1696 then
        middleModifier(1, 2)
    end

    coolThing()
    startCamBeat()
end

valang = 5
durang = 2
duralpha321go = 0.25
local smallcambeat = false
function onBeatHit()
    -- funny speakerbox beat :3
    if curBeat % 1 == 0 then
        playAnim('speakerbox', 'first');
    end

    -- the actual visuals
    if ((curBeat >= 68 and curBeat < 164) or (curBeat >= 196 and curBeat < 260)) then
        if curBeat % 4 == 0 then
            triggerEvent("Add Camera Zoom", "0.030", "0.075")
            -- camAngle(valang, durang)
        end

        if curBeat % 8 == 0 then
            -- camAngle(-valang, durang)
        end

        if curBeat % 2 == 0 then
            activateBothNotesEvent(1, 2, 2, 2)
        end

        if smallcambeat then
            triggerEvent("Add Camera Zoom", "0.005", "0.01")
        else
            triggerEvent("Add Camera Zoom")
        end

        if curBeat == 68 then
            visibleHud(false)
            setProperty('yard.visible', false)
            setProperty('speakerbox.x', getProperty('speakerbox.x') + 250)
            setProperty('speakerbox.y', getProperty('speakerbox.y') + 200)

            setProperty('boyfriend.x', getProperty('boyfriend.x') + 200)
            setProperty('dad.x', getProperty('dad.x') - 200)

            setObjectCamera("scoreTxt", "camGame")
            setProperty('scoreTxt.y', getProperty('speakerbox.y') - 50)
            setProperty('scoreTxt.x', getProperty('speakerbox.x') - 500)
            setScrollFactor("scoreTxt", 0.9, 0.9)

            setProperty('healthBar.visible', false)
            setProperty('healthBarBG.visible', false)
            setProperty('iconP1.visible', false)
            setProperty('iconP2.visible', false)
        end
    end

    if ((curBeat >= 68 and curBeat < 99)) then
        if curBeat % 4 == 0 then
            lightThing("nbland")
        end
    end

    if ((curBeat >= 99 and curBeat < 164) or (curBeat >= 196 and curBeat < 260)) then
        lightThing("nbland")
    end

    if curBeat == 96 then
        playSound("intro3")
        createBackParticle(50, 1)
        lightThing("nbland")
    end
    if curBeat == 97 then
        playSound("intro2")
        setProperty("readyH.alpha", 1)
        doTweenAlpha("readyH A", "readyH", 0, duralpha321go, "linear")

        createBackParticle(50, 1)
        lightThing("nbland")
    end
    if curBeat == 98 then
        playSound("intro1")
        setProperty("setH.alpha", 1)
        doTweenAlpha("setH A", "setH", 0, duralpha321go, "linear")

        cancelTween("readyH A")
        setProperty("readyH.alpha", 0)

        createBackParticle(50, 1)
        lightThing("nbland")
    end
    if curBeat == 99 then
        playSound("introGo")
        setProperty("goH.alpha", 1)
        doTweenAlpha("goH A", "goH", 0, duralpha321go, "linear")

        cancelTween("setH A")
        setProperty("setH.alpha", 0)

        createBackParticle(50, 1)
        lightThing("nbland")
    end

    if ((curBeat >= 360 and curBeat < 488)) then
        if curBeat % 2 == 0 then
            activateBothNotesEvent(1, 2, 2, 2)
        end

        createBackParticle(10, 1)
        triggerEvent("Add Camera Zoom")
        if curBeat % 4 == 0 then
            camAngle(valang, durang)
            lightThing("nbland")
        end
        if curBeat % 8 == 0 then
            camAngle(-valang, durang)
        end
    end

    -- particle
    if ((curBeat >= 68 and curBeat < 260)) then
        if curBeat % 4 == 0 then
            createBackParticle(50, 1)
        end
    end

    if curBeat == 32 then
        createBackParticle(50, 2.5)
    end
    if curBeat == 68 then
        createBackParticle(100, 5)
    end
    if curBeat == 164 then
        createBackParticle(50, 5)
    end
    if curBeat == 196 then
        createBackParticle(50, 5)
    end
    if curBeat == 228 then
        createBackParticle(50, 5)
    end

    -- woah.
    if curBeat == 292 then
        setProperty('whitebgwoah.alpha', 1)

        setProperty('boyfriend.color', getColorFromHex("000000"))
        setProperty('dad.color', getColorFromHex("000000"))
        setProperty('speakerbox.color', getColorFromHex("000000"))

        setProperty('lightbottom.visible', false)
        setProperty('lightbottom2.visible', false)
        setProperty('lightbottom3.visible', false)
        setProperty('lightbottom4.visible', false)

        -- reverseModifier(1)
    end

    if curBeat == 360 then
        setProperty('whitebgwoah.alpha', 0)

        setProperty('boyfriend.color', getColorFromHex("FFFFFF"))
        setProperty('dad.color', getColorFromHex("FFFFFF"))
        setProperty('speakerbox.color', getColorFromHex("FFFFFF"))

        setProperty('lightbottom.visible', true)
        setProperty('lightbottom2.visible', true)
        setProperty('lightbottom3.visible', true)
        setProperty('lightbottom4.visible', true)

        -- reverseModifier(2)
    end
end

function onSongStart()
    credicealphashow()
    createBackParticle(100, 5)

    -- ue shit
    if universe then
        setProperty("UE song name popup.y", getProperty("UE song name popup.y") - 150)
        setProperty("UE info 1.y", getProperty("UE song name popup.y") - 150)
        setProperty("UE info 2.y", getProperty("UE song name popup.y") - 150)
    end
end

function onGameOver()
    if curBeat >= 68 then
        return Function_Stop
    end
end

function onPause()
    if curStep >= 1968 then
        return Function_Stop
    end
end

local nohityet = true
function goodNoteHit()
    if nohityet then
        credicealphahide()
        nohityet = false
    end
end

local uwenhudtype = false
local camhudv = false
local bpt = true
local followcamgame = false
function onUpdate(elapsed)
    if keyboardJustPressed("ONE") then
        if camhudv == false then
            setProperty('camHUD.visible', false)
            debugPrint('camHUD.visible = false')
            camhudv = true
        else
            setProperty('camHUD.visible', true)
            debugPrint('camHUD.visible = true')
            camhudv = false
        end
    end
    if keyboardJustPressed("TWO") then
        if bpt == false then
            setProperty('cpuControlled', false)
            debugPrint('cpuControlled = false')
            bpt = true
        else
            setProperty('cpuControlled', true)
            debugPrint('cpuControlled = true')
            bpt = false
        end
    end
    if followcamgame == true then
        setProperty('camHUD.zoom', getProperty('camGame.zoom'))
        if keyboardJustPressed("THREE") then
            followcamgame = false
            debugPrint('followCamGame = false')
        end
    else
        if keyboardJustPressed("THREE") then
            followcamgame = true
            debugPrint('followCamGame = true')
        end
    end

    setTextString('NDtimeTxt', formatTime(getSongPosition() - noteOffset) .. ' - ' .. formatTime(songLength))
    setProperty('NDtimeTxt.alpha', getProperty('timeBar.alpha'))

    if uwenhudtype == false then
        if hits < 1 then
            setTextString("scoreTxt", "Score: 0 / Screw-ups: 0 / Rating: ?")
        end
        if hits > 1 then
            setTextString("scoreTxt",
                "Score: " .. score .. " / Screw-ups: " .. misses .. " / Rating: " .. getProperty('ratingName') .. " (" ..
                    round(rating * 100, 2) .. "%) - " .. getProperty("ratingFC"))
        end
    else
        if hits < 1 then
            setTextString("scoreTxt", "Score: 0\nScrew-ups: 0\nRating: ?")
        end
        if hits > 1 then
            setTextString("scoreTxt",
                "Score: " .. score .. "\nScrew-ups: " .. misses .. "\nRating: " .. getProperty('ratingName') .. " (" ..
                    round(rating * 100, 2) .. "%) - " .. getProperty("ratingFC"))
        end
    end

    -- cool camhud shit lmao
    if ((curStep >= 272 and curStep < 656) or (curStep >= 784 and curStep < 1040)) then
        setProperty("camHUD.angle", continuous_sin(curDecStep / 16) * 5)
        if ((curStep == 656) or (curStep == 1040)) then
            setProperty("camHUD.angle", 0)
        end
    end
    if ((curStep >= 1168 and curStep < 1424) or (curStep >= 1696 and curStep < 1952)) then
        setProperty("camHUD.angle", continuous_sin(curDecStep / 16) * 5)
        setProperty("camHUD.x", continuous_sin(curDecStep / 16) * 50)
        if curStep == 1424 then
            setProperty('camHUD.angle', 0)
            setProperty('camHUD.x', 0)
        end
        if curStep == 1952 then
            doTweenX("camHudReturn X", "camHUD", 0, 4, "expoOut")
            doTweenX("camHudReturn ANG", "camHUD", 0, 4, "expoOut")
        end
    end
end

-- custom funcs
function round(x, n) -- https://stackoverflow.com/questions/18313171/lua-rounding-numbers-and-then-truncate
    n = math.pow(10, n or 0)
    x = x * n
    if x >= 0 then
        x = math.floor(x + 0.5)
    else
        x = math.ceil(x - 0.5)
    end
    return x / n
end

function credicealphahide()
    doTweenAlpha("credice BG bye", "credice BG", 0, 1, "linear")

    doTweenAlpha("credice bye", "credice", 0, 1, "linear")
    -- Text People
    doTweenAlpha("credice uwenalil bye", "credice uwenalil", 0, 1, "linear")
    doTweenAlpha("credice baran bye", "credice baran", 0, 1, "linear")
    doTweenAlpha("credice videobot bye", "credice videobot", 0, 1, "linear")
    doTweenAlpha("credice Ammar bye", "credice Ammar", 0, 1, "linear")
    doTweenAlpha("credice VsImposter bye", "credice VsImposter", 0, 1, "linear")
    doTweenAlpha("credice Jazty bye", "credice Jazty", 0, 1, "linear")
    doTweenAlpha("credice dev bye", "credice dev", 0, 1, "linear")

    -- Image People
    doTweenAlpha("credice uwenalil image hi", "credice uwenalil image", 0, 1, "linear")
    doTweenAlpha("credice baran image bye", "credice baran image", 0, 1, "linear")
    doTweenAlpha("credice videobot image bye", "credice videobot image", 0, 1, "linear")
    doTweenAlpha("credice Ammar image bye", "credice Ammar image", 0, 1, "linear")
    doTweenAlpha("credice dev image bye", "credice dev image", 0, 1, "linear")
end

function credicealphashow()
    doTweenAlpha("credice BG hi", "credice BG", 0.5, 1, "linear")

    doTweenAlpha("credice hi", "credice", 1, 1, "linear")
    -- Text people
    doTweenAlpha("credice uwenalil hi", "credice uwenalil", 1, 1, "linear")
    doTweenAlpha("credice baran hi", "credice baran", 1, 1, "linear")
    doTweenAlpha("credice videobot hi", "credice videobot", 1, 1, "linear")
    doTweenAlpha("credice Ammar hi", "credice Ammar", 1, 1, "linear")
    doTweenAlpha("credice VsImposter hi", "credice VsImposter", 1, 1, "linear")
    doTweenAlpha("credice Jazty hi", "credice Jazty", 1, 1, "linear")
    doTweenAlpha("credice dev hi", "credice dev", 1, 1, "linear")

    -- Image people
    doTweenAlpha("credice uwenalil image hi", "credice uwenalil image", 1, 1, "linear")
    doTweenAlpha("credice baran image hi", "credice baran image", 1, 1, "linear")
    doTweenAlpha("credice videobot image hi", "credice videobot image", 1, 1, "linear")
    doTweenAlpha("credice Ammar image hi", "credice Ammar image", 1, 1, "linear")
    doTweenAlpha("credice dev image hi", "credice dev image", 1, 1, "linear")
end

font = "funkin.ttf"
camthing = "other"
spacing = 60
function credicetextshoot()
    makeLuaText("credice", "", 1000, 0.0, 0.0)
    setTextSize("credice", 41)
    addLuaText("credice")
    setTextFont("credice", font)
    setProperty("credice.alpha", 0)
    setTextAlignment("credice", "left")
    setTextString("credice", "> CREDITS - NO DEFEAT <")
    -- screenCenter("credice")
    setProperty('credice.x', 60)
    setProperty('credice.y', 120)
    setObjectCamera('credice', camthing)

    makeLuaText("credice uwenalil", "", 1000, 0.0, 0.0)
    setTextSize("credice uwenalil", 21)
    addLuaText("credice uwenalil")
    setTextFont("credice uwenalil", font)
    setProperty("credice uwenalil.alpha", 0)
    setTextAlignment("credice uwenalil", "left")
    setTextString("credice uwenalil", "uwenalil\nCoding, Events, Charting, Stage")
    screenCenter("credice uwenalil")
    setProperty('credice uwenalil.x', getProperty('credice.x') + 80)
    setProperty('credice uwenalil.y', getProperty('credice.y') + 80)
    setObjectCamera('credice uwenalil', camthing)

    makeLuaText("credice baran", "", 1000, 0.0, 0.0)
    setTextSize("credice baran", 21)
    addLuaText("credice baran")
    setTextFont("credice baran", font)
    setProperty("credice baran.alpha", 0)
    setTextAlignment("credice baran", "left")
    setTextString("credice baran", "BaranMuzu\nCharting")
    screenCenter("credice baran")
    setProperty('credice baran.x', getProperty('credice.x') + 80)
    setProperty('credice baran.y', getProperty('credice.y') + 80 + spacing)
    setObjectCamera('credice baran', camthing)

    makeLuaText("credice videobot", "", 1000, 0.0, 0.0)
    setTextSize("credice videobot", 21)
    addLuaText("credice videobot")
    setTextFont("credice videobot", font)
    setProperty("credice videobot.alpha", 0)
    setTextAlignment("credice videobot", "left")
    setTextString("credice videobot", "Videobot\nHelper")
    screenCenter("credice videobot")
    setProperty('credice videobot.x', getProperty('credice.x') + 80)
    setProperty('credice videobot.y', getProperty('credice.y') + 80 + spacing + spacing)
    setObjectCamera('credice videobot', camthing)

    makeLuaText("credice Ammar", "", 1000, 0.0, 0.0)
    setTextSize("credice Ammar", 21)
    addLuaText("credice Ammar")
    setTextFont("credice Ammar", font)
    setProperty("credice Ammar.alpha", 0)
    setTextAlignment("credice Ammar", "left")
    setTextString("credice Ammar", "An Ammar\nDefeat Mix, Particle Script, CamHUD moving")
    screenCenter("credice Ammar")
    setProperty('credice Ammar.x', getProperty('credice.x') + 80)
    setProperty('credice Ammar.y', getProperty('credice.y') + 80 + spacing + spacing + spacing)
    setObjectCamera('credice Ammar', camthing)

    makeLuaText("credice dev", "", 1000, 0.0, 0.0)
    setTextSize("credice dev", 21)
    addLuaText("credice dev")
    setTextFont("credice dev", font)
    setProperty("credice dev.alpha", 0)
    setTextAlignment("credice dev", "left")
    setTextString("credice dev", "Dev_ (and his team)\nBluey and Bingo Chromatics and Custom Time Text")
    screenCenter("credice dev")
    setProperty('credice dev.x', getProperty('credice.x') + 80)
    setProperty('credice dev.y', getProperty('credice.y') + 80 + spacing + spacing + spacing + spacing)
    setObjectCamera('credice dev', camthing)

    makeLuaText("credice Jazty", "", 1000, 0.0, 0.0)
    setTextSize("credice Jazty", 21)
    addLuaText("credice Jazty")
    setTextFont("credice Jazty", font)
    setProperty("credice Jazty.alpha", 0)
    setTextAlignment("credice Jazty", "left")
    setTextString("credice Jazty", "Jazty\nCover")
    screenCenter("credice Jazty")
    setProperty('credice Jazty.x', getProperty('credice.x') + 80 - 80)
    setProperty('credice Jazty.y', getProperty('credice.y') + 80 + spacing + spacing + spacing + spacing + spacing)
    setObjectCamera('credice Jazty', camthing)

    makeLuaText("credice VsImposter", "", 1000, 0.0, 0.0)
    setTextSize("credice VsImposter", 21)
    addLuaText("credice VsImposter")
    setTextFont("credice VsImposter", font)
    setProperty("credice VsImposter.alpha", 0)
    setTextAlignment("credice VsImposter", "left")
    setTextString("credice VsImposter", "Vs Imposter V4\nOriginal Song")
    screenCenter("credice VsImposter")
    setProperty('credice VsImposter.x', getProperty('credice.x') + 80 - 80)
    setProperty('credice VsImposter.y',
        getProperty('credice.y') + 80 + spacing + spacing + spacing + spacing + spacing + spacing)
    setObjectCamera('credice VsImposter', camthing)
end

spacingimgy = -50
spacingimgx = -120
function crediceimageshoot()
    -- precache
    precacheImage("credits/uwenalil")
    precacheImage("credits/baranmuzu")
    precacheImage("credits/videobot")
    precacheImage("credits/Ammar")
    precacheImage("credits/dev")

    makeLuaSprite("credice uwenalil image", "credits/uwenalil", 0, 0)
    addLuaSprite("credice uwenalil image")
    setProperty("credice uwenalil image.alpha", 0)
    setProperty("credice uwenalil image.x", getProperty("credice uwenalil.x") + spacingimgx)
    setProperty('credice uwenalil image.scale.x', 0.6)
    setProperty('credice uwenalil image.scale.y', 0.6)
    setProperty("credice uwenalil image.y", getProperty("credice uwenalil.y") + spacingimgy)
    setObjectCamera("credice uwenalil image", camthing)

    makeLuaSprite("credice baran image", "credits/baranmuzu", 0, 0)
    addLuaSprite("credice baran image")
    setProperty("credice baran image.alpha", 0)
    setProperty("credice baran image.x", getProperty("credice baran.x") + spacingimgx - 5)
    setProperty('credice baran image.scale.x', 0.6)
    setProperty('credice baran image.scale.y', 0.6)
    setProperty("credice baran image.y", getProperty("credice baran.y") + spacingimgy + 5)
    setObjectCamera("credice baran image", camthing)

    makeLuaSprite("credice videobot image", "credits/videobot", 0, 0)
    addLuaSprite("credice videobot image")
    setProperty("credice videobot image.alpha", 0)
    setProperty("credice videobot image.x", getProperty("credice videobot.x") + spacingimgx - 5)
    setProperty('credice videobot image.scale.x', 0.5)
    setProperty('credice videobot image.scale.y', 0.5)
    setProperty("credice videobot image.y", getProperty("credice videobot.y") + spacingimgy + 10)
    setObjectCamera("credice videobot image", camthing)

    makeLuaSprite("credice Ammar image", "credits/Ammar", 0, 0)
    addLuaSprite("credice Ammar image")
    setProperty("credice Ammar image.alpha", 0)
    setProperty("credice Ammar image.x", getProperty("credice Ammar.x") + spacingimgx)
    setProperty('credice Ammar image.scale.x', 0.6)
    setProperty('credice Ammar image.scale.y', 0.6)
    setProperty("credice Ammar image.y", getProperty("credice Ammar.y") + spacingimgy)
    setObjectCamera("credice Ammar image", camthing)

    makeLuaSprite("credice dev image", "credits/dev", 0, 0)
    addLuaSprite("credice dev image")
    setProperty("credice dev image.alpha", 0)
    setProperty("credice dev image.x", getProperty("credice dev.x") + spacingimgx)
    setProperty('credice dev image.scale.x', 0.6)
    setProperty('credice dev image.scale.y', 0.6)
    setProperty("credice dev image.y", getProperty("credice dev.y") + spacingimgy)
    setObjectCamera("credice dev image", camthing)
end

function thatonebgspritething()
    makeLuaSprite("credice BG", nil, 0, 0)
    makeGraphic("credice BG", 720, screenHeight, "000000")
    screenCenter("credice BG")
    setProperty("credice BG.x", 30)
    setObjectCamera("credice BG", "camHud")
    setProperty('credice BG.alpha', 0)
    addLuaSprite("credice BG", false)
    setObjectCamera("credice BG", camthing)
end

function startCamBeat()
    -- SET 1
    -- DAD SIDE
    if ((curStep == 1) or (curStep == 2) or (curStep == 4) or (curStep == 6)) then
        triggerEvent("Add Camera Zoom", "", "")
        lightThing("bland")
        activateBothNotesEvent(1, 2, 2, 2)
        createBackParticle(5, 1)
    end

    if ((curStep == 16) or (curStep == 18) or (curStep == 20) or (curStep == 22)) then
        triggerEvent("Add Camera Zoom", "", "")
        lightThing("bland")
        activateBothNotesEvent(1, 2, 2, 2)
        createBackParticle(5, 1)
    end

    if ((curStep == 32) or (curStep == 34) or (curStep == 36) or (curStep == 38)) then
        triggerEvent("Add Camera Zoom", "", "")
        lightThing("bland")
        activateBothNotesEvent(1, 2, 2, 2)
        createBackParticle(5, 1)
    end

    if ((curStep == 48) or (curStep == 50) or (curStep == 52) or (curStep == 54)) then
        triggerEvent("Add Camera Zoom", "", "")
        lightThing("bland")
        activateBothNotesEvent(1, 2, 2, 2)
        createBackParticle(5, 1)
    end

    -- BF SIDE
    if ((curStep == 64) or (curStep == 66) or (curStep == 68) or (curStep == 70)) then
        triggerEvent("Add Camera Zoom", "", "")
        lightThing("bland")
        activateBothNotesEvent(1, 2, 2, 2)
        createBackParticle(5, 1)
    end

    if ((curStep == 80) or (curStep == 82) or (curStep == 84) or (curStep == 86)) then
        triggerEvent("Add Camera Zoom", "", "")
        lightThing("bland")
        activateBothNotesEvent(1, 2, 2, 2)
        createBackParticle(5, 1)
    end

    if ((curStep == 96) or (curStep == 98) or (curStep == 100) or (curStep == 102)) then
        triggerEvent("Add Camera Zoom", "", "")
        lightThing("bland")
        activateBothNotesEvent(1, 2, 2, 2)
        createBackParticle(5, 1)
    end

    if ((curStep == 112) or (curStep == 114) or (curStep == 116) or (curStep == 118)) then
        triggerEvent("Add Camera Zoom", "", "")
        lightThing("bland")
        activateBothNotesEvent(1, 2, 2, 2)
        createBackParticle(5, 1)
    end

    -- SET 2
    -- DAD SIDE
    if ((curStep == 128) or (curStep == 130) or (curStep == 132) or (curStep == 134)) then
        triggerEvent("Add Camera Zoom", "", "")
        lightThing("bland")
        activateBothNotesEvent(1, 2, 2, 2)
        createBackParticle(15, 1)
    end

    if ((curStep == 144) or (curStep == 146) or (curStep == 148) or (curStep == 150)) then
        triggerEvent("Add Camera Zoom", "", "")
        lightThing("bland")
        activateBothNotesEvent(1, 2, 2, 2)
        createBackParticle(15, 1)
    end

    if ((curStep == 160) or (curStep == 162) or (curStep == 164) or (curStep == 166)) then
        triggerEvent("Add Camera Zoom", "", "")
        lightThing("bland")
        activateBothNotesEvent(1, 2, 2, 2)
        createBackParticle(15, 1)
    end

    if ((curStep == 176) or (curStep == 178) or (curStep == 180) or (curStep == 182)) then
        triggerEvent("Add Camera Zoom", "", "")
        lightThing("bland")
        activateBothNotesEvent(1, 2, 2, 2)
        createBackParticle(15, 1)
    end

    -- BF SIDE
    if ((curStep == 192) or (curStep == 194) or (curStep == 196) or (curStep == 198)) then
        triggerEvent("Add Camera Zoom", "", "")
        lightThing("bland")
        activateBothNotesEvent(1, 2, 2, 2)
        createBackParticle(15, 1)
    end

    if ((curStep == 208) or (curStep == 210) or (curStep == 212) or (curStep == 214)) then
        triggerEvent("Add Camera Zoom", "", "")
        lightThing("bland")
        activateBothNotesEvent(1, 2, 2, 2)
        createBackParticle(15, 1)
    end

    if ((curStep == 224) or (curStep == 226) or (curStep == 228) or (curStep == 230)) then
        triggerEvent("Add Camera Zoom", "", "")
        lightThing("bland")
        activateBothNotesEvent(1, 2, 2, 2)
        createBackParticle(15, 1)
    end

    if ((curStep == 240) or (curStep == 242) or (curStep == 244) or (curStep == 246)) then
        triggerEvent("Add Camera Zoom", "", "")
        lightThing("bland")
        activateBothNotesEvent(1, 2, 2, 2)
        createBackParticle(15, 1)
    end

    -- FINAL SET
    if ((curStep == 256) or (curStep == 260) or (curStep == 264) or (curStep == 266) or (curStep == 268) or
        (curStep == 270)) then
        triggerEvent("Add Camera Zoom", "", "")
        lightThing("bland")
        activateBothNotesEvent(1, 2, 2, 2)
        createBackParticle(25, 1)
    end
end

function countDownPRELOAD()
    precacheImage("ready")
    precacheImage("set")
    precacheImage("go")

    makeLuaSprite("readyH", "ready", 757, 364)
    makeLuaSprite("setH", "set", 702, 322)
    makeLuaSprite("goH", "go", 558, 430)

    setObjectCamera("readyH", 'camHud')
    setObjectCamera("setH", 'camHud')
    setObjectCamera("goH", 'camHud')

    addLuaSprite("readyH", true)
    addLuaSprite("setH", true)
    addLuaSprite("goH", true)

    setProperty("readyH.alpha", 0)
    setProperty("setH.alpha", 0)
    setProperty("goH.alpha", 0)

    screenCenter("readyH")
    screenCenter("setH")
    screenCenter("goH")
end

function visibleHud(truefalse)
    if universe then
        -- ue hud
        setProperty("UEsong.visible", truefalse)
        setProperty("UEtimeTxt.visible", truefalse)
        setProperty("UEmiss.visible", truefalse)
        setProperty("UEscore.visible", truefalse)
        setProperty("UErating.visible", truefalse)

        -- ue combo counter
        -- setProperty("UE ratingTxt.visible", truefalse)
        -- setProperty("UE comboTxt.visible", truefalse)

        -- ue keystrokes
        setProperty("leftButton.visible", truefalse)
        setProperty("downButton.visible", truefalse)
        setProperty("upButton.visible", truefalse)
        setProperty("rightButton.visible", truefalse)
    end

    -- psych hud
    -- setProperty("scoreTxt.visible", truefalse)
    setProperty('showRating', truefalse);
    setProperty('showComboNum', truefalse);
    -- setProperty("timeBar.visible", truefalse)
    -- setProperty("timeTxt.visible", truefalse)
end

function camZoominoutfunc(v1)
    -- 0.6 default
    setProperty("defaultCamZoom", v1)
end

local dorotateonds = false
local imuage = false
local flipthing = false
local isaboveplayer = true
function lightThingPRELOAD()
    makeLuaSprite("lightbottom", "lightthing", 0, -120 + 200)
    setProperty('lightbottom.scale.x', 50)
    addLuaSprite("lightbottom", isaboveplayer)
    setObjectCamera("lightbottom", "camGame")
    setProperty("lightbottom.alpha", 0)
    setBlendMode("lightbottom", "add")

    makeLuaSprite("lightbottom2", "lightthing", 0, 600 + 200)
    setProperty('lightbottom2.scale.x', 50)
    setProperty('lightbottom2.angle', 180)
    addLuaSprite("lightbottom2", isaboveplayer)
    setObjectCamera("lightbottom2", "camGame")
    setProperty("lightbottom2.alpha", 0)
    setBlendMode("lightbottom2", "add")

    makeLuaSprite("lightbottom3", "lightthing", 0, -120 - 400)
    setProperty('lightbottom3.scale.x', 50)
    addLuaSprite("lightbottom3", isaboveplayer)
    setObjectCamera("lightbottom3", "camGame")
    setProperty("lightbottom3.alpha", 0)
    setBlendMode("lightbottom3", "add")

    makeLuaSprite("lightbottom4", "lightthing", 0, 600 - 400)
    setProperty('lightbottom4.scale.x', 50)
    setProperty('lightbottom4.angle', 180)
    addLuaSprite("lightbottom4", isaboveplayer)
    setObjectCamera("lightbottom4", "camGame")
    setProperty("lightbottom4.alpha", 0)
    setBlendMode("lightbottom4", "add")

    makeLuaSprite("lightbottom bland", "lightthing", 0, -120 + 200)
    setProperty('lightbottom bland.scale.x', 50)
    addLuaSprite("lightbottom bland", true)
    setObjectCamera("lightbottom bland", "other")
    setProperty("lightbottom bland.alpha", 0)
    setBlendMode("lightbottom bland", "add")

    --[[ DONT FUCKING USE THIS THING (OLD CODE)
    makeLuaSprite("lightbottom", "lightthing", 0, -120 + 200)
    setProperty('lightbottom.scale.x', 50)
    addLuaSprite("lightbottom", true)
    setObjectCamera("lightbottom", "other")
    setProperty("lightbottom.alpha", 0)

    if flipthing then
        setProperty("lightbottom.angle", 180)
    end

    if imuage then
        makeLuaSprite("lightbottom2", "lightthing", 0, 0)
        screenCenter("lightbottom2")
        addLuaSprite("lightbottom2", true)
        setObjectCamera("lightbottom2", "other")
        setProperty("lightbottom2.alpha", 0)
        setProperty("lightbottom2.angle", 180)
    end

    if dorotateonds and downscroll then
        setProperty("lightbottom.angle", 180)
    end
    ]]
end

--[[ DONT FUCKING USE THIS TOO (OLD CODE)
alphalight = 0.5
durlight = 0.5
local dofunky = false
local funkyrotate = false
local funkyfirststep = false -- leave this off
]]
alphathing = 0.75
durationthing = 1
local colorthing = false
function lightThing(v1)
    if v1 == "bland" then
        setProperty("lightbottom bland.alpha", 0.5)
        doTweenAlpha("lightbottom bland dissapear", "lightbottom bland", 0, 1, "linear")
    end

    if v1 == "nbland" then
        if colorthing == false then
            if curBeat == 99 then
                alphathing = 0.5
            end

            setProperty("lightbottom.alpha", alphathing)
            doTweenAlpha("lightbottom dissapear", "lightbottom", 0, durationthing, "linear")
            setProperty('lightbottom.color', getColorFromHex("419FFF"))

            setProperty("lightbottom2.alpha", alphathing)
            doTweenAlpha("lightbottom2 dissapear", "lightbottom2", 0, durationthing, "linear")
            setProperty('lightbottom2.color', getColorFromHex("419FFF"))

            setProperty("lightbottom3.alpha", alphathing)
            doTweenAlpha("lightbottom3 dissapear", "lightbottom3", 0, durationthing, "linear")
            setProperty('lightbottom3.color', getColorFromHex("FFB26F"))

            setProperty("lightbottom4.alpha", alphathing)
            doTweenAlpha("lightbottom4 dissapear", "lightbottom4", 0, durationthing, "linear")
            setProperty('lightbottom4.color', getColorFromHex("FFB26F"))
            colorthing = true
        else
            setProperty("lightbottom.alpha", alphathing)
            doTweenAlpha("lightbottom dissapear", "lightbottom", 0, durationthing, "linear")
            setProperty('lightbottom.color', getColorFromHex("FFB26F"))

            setProperty("lightbottom2.alpha", alphathing)
            doTweenAlpha("lightbottom2 dissapear", "lightbottom2", 0, durationthing, "linear")
            setProperty('lightbottom2.color', getColorFromHex("FFB26F"))

            setProperty("lightbottom3.alpha", alphathing)
            doTweenAlpha("lightbottom3 dissapear", "lightbottom3", 0, durationthing, "linear")
            setProperty('lightbottom3.color', getColorFromHex("419FFF"))

            setProperty("lightbottom4.alpha", alphathing)
            doTweenAlpha("lightbottom4 dissapear", "lightbottom4", 0, durationthing, "linear")
            setProperty('lightbottom4.color', getColorFromHex("419FFF"))
            colorthing = false
        end
    end

    --[[ AND DONT FUCKING USE THIS THING TOO (OLD CODE)
    setProperty("lightbottom.alpha", alpha)
    doTweenAlpha("lightbottom dissapear", "lightbottom", 0, duration, "linear")

    if imuage then
        setProperty("lightbottom2.alpha", alphalight)
        doTweenAlpha("lightbottom2 dissapear", "lightbottom2", 0, durlight, "linear")
    end

    if dofunky then
        if not funkyfirststep then
            setProperty("lightbottom.color", getColorFromHex("419FFF"))
            if imuage then
                setProperty("lightbottom2.color", getColorFromHex("419FFF"))
            end
            if funkyrotate then
                setProperty("lightbottom.angle", -180)
                if imuage then
                    setProperty("lightbottom2.angle", -180)
                end
            end
            funkyfirststep = true
        else
            setProperty("lightbottom.color", getColorFromHex("FFB26F"))
            if imuage then
                setProperty("lightbottom2.color", getColorFromHex("FFB26F"))
            end
            if funkyrotate then
                setProperty("lightbottom.angle", 0)
                if imuage then
                    setProperty("lightbottom2.angle", 0)
                end
            end
            funkyfirststep = false
        end
    end
    ]]
end

valang2 = 5 -- 5
durang2 = 2 -- 2
function coolThing()
    -- BEGINNING PART
    -- ZOOMING IN FIRST
    if curStep == 1 then
        camZoominoutfunc("0.8")
    end
    -- DAD SIDE
    if curStep == 128 then
        camZoominoutfunc("0.7")
    end
    if curStep == 170 then
        camZoominoutfunc("0.9")
    end
    if curStep == 176 then
        camZoominoutfunc("0.7")
    end
    if curStep == 184 then
        camZoominoutfunc("0.8")
    end
    -- BF SIDE
    if curStep == 192 then
        camZoominoutfunc("0.7")
    end
    if curStep == 234 then
        camZoominoutfunc("0.9")
    end
    if curStep == 240 then
        camZoominoutfunc("0.7")
    end
    if curStep == 252 then
        camZoominoutfunc("0.6")
    end
    if curStep == 256 then
        camZoominoutfunc("0.8")
    end
    -- ZOOM OUT BACK TO ORIGINAL
    if curStep == 272 then
        camZoominoutfunc("0.6")
    end

    -- 321go part
    if curStep == 384 then
        camZoominoutfunc("0.7")
    end
    if curStep == 388 then
        camZoominoutfunc("0.75")
    end
    if curStep == 392 then
        camZoominoutfunc("0.8")
    end
    if curStep == 396 then
        camZoominoutfunc("0.85")
    end

    -- SET 2
    -- DAD SIDE
    if curStep == 400 then
        camZoominoutfunc("0.6")
    end
    if curStep == 416 then
        camZoominoutfunc("0.7")
    end
    if curStep == 432 then
        camZoominoutfunc("0.6")
    end
    if curStep == 448 then
        camZoominoutfunc("0.8")
    end
    -- BF SIDE
    if curStep == 464 then
        camZoominoutfunc("0.6")
    end
    if curStep == 480 then
        camZoominoutfunc("0.7")
    end
    if curStep == 496 then
        camZoominoutfunc("0.6")
    end
    if curStep == 512 then
        camZoominoutfunc("0.8")
    end

    -- SET 3
    -- DAD SIDE
    if curStep == 528 then
        camZoominoutfunc("0.7")
    end
    if curStep == 544 then
        camZoominoutfunc("0.8")
    end
    if curStep == 560 then
        camZoominoutfunc("0.7")
    end
    if curStep == 576 then
        camZoominoutfunc("0.6")
    end

    -- BF SIDE
    if curStep == 592 then
        camZoominoutfunc("0.7")
    end
    if curStep == 608 then
        camZoominoutfunc("0.8")
    end
    if curStep == 624 then
        camZoominoutfunc("0.7")
    end
    if curStep == 640 then
        camZoominoutfunc("0.6")
    end

    -- SET 4
    -- DAD SIDE
    if curStep == 672 then
        camZoominoutfunc("0.75")
        lightThing("nbland")
        activateBothNotesEvent(1, 2, 2, 2)
    end
    if curStep == 678 then
        camZoominoutfunc("0.8")
        lightThing("nbland")
        activateBothNotesEvent(1, 2, 2, 2)
    end
    if curStep == 684 then
        camZoominoutfunc("0.75")
        lightThing("nbland")
        activateBothNotesEvent(1, 2, 2, 2)
    end
    if curStep == 692 then
        camZoominoutfunc("0.6")
    end
    if curStep == 704 then
        camZoominoutfunc("0.7")
        lightThing("nbland")
        activateBothNotesEvent(1, 2, 2, 2)
    end
    if curStep == 712 then
        camZoominoutfunc("0.6")
        lightThing("nbland")
        activateBothNotesEvent(1, 2, 2, 2)
    end

    -- BF SIDE
    if curStep == 736 then
        camZoominoutfunc("0.75")
        lightThing("nbland")
        activateBothNotesEvent(1, 2, 2, 2)
    end
    if curStep == 742 then
        camZoominoutfunc("0.8")
        lightThing("nbland")
        activateBothNotesEvent(1, 2, 2, 2)
    end
    if curStep == 748 then
        camZoominoutfunc("0.75")
        lightThing("nbland")
        activateBothNotesEvent(1, 2, 2, 2)
    end
    if curStep == 756 then
        camZoominoutfunc("0.6")
    end
    if curStep == 768 then
        camZoominoutfunc("0.75")
        lightThing("nbland")
        activateBothNotesEvent(1, 2, 2, 2)
    end
    if curStep == 776 then
        camZoominoutfunc("0.6")
        lightThing("nbland")
        activateBothNotesEvent(1, 2, 2, 2)
    end

    -- SET 5
    if curStep == 784 then
        camZoominoutfunc("0.7")
    end
    if curStep == 848 then
        camZoominoutfunc("0.8")
    end
    if curStep == 912 then
        camZoominoutfunc("0.7")
    end
    if curStep == 976 then
        camZoominoutfunc("0.8")
    end
    if curStep == 1040 then
        camZoominoutfunc("0.6")
        lightThing("nbland")
    end

    -- BREAK PART
    if curStep == 1088 then
        lightThing("nbland")
        camZoominoutfunc("0.7")
        activateBothNotesEvent(1, 2, 2, 2)

        camAngle(valang2, durang2)
        createBackParticle(25, 1)
    end
    if curStep == 1092 then
        lightThing("nbland")
        camZoominoutfunc("0.6")
        activateBothNotesEvent(1, 2, 2, 2)

        cancelTween("camHudANG")
        camAngle(-valang2, durang2)
        createBackParticle(25, 1)
    end
    if curStep == 1094 then
        lightThing("nbland")
        camZoominoutfunc("0.7")
        activateBothNotesEvent(1, 2, 2, 2)

        cancelTween("camHudANG")
        camAngle(valang2, durang2)
        createBackParticle(25, 1)
    end
    if curStep == 1098 then
        lightThing("nbland")
        camZoominoutfunc("0.6")
        activateBothNotesEvent(1, 2, 2, 2)

        cancelTween("camHudANG")
        camAngle(-valang2, durang2)
        createBackParticle(25, 1)
    end
    if curStep == 1100 then
        lightThing("nbland")
        camZoominoutfunc("0.7")
        activateBothNotesEvent(1, 2, 2, 2)

        cancelTween("camHudANG")
        camAngle(valang2, durang2)
        createBackParticle(25, 1)
    end
    if curStep == 1102 then
        lightThing("nbland")
        camZoominoutfunc("0.6")
        activateBothNotesEvent(1, 2, 2, 2)

        cancelTween("camHudANG")
        camAngle(-valang2, durang2)
        createBackParticle(25, 1)
    end
    if curStep == 1104 then
        lightThing("nbland")
        camZoominoutfunc("0.65")
        activateBothNotesEvent(1, 2, 2, 2)

        cancelTween("camHudANG")
        camAngle(valang2, durang2)
        createBackParticle(25, 1)
    end
    -- CAM FADE IN
    if curStep == 1152 then
        camFade('1', '1')
    end
    -- FADE OUT
    if curStep == 1168 then
        camFade('0', '1')
        camZoominoutfunc("0.8")
    end

    -- 1ST SET
    if ((curStep >= 1168 and curStep < 1296)) then
        if curStep % 8 == 0 then
            activateBothNotesEvent(1, 2, 2, 2)
        end
    end

    if curStep == 1224 then
        camZoominoutfunc(getProperty('defaultCamZoom') + 0.01)
        triggerEvent("Add Camera Zoom", "0.030", "0.075")
    end

    if ((curStep == 1216) or (curStep == 1222) or (curStep == 1228)) then
        activateBothNotesEvent(1, 2, 2, 2)
        camZoominoutfunc(getProperty('defaultCamZoom') + 0.01)
        triggerEvent("Add Camera Zoom", "0.030", "0.075")
    end

    if curStep == 1232 then
        camZoominoutfunc("0.8")
    end

    if curStep == 1288 then
        camZoominoutfunc(getProperty('defaultCamZoom') + 0.01)
        triggerEvent("Add Camera Zoom", "0.030", "0.075")
    end

    if ((curStep == 1280) or (curStep == 1286) or (curStep == 1292)) then
        activateBothNotesEvent(1, 2, 2, 2)
        camZoominoutfunc(getProperty('defaultCamZoom') + 0.01)
        triggerEvent("Add Camera Zoom", "0.030", "0.075")
    end

    if curStep == 1296 then
        camZoominoutfunc("0.6")
    end

    -- FINAL SET
    if ((curStep == 1296) or (curStep == 1306) or (curStep == 1312) or (curStep == 1318) or (curStep == 1324) or
        (curStep == 1328) or (curStep == 1338) or (curStep == 1344) or (curStep == 1350) or (curStep == 1356)) then
        activateBothNotesEvent(1, 2, 2, 2)
        camZoominoutfunc(getProperty('defaultCamZoom') + 0.01)
        triggerEvent("Add Camera Zoom", "0.030", "0.075")
    end

    if ((curStep == 1360) or (curStep == 1370) or (curStep == 1376) or (curStep == 1382) or (curStep == 1388) or
        (curStep == 1392) or (curStep == 1402) or (curStep == 1408) or (curStep == 1414) or (curStep == 1420)) then
        activateBothNotesEvent(1, 2, 2, 2)
        camZoominoutfunc(getProperty('defaultCamZoom') + 0.01)
        triggerEvent("Add Camera Zoom", "0.030", "0.075")
    end

    if ((curStep == 1424) or (curStep == 1428) or (curStep == 1432) or (curStep == 1434) or (curStep == 1436) or
        (curStep == 1438)) then
        activateBothNotesEvent(1, 2, 2, 2)
        camZoominoutfunc(getProperty('defaultCamZoom') + 0.01)
        triggerEvent("Add Camera Zoom", "0.030", "0.075")
    end

    -- 2ND LAST OF 1ST STEP
    -- DAD SIDE
    if curStep == 1440 then
        camZoominoutfunc("0.6")
        cameraFlash("other", "FFFFFF", 1, true)
    end
    if curStep == 1456 then
        camZoominoutfunc("0.7")
    end
    if curStep == 1472 then
        camZoominoutfunc("0.8")
    end
    if curStep == 1488 then
        camZoominoutfunc("0.9")
    end

    -- BF SIDE
    if curStep == 1504 then
        camZoominoutfunc("0.6")
    end
    if curStep == 1520 then
        camZoominoutfunc("0.7")
    end
    if curStep == 1536 then
        camZoominoutfunc("0.8")
    end
    if curStep == 1552 then
        camZoominoutfunc("0.9")
    end

    -- 2ND SET
    -- DAD SIDE
    if curStep == 1576 then
        camZoominoutfunc("0.7")
    end
    if curStep == 1579 then
        camZoominoutfunc("0.8")
    end
    if curStep == 1582 then
        camZoominoutfunc("0.9")
    end

    if curStep == 1592 then
        camZoominoutfunc("0.8")
    end
    if curStep == 1595 then
        camZoominoutfunc("0.7")
    end
    if curStep == 1598 then
        camZoominoutfunc("0.6")
    end

    if curStep == 1608 then
        camZoominoutfunc("0.7")
    end
    if curStep == 1611 then
        camZoominoutfunc("0.8")
    end
    if curStep == 1614 then
        camZoominoutfunc("0.9")
    end

    if curStep == 1624 then
        camZoominoutfunc("0.8")
    end
    if curStep == 1627 then
        camZoominoutfunc("0.7")
    end
    if curStep == 1630 then
        camZoominoutfunc("0.6")
    end

    -- BF SIDE
    if curStep == 1640 then
        camZoominoutfunc("0.7")
    end
    if curStep == 1643 then
        camZoominoutfunc("0.8")
    end
    if curStep == 1646 then
        camZoominoutfunc("0.9")
    end

    if curStep == 1656 then
        camZoominoutfunc("0.8")
    end
    if curStep == 1659 then
        camZoominoutfunc("0.7")
    end
    if curStep == 1662 then
        camZoominoutfunc("0.6")
    end

    if curStep == 1672 then
        camZoominoutfunc("0.7")
    end
    if curStep == 1675 then
        camZoominoutfunc("0.8")
    end
    if curStep == 1678 then
        camZoominoutfunc("0.9")
    end

    if curStep == 1688 then
        camZoominoutfunc("0.8")
    end
    if curStep == 1691 then
        camZoominoutfunc("0.7")
    end
    if curStep == 1694 then
        camZoominoutfunc("0.6")
    end

    -- FINAL 1ST SET
    -- DAD SIDE
    if curStep == 1696 then
        camZoominoutfunc("0.8")
    end
    if curStep == 1696 + 16 then
        camZoominoutfunc("0.9")
    end
    if curStep == 1696 + 16 + 16 then
        camZoominoutfunc("1")
    end
    if curStep == 1696 + 16 + 16 + 16 then
        camZoominoutfunc("0.9")
    end

    -- BF SIDE
    if curStep == 1760 then
        camZoominoutfunc("0.8")
    end
    if curStep == 1760 + 16 then
        camZoominoutfunc("0.9")
    end
    if curStep == 1760 + 16 + 16 then
        camZoominoutfunc("1")
    end
    if curStep == 1760 + 16 + 16 + 16 then
        camZoominoutfunc("0.9")
    end

    -- FINAL SET!!!
    if curStep == 1824 then
        camZoominoutfunc("0.8")
    end
    if curStep == 1824 + 16 then
        camZoominoutfunc("0.9")
    end
    if curStep == 1824 + 16 + 16 then
        camZoominoutfunc("1")
    end
    if curStep == 1824 + 16 + 16 + 16 then
        camZoominoutfunc("0.9")
    end
    if curStep == 1888 then
        camZoominoutfunc("0.8")
    end
    if curStep == 1888 + 16 then
        camZoominoutfunc("0.9")
    end
    if curStep == 1888 + 16 + 16 then
        camZoominoutfunc("1")
    end
    if curStep == 1888 + 16 + 16 + 16 then
        camZoominoutfunc("0.9")
    end

    if curStep == 1968 then
        cameraFade("other", "000000", 0.01, true)
    end
end

function camFadePRELOAD()
    makeLuaSprite("camFade", nil, 0, 0)
    makeGraphic("camFade", screenWidth, screenHeight, "FFFFFF")
    screenCenter("camFade")
    addLuaSprite("camFade", true)
    setObjectCamera("camFade", "other")
    setProperty("camFade.alpha", 0)
end

function camFade(v1, v2, v3)
    doTweenAlpha("camfido", "camFade", v1, v2, "linear")
end

function arrowBeatAng(v1)
    arrowbeatang = {10, 20, 30, 40, 50, -10, -20, -30, -40, -50}

    setPropertyFromGroup("opponentStrums", 0, "angle", arrowbeatang[getRandomInt(1, #arrowbeatang)])
    setPropertyFromGroup("opponentStrums", 1, "angle", arrowbeatang[getRandomInt(1, #arrowbeatang)])
    setPropertyFromGroup("opponentStrums", 2, "angle", arrowbeatang[getRandomInt(1, #arrowbeatang)])
    setPropertyFromGroup("opponentStrums", 3, "angle", arrowbeatang[getRandomInt(1, #arrowbeatang)])

    setPropertyFromGroup("playerStrums", 0, "angle", arrowbeatang[getRandomInt(1, #arrowbeatang)])
    setPropertyFromGroup("playerStrums", 1, "angle", arrowbeatang[getRandomInt(1, #arrowbeatang)])
    setPropertyFromGroup("playerStrums", 2, "angle", arrowbeatang[getRandomInt(1, #arrowbeatang)])
    setPropertyFromGroup("playerStrums", 3, "angle", arrowbeatang[getRandomInt(1, #arrowbeatang)])

    noteTweenAngle("Nang1", 0, 0, v1, "expoOut")
    noteTweenAngle("Nang2", 1, 0, v1, "expoOut")
    noteTweenAngle("Nang3", 2, 0, v1, "expoOut")
    noteTweenAngle("Nang4", 3, 0, v1, "expoOut")

    noteTweenAngle("Nang5", 4, 0, v1, "expoOut")
    noteTweenAngle("Nang6", 5, 0, v1, "expoOut")
    noteTweenAngle("Nang7", 6, 0, v1, "expoOut")
    noteTweenAngle("Nang8", 7, 0, v1, "expoOut")
end

function arrowBeatY(v1)
    defaultStrumY = -10
    if downscroll then
        defaultStrumY = 510
    end

    arrowbeaty = {10, 15, 20, 25, 110, 115, 120, 125}

    setPropertyFromGroup("opponentStrums", 0, "y", defaultStrumY + arrowbeaty[getRandomInt(1, #arrowbeaty)])
    setPropertyFromGroup("opponentStrums", 1, "y", defaultStrumY + arrowbeaty[getRandomInt(1, #arrowbeaty)])
    setPropertyFromGroup("opponentStrums", 2, "y", defaultStrumY + arrowbeaty[getRandomInt(1, #arrowbeaty)])
    setPropertyFromGroup("opponentStrums", 3, "y", defaultStrumY + arrowbeaty[getRandomInt(1, #arrowbeaty)])

    setPropertyFromGroup("playerStrums", 0, "y", defaultStrumY + arrowbeaty[getRandomInt(1, #arrowbeaty)])
    setPropertyFromGroup("playerStrums", 1, "y", defaultStrumY + arrowbeaty[getRandomInt(1, #arrowbeaty)])
    setPropertyFromGroup("playerStrums", 2, "y", defaultStrumY + arrowbeaty[getRandomInt(1, #arrowbeaty)])
    setPropertyFromGroup("playerStrums", 3, "y", defaultStrumY + arrowbeaty[getRandomInt(1, #arrowbeaty)])

    noteTweenY("Ny1", 0, defaultStrumY + 60, v1, "expoOut")
    noteTweenY("Ny2", 1, defaultStrumY + 60, v1, "expoOut")
    noteTweenY("Ny3", 2, defaultStrumY + 60, v1, "expoOut")
    noteTweenY("Ny4", 3, defaultStrumY + 60, v1, "expoOut")

    noteTweenY("Ny5", 4, defaultStrumY + 60, v1, "expoOut")
    noteTweenY("Ny6", 5, defaultStrumY + 60, v1, "expoOut")
    noteTweenY("Ny7", 6, defaultStrumY + 60, v1, "expoOut")
    noteTweenY("Ny8", 7, defaultStrumY + 60, v1, "expoOut")
end

function arrowBeatX(v1)
    defaultStrumX = {92, 204, 316, 428, 732, 844, 956, 1068}

    arrowbeatx = {10, 20, 30, 40, -10, -20, -30, -40}

    setPropertyFromGroup("opponentStrums", 0, "x", defaultStrumX[1] + arrowbeatx[getRandomInt(1, #arrowbeatx)])
    setPropertyFromGroup("opponentStrums", 1, "x", defaultStrumX[2] + arrowbeatx[getRandomInt(1, #arrowbeatx)])
    setPropertyFromGroup("opponentStrums", 2, "x", defaultStrumX[3] + arrowbeatx[getRandomInt(1, #arrowbeatx)])
    setPropertyFromGroup("opponentStrums", 3, "x", defaultStrumX[4] + arrowbeatx[getRandomInt(1, #arrowbeatx)])

    setPropertyFromGroup("playerStrums", 0, "x", defaultStrumX[5] + arrowbeatx[getRandomInt(1, #arrowbeatx)])
    setPropertyFromGroup("playerStrums", 1, "x", defaultStrumX[6] + arrowbeatx[getRandomInt(1, #arrowbeatx)])
    setPropertyFromGroup("playerStrums", 2, "x", defaultStrumX[7] + arrowbeatx[getRandomInt(1, #arrowbeatx)])
    setPropertyFromGroup("playerStrums", 3, "x", defaultStrumX[8] + arrowbeatx[getRandomInt(1, #arrowbeatx)])

    noteTweenX("Nx1", 0, defaultStrumX[1], v1, "expoOut")
    noteTweenX("Nx2", 1, defaultStrumX[2], v1, "expoOut")
    noteTweenX("Nx3", 2, defaultStrumX[3], v1, "expoOut")
    noteTweenX("Nx4", 3, defaultStrumX[4], v1, "expoOut")

    noteTweenX("Nx5", 4, defaultStrumX[5], v1, "expoOut")
    noteTweenX("Nx6", 5, defaultStrumX[6], v1, "expoOut")
    noteTweenX("Nx7", 6, defaultStrumX[7], v1, "expoOut")
    noteTweenX("Nx8", 7, defaultStrumX[8], v1, "expoOut")
end

function arrowBeatDirection(v1)
    defaultStrumDirection = 90

    arrowbeatdirection = {10, 20, -10, -20}

    setPropertyFromGroup("opponentStrums", 0, "direction",
        defaultStrumDirection + arrowbeatdirection[getRandomInt(1, #arrowbeatdirection)])
    setPropertyFromGroup("opponentStrums", 1, "direction",
        defaultStrumDirection + arrowbeatdirection[getRandomInt(1, #arrowbeatdirection)])
    setPropertyFromGroup("opponentStrums", 2, "direction",
        defaultStrumDirection + arrowbeatdirection[getRandomInt(1, #arrowbeatdirection)])
    setPropertyFromGroup("opponentStrums", 3, "direction",
        defaultStrumDirection + arrowbeatdirection[getRandomInt(1, #arrowbeatdirection)])

    setPropertyFromGroup("playerStrums", 0, "direction",
        defaultStrumDirection + arrowbeatdirection[getRandomInt(1, #arrowbeatdirection)])
    setPropertyFromGroup("playerStrums", 1, "direction",
        defaultStrumDirection + arrowbeatdirection[getRandomInt(1, #arrowbeatdirection)])
    setPropertyFromGroup("playerStrums", 2, "direction",
        defaultStrumDirection + arrowbeatdirection[getRandomInt(1, #arrowbeatdirection)])
    setPropertyFromGroup("playerStrums", 3, "direction",
        defaultStrumDirection + arrowbeatdirection[getRandomInt(1, #arrowbeatdirection)])

    noteTweenDirection("Nd1", 0, defaultStrumDirection, v1, "expoOut")
    noteTweenDirection("Nd2", 1, defaultStrumDirection, v1, "expoOut")
    noteTweenDirection("Nd3", 2, defaultStrumDirection, v1, "expoOut")
    noteTweenDirection("Nd4", 3, defaultStrumDirection, v1, "expoOut")

    noteTweenDirection("Nd5", 4, defaultStrumDirection, v1, "expoOut")
    noteTweenDirection("Nd6", 5, defaultStrumDirection, v1, "expoOut")
    noteTweenDirection("Nd7", 6, defaultStrumDirection, v1, "expoOut")
    noteTweenDirection("Nd8", 7, defaultStrumDirection, v1, "expoOut")
end

function camAngle(valang, durang)
    setProperty("camHUD.angle", valang)
    doTweenAngle("camHudANG", "camHUD", 0, durang, "expoOut")

    setProperty("camGame.angle", valang)
    doTweenAngle("camGameANG", "camGame", 0, durang, "expoOut")
end

local angBeat = true
local yBeat = true
local xBeat = true
local directionBeat = false
function activateBothNotesEvent(v1, v2, v3, v4)
    -- v1 = duration
    if angBeat then
        arrowBeatAng(v1)
    end

    -- v2 = duration
    if yBeat then
        arrowBeatY(v2)
    end

    -- v3 = duration
    if xBeat then
        arrowBeatX(v3)
    end

    -- v4 = duration
    if directionBeat then
        arrowBeatDirection(v4)
    end
end

local particleID = 0
local firstparticlea = true
function createBackParticle(amount, multSpeed)
    for i = 0, amount do
        particleID = particleID + 1
        local tag = "particleBGBack" .. particleID
        makeLuaSprite(tag, "", getRandomFloat(-900, 2270), getRandomFloat(850, 900))
        makeGraphic(tag, 20, 20, "FFFFFF")

        if firstparticlea then
            makeGraphic(tag, 20, 20, "419FFF")
            firstparticlea = false
        else
            makeGraphic(tag, 20, 20, "FFB26F")
            firstparticlea = true
        end

        addLuaSprite(tag, true)
        setBlendMode(tag, "add")

        setProperty(tag .. ".alpha", 0.85)
        setProperty(tag .. ".angle", getRandomFloat(0, 89))
        doTweenY(tag, tag, getProperty(tag .. ".y") - getRandomFloat(150, 400), 2 * (multSpeed or 1), "quadOut")
        doTweenAlpha("partAlphaB" .. particleID, tag, 0, 2 * (multSpeed or 1))

        if ((curBeat >= 292 and curBeat < 360)) then
            removeLuaSprite(tag)
        end
    end
end

function onTweenCompleted(tag)
    if string.find(tag, "particleBGBack") then
        removeLuaSprite(tag, true)
    end
end

function timebartextlol()
    makeLuaText('NDtimeTxt', '12:34 - 12:34', 500, 5, 685)
    setTextSize('NDtimeTxt', 21)
    addLuaText('NDtimeTxt')
    setTextFont('NDtimeTxt', "funkin.ttf")
    setObjectCamera("NDtimeTxt", 'other')
    setTextAlignment("NDtimeTxt", 'left')
    -- setProperty("UEtimeTxt.alpha", 0)
end

function formatTime(millisecond)
    local seconds = math.floor(millisecond / 1000)
    return string.format("%01d:%02d", (seconds / 60) % 60, seconds % 60)
end

-- THIS IS SO BAD BUT IM KEEPING IT AND USING IT LMAOOOOO
function reverseModifier(v1)
    if v1 == 1 then
        reverseModY = 50
        if not downscroll then
            reverseModY = 570
        end
        reverseModDirection = -90

        setPropertyFromGroup("opponentStrums", 0, "y", reverseModY)
        setPropertyFromGroup("opponentStrums", 1, "y", reverseModY)
        setPropertyFromGroup("opponentStrums", 2, "y", reverseModY)
        setPropertyFromGroup("opponentStrums", 3, "y", reverseModY)

        setPropertyFromGroup("playerStrums", 0, "y", reverseModY)
        setPropertyFromGroup("playerStrums", 1, "y", reverseModY)
        setPropertyFromGroup("playerStrums", 2, "y", reverseModY)
        setPropertyFromGroup("playerStrums", 3, "y", reverseModY)

        setPropertyFromGroup("opponentStrums", 0, "direction", reverseModDirection)
        setPropertyFromGroup("opponentStrums", 1, "direction", reverseModDirection)
        setPropertyFromGroup("opponentStrums", 2, "direction", reverseModDirection)
        setPropertyFromGroup("opponentStrums", 3, "direction", reverseModDirection)

        setPropertyFromGroup("playerStrums", 0, "direction", reverseModDirection)
        setPropertyFromGroup("playerStrums", 1, "direction", reverseModDirection)
        setPropertyFromGroup("playerStrums", 2, "direction", reverseModDirection)
        setPropertyFromGroup("playerStrums", 3, "direction", reverseModDirection)
    elseif v1 == 2 then
        reverseModY = 570
        if not downscroll then
            reverseModY = 50
        end
        reverseModDirection = 90

        setPropertyFromGroup("opponentStrums", 0, "y", reverseModY)
        setPropertyFromGroup("opponentStrums", 1, "y", reverseModY)
        setPropertyFromGroup("opponentStrums", 2, "y", reverseModY)
        setPropertyFromGroup("opponentStrums", 3, "y", reverseModY)

        setPropertyFromGroup("playerStrums", 0, "y", reverseModY)
        setPropertyFromGroup("playerStrums", 1, "y", reverseModY)
        setPropertyFromGroup("playerStrums", 2, "y", reverseModY)
        setPropertyFromGroup("playerStrums", 3, "y", reverseModY)

        setPropertyFromGroup("opponentStrums", 0, "direction", reverseModDirection)
        setPropertyFromGroup("opponentStrums", 1, "direction", reverseModDirection)
        setPropertyFromGroup("opponentStrums", 2, "direction", reverseModDirection)
        setPropertyFromGroup("opponentStrums", 3, "direction", reverseModDirection)

        setPropertyFromGroup("playerStrums", 0, "direction", reverseModDirection)
        setPropertyFromGroup("playerStrums", 1, "direction", reverseModDirection)
        setPropertyFromGroup("playerStrums", 2, "direction", reverseModDirection)
        setPropertyFromGroup("playerStrums", 3, "direction", reverseModDirection)
    end
end

-- middle scroll
function middleModifier(v1, v2)
    if v1 == 1 then
        if xBeat == true then
            xBeat = false
        end
        noteTweenAlpha('note movement1', 0, 0, v2, 'cubeInOut')
        noteTweenAlpha('note movement2', 1, 0, v2, 'cubeInOut')
        noteTweenAlpha('note movement3', 2, 0, v2, 'cubeInOut')
        noteTweenAlpha('note movement4', 3, 0, v2, 'cubeInOut')
        noteTweenX('note movement5', 4, 412, v2, 'cubeInOut')
        noteTweenX('note movement6', 5, 524, v2, 'cubeInOut')
        noteTweenX('note movement7', 6, 636, v2, 'cubeInOut')
        noteTweenX('note movement8', 7, 748, v2, 'cubeInOut')
        noteTweenX('note movement9', 0, 412, v2, 'cubeInOut')
        noteTweenX('note movement10', 1, 524, v2, 'cubeInOut')
        noteTweenX('note movement11', 2, 636, v2, 'cubeInOut')
        noteTweenX('note movement12', 3, 748, v2, 'cubeInOut')
    elseif v1 == 2 then
        if xBeat == false and v1 == 1 then
            xBeat = true
        end
        noteTweenAlpha('note movement1', 0, 1, v2, 'cubeInOut')
        noteTweenAlpha('note movement2', 1, 1, v2, 'cubeInOut')
        noteTweenAlpha('note movement3', 2, 1, v2, 'cubeInOut')
        noteTweenAlpha('note movement4', 3, 1, v2, 'cubeInOut')
        noteTweenX('note movement5', 4, 732, v2, 'cubeInOut')
        noteTweenX('note movement6', 5, 844, v2, 'cubeInOut')
        noteTweenX('note movement7', 6, 956, v2, 'cubeInOut')
        noteTweenX('note movement8', 7, 1068, v2, 'cubeInOut')
        noteTweenX('note movement9', 0, 92, v2, 'cubeInOut')
        noteTweenX('note movement10', 1, 204, v2, 'cubeInOut')
        noteTweenX('note movement11', 2, 316, v2, 'cubeInOut')
        noteTweenX('note movement12', 3, 428, v2, 'cubeInOut')
    end
end

-- amart
function continuous_sin(x)
    return math.sin((x % 1) * 2 * math.pi)
end
