luaDebugMode = true

local modFolderName = "Custom Pause By Mega V1.7.0" -- for the mobile port. If the name doesn't match, there will be errors on the phones

-- for select option
local selectTime = .4
--------------------------

local isCustomPaused = false

local selectedOption = 1
local OptionsSelect = 1
local soundBPM = 0

local SettingsChanged = false

local SettingsIsLoaded = false

local canEnter = false
local enterCooldown = 1

local textYOffset = 75 -- how much the text moves when you select it (for tweening)
local settingsTextYOffset = 20

local TweenAnimationsForTexts = true -- DO NOT CHANGE

local Settings = {
    MobilePort = false --If the mobile version does not work, simply set the ModilePort parameter to true
}

local settingsFont = "Settings.ttf"

local BPMTable = { -- <<< BPM TABLE (add your custom music here)
    ["None"] = 120,
    ["Freeze"] = 103,
    ["Breakfast (Pico)"] = 165,
    ["Breakfast"] = 160,
    ["Freaky Menu"] = 102,
    ["Tea time"] = 120,
    ["Stay Funky"] = 180,
    ["Menu (Indie Cross)"] = 117,
    ["Freeplay Random"] = 145,
    ["Breakfast (Pixel)"] = 160,
    ["Girlfriends Ringtone"] = 160
}

local IsPaused = false
local InSettings = false

--If you want to fully understand my code, your brain will melt faster than you understand it :DDDD

function onPause()
    openCustomSubstate("Custom Pause", true)
    canEnter = true
    return Function_Stop
end

function onCustomSubstateCreate(name)
    if name == "Custom Pause" then openSubstate() end
end

function onCreate()
    --setPropertyFromClass('flixel.FlxG', 'mouse.visible', true) -- it's enabled for test
    if buildTarget ~= "windows" and "linux" then
        Settings.MobilePort = true
    end
end

function openSubstate(forSettings,canRunTimer)

    SettingsChanged = false
    IsPaused = true
    selectedOption = 1
    OptionsSelect = 1
    local opponentIconName = getProperty('dad.healthIcon')

    -- Music

    if not forSettings then
        playSound("cancelMenu", 0.7)

        if getModSetting("Music_on_pause", modFolderName) == "Song Instrumental" and getModSetting("Music_on_pause", modFolderName) then
            soundBPM = getPropertyFromClass("backend.Conductor", "bpm")
            if checkFileExists("songs/" .. songPath .. "/Inst.ogg") then
                if getModSetting("Music_on_pause", modFolderName) ~= "None" then
                    playSound("../songs/" .. songPath .. "/Inst", 0, "pauseMusic")
                    soundFadeIn("pauseMusic", .5, 0, .4)
                end
            else
                if getModSetting("Music_on_pause", modFolderName) ~= "None" then
                    playSound("../../../assets/songs/" .. songPath .. "/Inst", 0, "pauseMusic")
                    soundFadeIn("pauseMusic", .5, 0, .4)
                end
            end
            setSoundTime("pauseMusic", getSongPosition())
        else
            if getModSetting("Music_on_pause", modFolderName) ~= "None" then
                playSound("pauseMusic/" .. getModSetting("Music_on_pause", modFolderName), 0,"pauseMusic")
                soundFadeIn("pauseMusic", .5, 0, .4)
            end
            soundBPM = BPMTable[getModSetting("Music_on_pause", modFolderName)]
        end
    end

    if Settings.MobilePort and not forSettings then
        -------------

        -- mobile buttons

        --up

        makeLuaSprite("upB","pauseMenu/Mobile/UpB",1500,250)
        addLuaSprite("upB")
		
        scaleObject("upB",.7,.7)
        setObjectCamera("upB","other")

        --down

        makeLuaSprite("downB","pauseMenu/Mobile/DownB",1500,350)
        addLuaSprite("downB")

        scaleObject("downB",.7,.7)
        setObjectCamera("downB","other")

        --enter

        makeLuaSprite("enterB","pauseMenu/Mobile/EnterB",1500,300)
        addLuaSprite("enterB")
		
        scaleObject("enterB",.7,.7)
        setObjectCamera("enterB","other")

        doTweenX("downTweenXIn","downB",1100,.7,"circOut")
        doTweenX("upTweenXIn","upB",1100,.7,"circOut")
        doTweenX("EnterTweenXIn","enterB",985,.7,"circOut")
        
         setObjectOrder("downB",999)
         setObjectOrder("enterB",999)
         setObjectOrder("upB",999)
        -------------
    end

    -- icon

    makeLuaSprite("OpponentIcon", "icons/icon-" .. opponentIconName, 100, 100)
    loadGraphic("OpponentIcon", "icons/icon-" .. opponentIconName, 150, 150)
    setObjectCamera("OpponentIcon", "other")
    setObjectOrder("OpponentIcon", 5)
    setProperty("OpponentIcon.x", 660)
    addLuaSprite("OpponentIcon", true)
    setProperty("OpponentIcon.y", 700)

    -- bg
    makeLuaSprite("background","pauseMenu/Backgrounds/"..getModSetting("Pause_bg_color", modFolderName),-1600,-215)

    scaleObject("background", 1.19, 1.19)
    setObjectCamera("background", "other")
    setProperty("background.angle", 15)
    addLuaSprite("background", true)
    setObjectOrder("background", 0)
    setProperty("background.alpha", 1)

    -- black bg

    makeLuaSprite("black", "", 0, 0)
    makeGraphic("black", 1280, 720, "000000")
    setObjectCamera("black", "other")
    addLuaSprite("black", true)
    setObjectOrder("black", 0)
    setProperty("black.alpha", 0)

    -- black line for bg

    makeLuaSprite("blackLine", "", 0, 0)
    makeGraphic("blackLine", 30, 1280, "000000")
    setObjectCamera("blackLine", "other")
    addLuaSprite("blackLine", true)
    setObjectOrder("blackLine", 1)
    setProperty("blackLine.x", -500)
    setProperty("blackLine.y", -40)
    setProperty("blackLine.angle", 15)
    setObjectOrder("blackLine", 2)

    -- white line for bg

    makeLuaSprite("whiteLine", "", 0, 0)
    makeGraphic("whiteLine", 30, 1280, "FFFFFF")
    setObjectCamera("whiteLine", "other")
    addLuaSprite("whiteLine", true)
    setObjectOrder("whiteLine", 1)
    setProperty("whiteLine.x", -520)

    setProperty("whiteLine.y", -40)
    setProperty("whiteLine.angle", 15)
    setObjectOrder("whiteLine", 2)

    -- black line for Song Text

    makeLuaSprite("blackLineSong", "", 0, 0)
    makeGraphic("blackLineSong", 1280, 80, "000000")
    setObjectCamera("blackLineSong", "other")
    addLuaSprite("blackLineSong", true)
    setObjectOrder("blackLineSong", 1)
    setProperty("blackLineSong.x", 0)
    setProperty("blackLineSong.y", 510)
    setProperty("blackLineSong.alpha", 0)
    setObjectOrder("blackLineSong", 1)

    -- Title song text

    makeLuaText("TitleSongText", songName, 400, 0, 150)
    setTextSize("TitleSongText", 25)
    setProperty("TitleSongText.x", 500)
    setObjectCamera("TitleSongText", "other")
    setProperty("TitleSongText.alpha", 0)
    setProperty("TitleSongText.y", 400)
    setProperty("TitleSongText.x", 830)
    addLuaText("TitleSongText", true)
    setObjectOrder("TitleSongText", 2)

    -- Difficuilty text

    makeLuaText("DifficultyText", "Difficulty: " .. difficultyName, 400, 0, 150)
    setTextSize("DifficultyText", 25)
    setProperty("DifficultyText.x", 800)
    setObjectCamera("DifficultyText", "other")
    setProperty("DifficultyText.alpha", 0)
    setProperty("DifficultyText.y", 80)
    addLuaText("DifficultyText", true)
    setObjectOrder("DifficultyText", 2)

    -- Disk and anims

    makeAnimatedLuaSprite("Disk", "pauseMenu/Disk", 0, 0)
    addAnimationByPrefix("Disk", "Disk start", "disk", 24, true)

    setObjectCamera("Disk", "other")
    setProperty("Disk.x", 540)
    setProperty("Disk.y", 360)
    setProperty("Disk.alpha", 0)
    addLuaSprite("Disk", true)
    setObjectOrder("Disk", 4)
    scaleObject("Disk", 1.4, 1.4)

    -- Resume Anims

    makeAnimatedLuaSprite("ResumeText", "pauseMenu/Resume", 0, 0)
    addAnimationByPrefix("ResumeText", "Resume Select", "Resume_Select", 24, true)
    addAnimationByPrefix("ResumeText", "Resume Unselect", "Resume_Unselect", 24,true)

    -- Restart Anims

    makeAnimatedLuaSprite("RestartText", "pauseMenu/Restart", 0, 0)
    addAnimationByPrefix("RestartText", "Restart Unselect", "Restart_Unselect",24, true)
    addAnimationByPrefix("RestartText", "Restart Select", "Restart_Select", 24,true)

    -- Settings Anims

    makeAnimatedLuaSprite("SettingsText", "pauseMenu/Settings", 0, 0)
    addAnimationByPrefix("SettingsText", "Settings Unselect","Settings_Unselect", 24, true)
    addAnimationByPrefix("SettingsText", "Settings Select", "Settings_Select",24, true)

    -- Chart Editor Anims

    makeAnimatedLuaSprite("ChartEditorText", "pauseMenu/Chart_Editor", 0, 0)
    addAnimationByPrefix("ChartEditorText", "Chart Editor Unselect","Chart_Editor_Unselect", 24, true)
    addAnimationByPrefix("ChartEditorText", "Chart Editor Select","Chart_Editor_Select", 24, true)

    -- Exit Anims

    makeAnimatedLuaSprite("ExitText", "pauseMenu/Exit", 0, 0)
    addAnimationByPrefix("ExitText", 'Exit Select', "Exit_Select", 24, true)
    addAnimationByPrefix("ExitText", 'Exit Unselect', "Exit_Unselect", 24, true)

    ---------------------------------------
    setObjectCamera("RestartText", "other")
    setObjectCamera("ResumeText", "other")
    setObjectCamera("ExitText", "other")
    setObjectCamera("ChartEditorText", "other")
    setObjectCamera("SettingsText", "other")

    scaleObject("RestartText", .7, .7)
    scaleObject("ResumeText", .8, .8)
    scaleObject("ExitText", .8, .8)
    scaleObject("ChartEditorText", .65, .65)
    scaleObject("SettingsText", .65, .65)

    setProperty("ResumeText.alpha", 0)
    setProperty("RestartText.alpha", 0)
    setProperty("ExitText.alpha", 0)
    setProperty("ChartEditorText.alpha", 0)
    setProperty("SettingsText.alpha", 0)

    setProperty("ResumeText.x", 20)
    setProperty("RestartText.x", 20)
    setProperty("ExitText.x", 20)
    setProperty("ChartEditorText.x", 20)
    setProperty("SettingsText.x", 20)

    addLuaSprite("ResumeText", true)
    addLuaSprite("RestartText", true)
    addLuaSprite("ExitText", true)
    addLuaSprite("ChartEditorText", true)
    addLuaSprite("SettingsText", true)

    ---------------------------------------

    -- tweens

    doTweenAlpha("DiskAlphaIn", "Disk", 1, 0.4, "sineIn")
    doTweenAlpha("blackAlphaIn", "black", .4, 0.4, "sineIn")

    doTweenAlpha("ResumeTextAplhaIn", "ResumeText", 1, .4, "circOut")
    doTweenAlpha("RestartTextAplhaIn", "RestartText", 1, .4, "circOut")
    doTweenAlpha("ChartEditorTextAplhaIn", "ChartEditorText", 1, .4, "circOut")
    doTweenAlpha("SettingsTextAplhaIn", "SettingsText", 1, .4, "circOut")
    doTweenAlpha("ExitTextAplhaIn", "ExitText", 1, .4, "circOut")

    doTweenX("blackLineX", "blackLine", 490, .4, "circOut")
    doTweenX("whiteLineX", "whiteLine", 505, .4, "circOut")

    doTweenY("ResumeTextIn", "ResumeText", 50, 0.4, "circOut")
    doTweenY("RestartTextIn", "RestartText", 200, 0.4, "circOut")
    doTweenY("ChartEditorTextIn", "ChartEditorText", 500, .4, "circOut")
    doTweenY("SettingsTextIn", "SettingsText", 350, .4, "circOut")
    doTweenY("ExitTextIn", "ExitText", 700, .4, "circOut")

    doTweenX("bgIn", "background", -950, .4, "circOut")
    doTweenY("bgInY", "background", -215, .4, "circOut")

    doTweenAlpha("OpponentIconIn", "OpponentIcon", 1, .4, "sineIn")

    -- doTweenX("OpponentXIn", "OpponentIcon", 890, 0.4, "circOut")
    doTweenY("OpponentYIn", "OpponentIcon", 485, 0.4, "circOut")

    doTweenAlpha("DifficultyTextAlphaIn", "DifficultyText", 1, 0.4, "sineIn")
    doTweenX("DifficultyTextXIn", "DifficultyText", 920, .4, "circOut")
    doTweenY("DifficultyTextYIn", "DifficultyText", 20, .4, "circOut")

    doTweenAlpha("TitleSongTextAlphaIn", "TitleSongText", 1, 0.4, "sineIn")
    doTweenY("TitleSongTextYIn", "TitleSongText", 540, .4, "circOut")

    doTweenAlpha("blackLineSongAlphaOut", "blackLineSong", 1, 0.4, "sineIn")

    -- insert to custom substate table
    insertToCustomSubstate("ArtistText")
    insertToCustomSubstate("ResumeText")
    insertToCustomSubstate("PauseMenuText")
    insertToCustomSubstate("ExitText")
    insertToCustomSubstate("OpponentIcon")
    insertToCustomSubstate("RestartText")
    insertToCustomSubstate("background")
    insertToCustomSubstate("black")
    insertToCustomSubstate("blackLine")
    insertToCustomSubstate("whiteLine")
    insertToCustomSubstate("ChartEditorText")
    insertToCustomSubstate("SettingsText")

    if Settings.MobilePort then
        insertToCustomSubstate("upB")
        insertToCustomSubstate("downB")
        insertToCustomSubstate("enterB")
    end

    local beatDuration = 60 / soundBPM

    if not canRunTimer or canRunTimer == nil then
        runTimer("beatTimer", beatDuration, 0)
    end

    function onTimerCompleted(tag, loops, loopsLeft)
        if tag == "beatTimer" then
            setProperty('OpponentIcon.scale.x', 1)
            setProperty('OpponentIcon.scale.y', 1)
            doTweenX('OpponentIconResetX', 'OpponentIcon.scale', .6, 0.2,'circOut')
            doTweenY('OpponentIconResetY', 'OpponentIcon.scale', .6, 0.2,'circOut')
        end
        if tag == "enterCooldown" then
            canEnter = true
        end
    end

    if getModSetting("Pause_text_anims", modFolderName) == false then
        TweenAnimationsForTexts = false
    else
        TweenAnimationsForTexts = true
    end
end

function closeSubstate(exitSoundOrRestart,forSettings)
    IsPaused = false

    doTweenX("blackLineX", "blackLine", -505, .4, "circOut")
    doTweenX("whiteLineX", "whiteLine", -505, .4, "circOut")

    doTweenY("OpponentYOut", "OpponentIcon",getProperty("OpponentIcon.y") + 350, 0.4, "circOut")
    doTweenY("DiskTween", "Disk", getProperty("Disk.y") + 350, 0.4, "circOut")

    doTweenAlpha("blackAlphaOut", "black", 0, 0.4, "sineIn")

    doTweenAlpha("OpponentIconAlphaOut", "OpponentIcon", 0, 0.1, "sineIn")
    doTweenAlpha("DiskAlphaOut", "Disk", 0, 0.1, "sineIn")

    doTweenX("ResumeTextOut", "ResumeText", -700, 0.4, "circOut")
    doTweenAlpha("ResumeTextAlphaOut", "ResumeText", 0, 0.4, "circOut")

    doTweenX("RestartTextOut", "RestartText", -700, .4, "circOut")
    doTweenAlpha("RestartTextAlphaOut", "RestartText", 0, 0.4, "circOut")

    doTweenX("ExitTextOut", "ExitText", -700, .4, "circOut")
    doTweenAlpha("ExitTextAlphaOut", "ExitText", 0, 0.4, "circOut")

    doTweenX("settingsY", "SettingsText", -700, .4, "circOut")
    doTweenAlpha("settingsAlpha", "SettingsText", 0, .4, "circOut")

    doTweenAlpha("blackLineSongAlphaOut", "blackLineSong", 0, 0.4, "sineIn")

    doTweenX("ChartEditorTextOut", "ChartEditorText", -700, .4, "circOut")
    doTweenAlpha("ChartEditorTextAlphaOut", "ChartEditorText", 0, 0.4, "circOut")

    doTweenX("bgOut", "background", -1650, .4, "circOut")
    doTweenY("bgOutY", "background", -215, .4, "circOut")

    doTweenAlpha("TitleSongTextAlphaIn", "TitleSongText", 0, 0.4, "sineIn")
    doTweenAlpha("DifficultyTextAlphaIn", "DifficultyText", 0, 0.4, "sineIn")

    if not forSettings and Settings.ModilePort then
        doTweenX("downTweenXIn","downB",1500,.7,"circOut")
        doTweenX("upTweenXIn","upB",1500,.7,"circOut")
        doTweenX("EnterTweenXIn","enterB",1500,.7,"circOut")
    end

    if not forSettings then
        soundFadeOut("pauseMusic", .4, 0)
        cancelTimer("beatTimer")
        function onTimerCompleted(tag, loops, loopsLeft)
            if tag == "closeSubstate" then
                stopSound("pauseMusic")
            end
        end
    end
	
    runTimer("closeSubstate", 0.4)
end

function SelectOption1()
    if not InSettings then
        if TweenAnimationsForTexts then
            doTweenX("ResumeTextX", "ResumeText", 180, selectTime, "circOut")
            doTweenX("RestartTextX", "RestartText", 20, selectTime, "circOut")
            doTweenX("ExitTextX", "ExitText", 20, selectTime, "circOut")
            doTweenX("ChartEditorTextX", "ChartEditorText", 20, selectTime,"circOut")
            doTweenX("SettingsTextX", "SettingsText", 20, selectTime, "circOut")
        end

        doTweenY("ResumeTextIn", "ResumeText", 50 + textYOffset, selectTime,"circOut")
        doTweenY("RestartTextIn", "RestartText", 200 + textYOffset, selectTime,"circOut")
        doTweenY("ChartEditorTextIn", "ChartEditorText", 500 + textYOffset,selectTime, "circOut")
        doTweenY("SettingsTextIn", "SettingsText", 350 + textYOffset, selectTime,"circOut")
        doTweenY("ExitTextIn", "ExitText", 700 + textYOffset, selectTime, "circOut")

        if getProperty("ResumeText.animation.curAnim.name") ~= "Resume Select" then
            playAnim("ResumeText", "Resume Select", true)
        end
        if getProperty("RestartText.animation.curAnim.name") ~= "Restart Unselect" then
            playAnim("RestartText", "Restart Unselect", true)
        end
        if getProperty("ExitText.animation.curAnim.name") ~= "Exit Unselect" then
            playAnim("ExitText", "Exit Unselect", true)
        end
        if getProperty("ChartEditorText.animation.curAnim.name") ~= "Chart Editor Unselect" then
            playAnim("ChartEditorText", "Chart Editor Unselect", true)
        end
        if getProperty("SettingsText.animation.curAnim.name") ~= "Settings Unselect" then
            playAnim("SettingsText", "Settings Unselect", true)
        end
    end
end

function SelectOption2()
    if not InSettings then
        if TweenAnimationsForTexts then
            doTweenX("ResumeTextX", "ResumeText", 20, selectTime, "circOut")
            doTweenX("RestartTextX", "RestartText", 140, selectTime, "circOut")
            doTweenX("ExitTextX", "ExitText", 20, selectTime, "circOut")
            doTweenX("ChartEditorTextX", "ChartEditorText", 20, selectTime,"circOut")
            doTweenX("SettingsTextX", "SettingsText", 20, selectTime, "circOut")
        end

        doTweenY("ResumeTextIn", "ResumeText", 50 - textYOffset, selectTime,"circOut")
        doTweenY("RestartTextIn", "RestartText", 200 - textYOffset, selectTime,"circOut")
        doTweenY("ChartEditorTextIn", "ChartEditorText", 500 - textYOffset,selectTime, "circOut")
        doTweenY("SettingsTextIn", "SettingsText", 350 - textYOffset, selectTime,"circOut")
        doTweenY("ExitTextIn", "ExitText", 700 - textYOffset, selectTime, "circOut")

        if getProperty("ResumeText.animation.curAnim.name") ~= "Resume Unselect" then
            playAnim("ResumeText", "Resume Unselect", true)
        end
        if getProperty("RestartText.animation.curAnim.name") ~= "Restart Select" then
            playAnim("RestartText", "Restart Select", true)
        end
        if getProperty("ExitText.animation.curAnim.name") ~= "Exit Unselect" then
            playAnim("ExitText", "Exit Unselect", true)
        end
        if getProperty("ChartEditorText.animation.curAnim.name") ~= "Chart Editor Unselect" then
            playAnim("ChartEditorText", "Chart Editor Unselect", true)
        end
        if getProperty("SettingsText.animation.curAnim.name") ~= "Settings Unselect" then
            playAnim("SettingsText", "Settings Unselect", true)
        end
    end
end

function SelectOption3()
    if not InSettings then
        if TweenAnimationsForTexts then
            doTweenX("ResumeTextX", "ResumeText", 20, selectTime, "circOut")
            doTweenX("RestartTextX", "RestartText", 20, selectTime, "circOut")
            doTweenX("ExitTextX", "ExitText", 20, .4, "circOut")
            doTweenX("ChartEditorTextX", "ChartEditorText", 20, selectTime,"circOut")
            doTweenX("SettingsTextX", "SettingsText", 130, selectTime, "circOut")
        end

        doTweenY("ResumeTextIn", "ResumeText", 50 - textYOffset * 2, selectTime,"circOut")
        doTweenY("RestartTextIn", "RestartText", 200 - textYOffset * 2, selectTime,"circOut")
        doTweenY("ChartEditorTextIn", "ChartEditorText",500 - textYOffset * 2, selectTime, "circOut")
        doTweenY("SettingsTextIn", "SettingsText", 350 - textYOffset * 2,selectTime, "circOut")
        doTweenY("ExitTextIn", "ExitText", 700 - textYOffset * 2, selectTime,"circOut")

        if getProperty("ResumeText.animation.curAnim.name") ~= "Resume Unselect" then
            playAnim("ResumeText", "Resume Unselect", true)
        end
        if getProperty("RestartText.animation.curAnim.name") ~= "Restart Unselect" then
            playAnim("RestartText", "Restart Unselect", true)
        end
        if getProperty("ExitText.animation.curAnim.name") ~= "Exit Unselect" then
            playAnim("ExitText", "Exit Unselect", true)
        end
        if getProperty("ChartEditorText.animation.curAnim.name") ~= "Chart Editor Unselect" then
            playAnim("ChartEditorText", "Chart Editor Unselect", true)
        end
        if getProperty("SettingsText.animation.curAnim.name") ~= "Settings Select" then
            playAnim("SettingsText", "Settings Select", true)
        end
    end
end

function SelectOption4()
    if not InSettings then
        if TweenAnimationsForTexts then
            doTweenX("ResumeTextX", "ResumeText", 20, selectTime, "circOut")
            doTweenX("RestartTextX", "RestartText", 20, selectTime, "circOut")
            doTweenX("ExitTextX", "ExitText", 20, selectTime, "circOut")
            doTweenX("ChartEditorTextX", "ChartEditorText", 140, selectTime, "circOut")
            doTweenX("SettingsTextX", "SettingsText", 20, selectTime, "circOut")
        end

        doTweenY("ResumeTextIn", "ResumeText", 50 - textYOffset * 3, selectTime,"circOut")
        doTweenY("RestartTextIn", "RestartText", 200 - textYOffset * 3, selectTime,"circOut")
        doTweenY("ChartEditorTextIn", "ChartEditorText",500 - textYOffset * 3, selectTime, "circOut")
        doTweenY("SettingsTextIn", "SettingsText", 350 - textYOffset * 3, selectTime, "circOut")
        doTweenY("ExitTextIn", "ExitText", 700 - textYOffset * 3, selectTime,"circOut")

        if getProperty("ResumeText.animation.curAnim.name") ~= "Resume Unselect" then
            playAnim("ResumeText", "Resume Unselect", true)
        end
        if getProperty("RestartText.animation.curAnim.name") ~= "Restart Unselect" then
            playAnim("RestartText", "Restart Unselect", true)
        end
        if getProperty("ExitText.animation.curAnim.name") ~= "Exit Unselect" then
            playAnim("ExitText", "Exit Unselect", true)
        end
        if getProperty("ChartEditorText.animation.curAnim.name") ~= "Chart Editor Select" then
            playAnim("ChartEditorText", "Chart Editor Select", true)
        end
        if getProperty("SettingsText.animation.curAnim.name") ~= "Settings Unselect" then
            playAnim("SettingsText", "Settings Unselect", true)
        end
    end
end

function SelectOption5()
    if not InSettings then
        if TweenAnimationsForTexts then
            doTweenX("ResumeTextX", "ResumeText", 20, selectTime, "circOut")
            doTweenX("RestartTextX", "RestartText", 20, selectTime, "circOut")
            doTweenX("ExitTextX", "ExitText", 170, selectTime, "circOut")
            doTweenX("ChartEditorTextX", "ChartEditorText", 20, selectTime, "circOut")
            doTweenX("SettingsTextX", "SettingsText", 20, .4, "circOut")
        end

        doTweenY("ResumeTextIn", "ResumeText", 50 - textYOffset * 4, selectTime, "circOut")
        doTweenY("RestartTextIn", "RestartText", 200 - textYOffset * 4, selectTime, "circOut")
        doTweenY("ChartEditorTextIn", "ChartEditorText", 500 - textYOffset * 4, selectTime, "circOut")
        doTweenY("SettingsTextIn", "SettingsText", 350 - textYOffset * 4, selectTime, "circOut")
        doTweenY("ExitTextIn", "ExitText", 700 - textYOffset * 4, selectTime, "circOut")

        if getProperty("ResumeText.animation.curAnim.name") ~= "Resume Unselect" then
            playAnim("ResumeText", "Resume Unselect", true)
        end
        if getProperty("RestartText.animation.curAnim.name") ~= "Restart Unselect" then
            playAnim("RestartText", "Restart Unselect", true)
        end
        if getProperty("ExitText.animation.curAnim.name") ~= "Exit Select" then
            playAnim("ExitText", "Exit Select", true)
        end
        if getProperty("ChartEditorText.animation.curAnim.name") ~= "Chart Editor Unselect" then
            playAnim("ChartEditorText", "Chart Editor Unselect", true)
        end
        if getProperty("SettingsText.animation.curAnim.name") ~= "Settings Unselect" then
            playAnim("SettingsText", "Settings Unselect", true)
        end
    end
end

function onCustomSubstateUpdate(name, elapsed)
    if name == "Custom Pause" then

        local mouseX = getMouseX("camHUD")
        local mouseY = getMouseY("camHUD")

        local up = keyJustPressed('up') or keyboardJustPressed('W') or getPropertyFromClass('flixel.FlxG', 'mouse.wheel') > 0
        local down = keyJustPressed('down') or keyboardJustPressed('S') or getPropertyFromClass('flixel.FlxG', 'mouse.wheel') < 0

        local enter = keyJustPressed("accept")
        local mobileEnter = mousePressed("left")

        if Settings.MobilePort then
            enter = keyJustPressed("accept") or mobileEnter and getMouseX('camHUD') > getProperty('enterB.x') and 
            getMouseX('camHUD') < getProperty('enterB.x') + getProperty('enterB.width') and 
            getMouseY('camHUD') > getProperty('enterB.y') and 
            getMouseY('camHUD') < getProperty('enterB.y') + getProperty('enterB.height')
        end

        if mobileEnter and canEnter and not InSettings and Settings.MobilePort then
            if getMouseX('camHUD') > getProperty('upB.x') and 
            getMouseX('camHUD') < getProperty('upB.x') + getProperty('upB.width') and 
            getMouseY('camHUD') > getProperty('upB.y') and 
            getMouseY('camHUD') < getProperty('upB.y') + getProperty('upB.height') then

                playSound("scrollMenu", 0.7)
                canEnter = false
                runTimer("enterCooldown",.15)
                selectedOption = selectedOption - 1

                setProperty("upB.scale.x",.5)
                setProperty("upB.scale.y",.5)

                doTweenX("upBInX","upB.scale",.7,.15,"circOut")
                doTweenY("upBInY","upB.scale",.7,.15,"circOut")

            elseif getMouseX('camHUD') > getProperty('downB.x') and 
            getMouseX('camHUD') < getProperty('downB.x') + getProperty('downB.width') and 
            getMouseY('camHUD') > getProperty('downB.y') and 
            getMouseY('camHUD') < getProperty('downB.y') + getProperty('downB.height') then

                playSound("scrollMenu", 0.7)
                canEnter = false
                runTimer("enterCooldown",.15)
                selectedOption = selectedOption + 1

                setProperty("downB.scale.x",.5)
                setProperty("downB.scale.y",.5)

                doTweenX("downBInX","downB.scale",.7,.15,"circOut")
                doTweenY("downBInY","downB.scale",.7,.15,"circOut")
            end
        end

        if InSettings then

            if up then
                playSound("scrollMenu", 0.7)
                OptionsSelect = OptionsSelect - 1
            elseif down then
                playSound("scrollMenu", 0.7)
                OptionsSelect = OptionsSelect + 1
            elseif OptionsSelect < 1 then
                OptionsSelect = 4
            elseif OptionsSelect > 4 then
                OptionsSelect = 1
            end

            if mobileEnter and canEnter and Settings.MobilePort then
                if getMouseX('camHUD') > getProperty('upB.x') and 
                getMouseX('camHUD') < getProperty('upB.x') + getProperty('upB.width') and 
                getMouseY('camHUD') > getProperty('upB.y') and 
                getMouseY('camHUD') < getProperty('upB.y') + getProperty('upB.height') then

                    playSound("scrollMenu", 0.7)
                    canEnter = false
                    runTimer("enterCooldown",.15)
                    OptionsSelect = OptionsSelect - 1

                    setProperty("upB.scale.x",.5)
                    setProperty("upB.scale.y",.5)

                    doTweenX("upBInX","upB.scale",.7,.15,"circOut")
                    doTweenY("upBInY","upB.scale",.7,.15,"circOut")

                elseif getMouseX('camHUD') > getProperty('downB.x') and 
                getMouseX('camHUD') < getProperty('downB.x') + getProperty('downB.width') and 
                getMouseY('camHUD') > getProperty('downB.y') and 
                getMouseY('camHUD') < getProperty('downB.y') + getProperty('downB.height') then

                    playSound("scrollMenu", 0.7)
                    canEnter = false
                    runTimer("enterCooldown",.15)
                    OptionsSelect = OptionsSelect + 1

                    setProperty("downB.scale.x",.5)
                    setProperty("downB.scale.y",.5)

                    doTweenX("downBInX","downB.scale",.7,.15,"circOut")
                    doTweenY("downBInY","downB.scale",.7,.15,"circOut")
                end
            end

            if OptionsSelect == 1 and SettingsIsLoaded then
                setTextString("downscrollText","< DOWNSCROLL >")
                setProperty("downscrollText.alpha",1)

                setTextString("middlescrollText","MIDDLESCROLL")
                setProperty("middlescrollText.alpha",.5)

                setTextString("ghostTappingText","GHOST TAPPING")
                setProperty("ghostTappingText.alpha",.5)

                setTextString("ExitText","EXIT")
                setProperty("ExitText.alpha",.5)

                setProperty("checkmark.alpha",1)

                if downscroll == true then
                    setTextString("descriptionText","Enable downscroll. Downscroll is currently enabled.")
                    --if getProperty("checkmark.animation.curAnim.name") ~= "Checkmark" then
                        playAnim("checkmark", "Checkmark", true)
                    --end
                else
                    --if getProperty("checkmark.animation.curAnim.name") ~= "Checkmark_cancel" then
                        playAnim("checkmark", "Checkmark_cancel", true)
                    --end
                    setTextString("descriptionText","Enable downscroll. Downscroll is currently disabled.")
                end
            elseif OptionsSelect == 2 and SettingsIsLoaded then
                setTextString("downscrollText","DOWNSCROLL")
                setProperty("downscrollText.alpha",.5)
                
                setTextString("middlescrollText","< MIDDLESCROLL >")
                setProperty("middlescrollText.alpha",1)

                setTextString("ghostTappingText","GHOST TAPPING")
                setProperty("ghostTappingText.alpha",.5)

                setTextString("ExitText","EXIT")
                setProperty("ExitText.alpha",.5)

                setProperty("checkmark.alpha",0)
                setProperty("checkmark.alpha",1)

                if middlescroll == true then
                    setTextString("descriptionText","Enable middlescroll. Middlescroll is currently enabled.")
                    --if getProperty("checkmark.animation.curAnim.name") ~= "Checkmark" then
                        playAnim("checkmark", "Checkmark", true)
                    --end
                else
                    --if getProperty("checkmark.animation.curAnim.name") ~= "Checkmark_cancel" then
                        playAnim("checkmark", "Checkmark_cancel", true)
                    --end
                    setTextString("descriptionText","Enable middlescroll. Middlescroll is currently disabled.")
                end
            elseif OptionsSelect == 3 and SettingsIsLoaded then
                setTextString("downscrollText","DOWNSCROLL")
                setProperty("downscrollText.alpha",.5)
                
                setTextString("middlescrollText","MIDDLESCROLL")
                setProperty("middlescrollText.alpha",.5)

                setTextString("ghostTappingText","< GHOST TAPPING >")
                setProperty("ghostTappingText.alpha",1)

                setTextString("ExitText","EXIT")
                setProperty("ExitText.alpha",.5)

                setProperty("checkmark.alpha",1)

                if ghostTapping == true then
                    setTextString("descriptionText","If enabled, you won't get misses from pressing keys while there are no notes able to be hit. This feature is currently enabled.")
                    --if getProperty("checkmark.animation.curAnim.name") ~= "Checkmark" then
                        playAnim("checkmark", "Checkmark", true)
                    --end
                else
                   -- if getProperty("checkmark.animation.curAnim.name") ~= "Checkmark_cancel" then
                        playAnim("checkmark", "Checkmark_cancel", true)
                    --end
                    setTextString("descriptionText","If enabled, you won't get misses from pressing keys while there are no notes able to be hit. This feature is currently disabled.")
                end
            elseif OptionsSelect == 4 and SettingsIsLoaded then
                setTextString("downscrollText","DOWNSCROLL")
                setProperty("downscrollText.alpha",.5)
                
                setTextString("middlescrollText","MIDDLESCROLL")
                setProperty("middlescrollText.alpha",.5)

                setTextString("ghostTappingText","GHOST TAPPING")
                setProperty("ghostTappingText.alpha",.5)

                setTextString("ExitText","< EXIT >")
                setProperty("ExitText.alpha",1)

                setTextString("descriptionText","Exit. You can also exit by pressing the escape or back key.")
                setProperty("checkmark.alpha",0)
            end

            if enter and OptionsSelect == 1 and SettingsIsLoaded and canEnter then
                canEnter = false
                runTimer("enterCooldown",.5)
                playSound("confirmMenu", 0.7)
                SettingsChanged = true
                if downscroll then
                    setPropertyFromClass('backend.ClientPrefs', 'data.downScroll', false)
                    downscroll = false
                else
                    setPropertyFromClass('backend.ClientPrefs', 'data.downScroll', true)
                    downscroll = true
                end
            elseif enter and OptionsSelect == 2 and SettingsIsLoaded and canEnter then
                canEnter = false
                runTimer("enterCooldown",.5)
                playSound("confirmMenu", 0.7)
                SettingsChanged = true
                if middlescroll then
                    setPropertyFromClass('backend.ClientPrefs', 'data.middleScroll', false)
                    middlescroll = false
                else
                    setPropertyFromClass('backend.ClientPrefs', 'data.middleScroll', true)
                    middlescroll = true
                end
            elseif enter and OptionsSelect == 3 and SettingsIsLoaded and canEnter then
                canEnter = false
                runTimer("enterCooldown",.5)
                playSound("confirmMenu", 0.7)
                SettingsChanged = true
                if ghostTapping == true then
                    ghostTapping = false
                    setPropertyFromClass('backend.ClientPrefs', 'data.ghostTapping', false)
                    setTextString("descriptionText","If enabled, you won't get misses from pressing keys while there are no notes able to be hit. This feature is currently enabled.")
                else
                    ghostTapping = true
                    setTextString("descriptionText","If enabled, you won't get misses from pressing keys while there are no notes able to be hit. This feature is currently disabled.")
                    setPropertyFromClass('backend.ClientPrefs', 'data.ghostTapping', true)
                end
            elseif enter and OptionsSelect == 4 and SettingsIsLoaded and canEnter then
                if SettingsChanged then
                    playSound("scrollMenu",.7)
                    runHaxeCode([[
                        ClientPrefs.saveSettings(); 
                    ]])
                    restartSong()
                else
                    InSettings = false
                    playSound("scrollMenu",.7)
                    closeSettings()

                    canEnter = false
                    runTimer("enterCooldown",enterCooldown)
                end
            end

            if keyJustPressed("back") and SettingsChanged then
                playSound("scrollMenu",.7)
                runHaxeCode([[
                    ClientPrefs.saveSettings(); 
                ]])
                restartSong()
            elseif keyJustPressed("back") and SettingsChanged == false then
                playSound("scrollMenu",.7)
                closeSettings()
                InSettings = false
                canEnter = false
                runTimer("enterCooldown",enterCooldown)
            end
        end

        -- logic for changing selected option
        if up and not InSettings then
            playSound("scrollMenu", 0.7)
            selectedOption = selectedOption - 1
        elseif down and not InSettings then
            playSound("scrollMenu", 0.7)
            selectedOption = selectedOption + 1
        elseif selectedOption < 1 then
            selectedOption = 5
        elseif selectedOption > 5 then
            selectedOption = 1
        end

	if luaSpriteExists("ResumeText") then
        if selectedOption == 1 then
            SelectOption1()
        elseif selectedOption == 2 then
            SelectOption2()
        elseif selectedOption == 3 then
            SelectOption3()
        elseif selectedOption == 4 then
            SelectOption4()
        elseif selectedOption == 5 then
            SelectOption5()
        end
     end

        if enter and selectedOption == 1 and not InSettings and canEnter then
            canEnter = false
            runTimer("enterCooldown",enterCooldown)

             if Settings.MobilePort then
                setProperty("enterB.scale.x",.5)
                setProperty("enterB.scale.y",.5)

                doTweenX("enterInX","enterB.scale",.7,.15,"circOut")
                doTweenY("enterBInY","enterB.scale",.7,.15,"circOut")
            end

            closeSubstate(false)
            playSound("confirmMenu", 0.7)
            function onTimerCompleted(tag, loops, loopsLeft)
                if tag == "closeSubstate" then
                    closeCustomSubstate()
                end
            end
        elseif enter and selectedOption == 2 and not InSettings and canEnter then
            canEnter = false
            stopSound("pauseMusic")
            restartSong()
        elseif enter and selectedOption == 3 and not InSettings and canEnter then
            canEnter = false
            runTimer("enterCooldown",enterCooldown)

             if Settings.MobilePort then
                setProperty("enterB.scale.x",.5)
                setProperty("enterB.scale.y",.5)
                
                doTweenX("enterInX","enterB.scale",.7,.15,"circOut")
                doTweenY("enterBInY","enterB.scale",.7,.15,"circOut")
            end

            playSound("confirmMenu", 0.7)
            if getModSetting("Custom_settings", modFolderName) == true then
                InSettings = true 
                openSettings()
                OptionsSelect = 1
            else
                runHaxeCode([[
                    import backend.MusicBeatState;
                    import options.OptionsState;
                
                    MusicBeatState.switchState(new OptionsState());
                    if (ClientPrefs.data.pauseMusic != 'None') {
                        FlxG.sound.playMusic(Paths.music(Paths.formatToSongPath(ClientPrefs.data.pauseMusic)), 0);
                        FlxTween.tween(FlxG.sound.music, {volume: 1}, 0.8);
                    }
                    OptionsState.onPlayState = true;
                ]])
            end
        elseif enter and selectedOption == 4 and not InSettings and canEnter then
            canEnter = false
            runTimer("enterCooldown",enterCooldown)

             if Settings.MobilePort then
                setProperty("enterB.scale.x",.5)
                setProperty("enterB.scale.y",.5)
                
                doTweenX("enterInX","enterB.scale",.7,.15,"circOut")
                doTweenY("enterBInY","enterB.scale",.7,.15,"circOut")
            end

            closeSubstate(true)
            playSound("confirmMenu", 0.7)
            function onTimerCompleted(tag, loops, loopsLeft)
                if tag == "closeSubstate" then
                    runHaxeCode([[
                        import backend.MusicBeatState;
                        import states.editors.ChartingState;
                        MusicBeatState.switchState(new ChartingState());
                    ]])
                end
            end
        elseif enter and selectedOption == 5 and not InSettings and canEnter then
            if Settings.MobilePort then
                setProperty("enterB.scale.x",.5)
                setProperty("enterB.scale.y",.5)
                
                doTweenX("enterInX","enterB.scale",.7,.15,"circOut")
                doTweenY("enterBInY","enterB.scale",.7,.15,"circOut")
            end
            exitSong()
            stopSound("pauseMusic")
        end
    end
end

function openSettings()
    closeSubstate(false,true)
    function onTimerCompleted(tag, loops, loopsLeft)

        if tag == "closeSubstate" then
            SettingsIsLoaded = true
            
            setObjectOrder("downB",999)
            setObjectOrder("enterB",999)
            setObjectOrder("upB",999)

            removeLuaSprite("black")
            removeLuaSprite("background")
            removeLuaSprite("blackLineSong")
            removeLuaSprite("ResumeText")
            removeLuaSprite("RestartText")
            removeLuaSprite("SettingsText")
            removeLuaSprite("ChartEditorText")
            removeLuaSprite("ExitText")
            removeLuaSprite("Disk")
            removeLuaSprite("TitleSongtText")
            removeLuaSprite("DifficuiltyText")
            removeLuaSprite("whiteLine")
            removeLuaSprite("OpponentIcon")
            removeLuaSprite("blackLine")              

            -- halftome 1

            makeLuaSprite("halftone","pauseMenu/halftoneBg")
            setProperty("halftone.alpha",0)
            setProperty("halftone.x",-850)
            setProperty("halftone.angle",90)
            scaleObject("halftone",1.2,1.2)

            -- halftome 2

            makeLuaSprite("halftone2","pauseMenu/halftoneBg")
            setProperty("halftone2.alpha",0)
            setProperty("halftone2.x",658)
            setProperty("halftone2.angle",-90)
            scaleObject("halftone2",1.2,1.2)


            -- Cherckmark

            makeAnimatedLuaSprite("checkmark","pauseMenu/Checkmark",0,0)
            addAnimationByPrefix("checkmark","Checkmark","Checkmark",24,false)
            addAnimationByPrefix("checkmark","Checkmark_cancel","Checkmark_cancel",24,false)
            scaleObject("checkmark",.3,.3)
            setObjectCamera("checkmark","other")
            screenCenter("checkmark","x")
            setProperty("checkmark.y",670)

            --Settings Title

            makeLuaText("SettingsTitle","SETTINGS",0,520,0)
            setTextSize("SettingsTitle",120)
            setProperty("SettingsTitle.alpha",0)
            setTextAlignment("SettingsTitle","center")
            scaleObject("SettingsTitle",.4,.4)
            setObjectCamera("SettingsTitle","other")

            --downscroll

            makeLuaText("downscrollText","DOWNSCROLL",1280,0,-50)
            setTextFont("downscrollText",settingsFont)
            setTextSize("downscrollText",50)
            setObjectCamera("downscrollText","other")
            setTextAlignment("downscrollText","center")

            --Middlescroll

            makeLuaText("middlescrollText","MIDDLESCROLL",1280,0,-50)
            setTextFont("middlescrollText",settingsFont)
            setTextSize("middlescrollText",50)
            setObjectCamera("middlescrollText","other")
            setTextAlignment("middlescrollText","center")

            --Ghost Tapping

            makeLuaText("ghostTappingText","GHOST TAPPING",1280,0,-50)
            setTextFont("ghostTappingText",settingsFont)
            setTextSize("ghostTappingText",50)
            setObjectCamera("ghostTappingText","other")
            setTextAlignment("ghostTappingText","center")


            -- Exit

            makeLuaText("ExitText","EXIT",1280,0,-50)
            setTextFont("ExitText",settingsFont)
            setTextSize("ExitText",50)
            setObjectCamera("ExitText","other")
            setTextAlignment("ExitText","center")

            --Description bg

            makeLuaSprite("descriptionBg")
            makeGraphic("descriptionBg",700,35,"0xFF000000")
            setProperty("descriptionBg.alpha",.5)
            setObjectCamera("descriptionBg","other")
            screenCenter("descriptionBg","x")
            setProperty("descriptionBg.y",615)

            --Description text

            makeLuaText("descriptionText","Description",700,35,620)
            setTextSize("descriptionText",15)
            screenCenter("descriptionText","x")
            setObjectCamera("descriptionText","other")
            setTextAlignment("descriptionText","center")

            --up line

            makeLuaSprite("upLine",0,0)
            makeGraphic("upLine",1280,60,"0xFF000000")
            setObjectCamera("upLine","other")

            --down line

            makeLuaSprite("downLine",0,0)
            makeGraphic("downLine",1280,60,"0xFF000000")
            setProperty("downLine.y",660)
            setObjectCamera("downLine","other")

            -- bg

            makeLuaSprite("backScreen","pauseMenu/Backgrounds/"..getModSetting("Pause_bg_color", modFolderName))
            
            setObjectCamera("backScreen", "other")
            setProperty("backScreen.alpha", 0)

            -----------------------------------

            setObjectOrder("backScreen", 11)
            setObjectOrder("downscrollText",16)
            setObjectOrder("upLine",20)
            setObjectOrder("downLine",20)
            setObjectOrder("SettingsTitle",25)
            setObjectOrder("checkmark",25)
            setObjectOrder("middlescrollText",16)
            setObjectOrder("descriptionBg",19)
            setObjectOrder("ExitText",16)
            setObjectOrder("ghostTappingText",16)
            setObjectOrder("descriptionText",22)
            setObjectOrder("halftone",12)
            setObjectOrder("halftone2",12)

            addLuaSprite("backScreen")
            addLuaSprite("upLine")
            addLuaSprite("downLine")
            addLuaSprite("descriptionBg")
            addLuaSprite("checkmark")
            addLuaSprite("halftone")
            addLuaSprite("halftone2")

            addLuaText("SettingsTitle")
            addLuaText("downscrollText")
            addLuaText("middlescrollText")
            addLuaText("ExitText")
            addLuaText("ghostTappingText")
            addLuaText("descriptionText")

            insertToCustomSubstate("backScreen")
            insertToCustomSubstate("SettingsTitle")
            insertToCustomSubstate("halftone")
            insertToCustomSubstate("halftone2")
            insertToCustomSubstate("upLine")
            insertToCustomSubstate("downLine")
            insertToCustomSubstate("downscrollText")
            insertToCustomSubstate("middlescrollText")
            insertToCustomSubstate("descriptionBg")
            insertToCustomSubstate("ExitText")
            insertToCustomSubstate("ghostTappingText")
            insertToCustomSubstate("descriptionText")
            insertToCustomSubstate("checkmark")

            if getModSetting("Bg_in_settings", modFolderName) == true then
                doTweenAlpha("BackScreenAlpha", "backScreen", 1, .8, "circOut")
            end
            doTweenAlpha("SettingsTitleAplha", "SettingsTitle", 1, .8, "circOut")

            doTweenY("downscrollTextTweenY","downscrollText",70 + settingsTextYOffset,.5,"circOut")
            doTweenY("middlescrollTextTweenY","middlescrollText",130 + settingsTextYOffset,.5,"circOut")
            doTweenY("ghostTappingTextTweenY","ghostTappingText",190 + settingsTextYOffset,.5,"circOut")
            doTweenY("ExitTextTweenY","ExitText",500 + settingsTextYOffset,.5,"circOut")

            function onTimerCompleted(tag, loops, loopsLeft)
                if tag == "beatTimer" then
                    setProperty("upLine.scale.y",1.2)
                    setProperty("downLine.scale.y",1.2)

                    doTweenY("upLineY","upLine.scale",1,.4,"circOut")
                    doTweenY("downLineY","downLine.scale",1,.4,"circOut")
                end
                if tag == "enterCooldown" then
                    canEnter = true
                end
            end
        end
    end
end

function closeSettings()
    SettingsIsLoaded = false
    removeLuaSprite("backScreen")
    removeLuaSprite("SettingsTitle")
    removeLuaSprite("upLine")
    removeLuaSprite("downLine")
    removeLuaSprite("downscrollText")
    removeLuaSprite("middlescrollText")
    removeLuaSprite("descriptionBg")
    removeLuaSprite("ExitText")
    removeLuaSprite("ghostTappingText")
    removeLuaSprite("descriptionText")
    removeLuaSprite("checkmark")
    removeLuaSprite("halftone")
    removeLuaSprite("halftone2")
    openSubstate(true)
end

function onSoundFinished(tag)
    if tag == "pauseMusic" then
        if getModSetting("Music_on_pause", modFolderName) == "Song Instrumental" and getModSetting("Music_on_pause", modFolderName) then
            soundBPM = getPropertyFromClass("backend.Conductor", "bpm")
            if checkFileExists("songs/" .. songPath .. "/Inst.ogg") then
                if getModSetting("Music_on_pause", modFolderName) ~= "None" then
                    playSound("../songs/" .. songPath .. "/Inst", 0, "pauseMusic")
                    soundFadeIn("pauseMusic", .5, 0, .4)
                end
            else
                if getModSetting("Music_on_pause", modFolderName) ~= "None" then
                    playSound("../../../assets/songs/" .. songPath .. "/Inst", 0, "pauseMusic")
                    soundFadeIn("pauseMusic", .5, 0, .4)
                end
            end
            --setSoundTime("pauseMusic", getSongPosition())
        else
            if getModSetting("Music_on_pause", modFolderName) ~= "None" then
                playSound("pauseMusic/" .. getModSetting("Music_on_pause", modFolderName), 0, "pauseMusic")
                soundFadeIn("pauseMusic", .5, 0, .4)
            end
            soundBPM = BPMTable[getModSetting("Music_on_pause", modFolderName)]
        end
    end
end