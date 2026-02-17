showMode = false
centerCam = false centerX = 550 centerY = 300
thisCameraSystem = true
local isHardmode = false

function onCreatePost()
    isHardmode = false

    luaDebugMode = true 
    makeLuaSprite("middleGlow", "ammarvoid/GreenGradientMiddle",-1450 ,-200)
    scaleObject("middleGlow", 3, 1.5)
    addLuaSprite("middleGlow")
    setProperty("middleGlow.alpha", 0.05)
    setScrollFactor("middleGlow", 0.6, 0.6)

    makeLuaSprite("bottomGlow", "ammarvoid/GreenGradientBottom",-500 ,200)
    scaleObject("bottomGlow", 2, 1.1)
    addLuaSprite("bottomGlow", true)
    setProperty("bottomGlow.alpha", 0)
    setScrollFactor("bottomGlow", 0.0, 0.0)
    setBlendMode("bottomGlow", "add")

    makeLuaSprite("middleGlowOverlay", "ammarvoid/GreenGradientMiddle",-1450 ,-1200)
    scaleObject("middleGlowOverlay", 7, 7)
    addLuaSprite("middleGlowOverlay", true)
    setProperty("middleGlowOverlay.alpha", 0.05)
    setScrollFactor("middleGlowOverlay", 0.6, 0.6)
    setBlendMode("middleGlowOverlay", "add")

    makeLuaSprite("bfOverlay", "", -300 , -300)
    makeGraphic("bfOverlay", 1400, 900, "DC000F")
    addLuaSprite("bfOverlay", true)
    setScrollFactor("bfOverlay", 0, 0)
    scaleObject("bfOverlay", 1.54, 1.5, true)
    setBlendMode("bfOverlay", "multiply")
    setProperty("bfOverlay.alpha", 0)

    runHaxeCode([[
        setVar('particleAmount', 0);
        setVar('particleSpeed', 0);
        setVar('showMode', false);
    ]])

    setProperty('particleAmount', 0)
    setProperty('particleSpeed', 0)
end

local targetCamX, targetCamY = 0, 0

local thingLerp = 1
function onUpdate(elapsed)
    if not inGameOver and not getProperty('isCameraOnForcedPos') and thisCameraSystem then
        if centerCam then
            setProperty("camFollow.x", centerX + math.sin(getSongPosition()/500)*5)
            setProperty("camFollow.y", centerY + math.cos(getSongPosition()/700)*5)
        else
            setProperty("camFollow.x", targetCamX + math.sin(getSongPosition()/500)*30)
            setProperty("camFollow.y", targetCamY + math.cos(getSongPosition()/700)*30)
        end
    end
end


local particleID = 0
function createBackParticle(amount, multSpeed)
    for i = 0, amount do
        particleID = particleID + 1
        local tag = "particleBGBack"..particleID
        makeLuaSprite(tag, "", getRandomFloat(-900, 2270), getRandomFloat(850, 900))
        makeGraphic(tag, 20, 20, "DC000F")
        addLuaSprite(tag, true)
        setBlendMode(tag, "add")

        setProperty(tag..".alpha", 0.85)
        setProperty(tag..".angle", getRandomFloat(0, 89))
        doTweenY(tag, tag, getProperty(tag..".y") - getRandomFloat(150, 400), 2 * (multSpeed or 1), "quadOut")
        doTweenAlpha("partAlphaB"..particleID, tag, 0, 2 * (multSpeed or 1))
    end
end


function onTweenCompleted(tag)
    if string.find(tag, "particleBGBack") then
        removeLuaSprite(tag, true)
    end
end

function onMoveCamera(character)
    if thisCameraSystem then
        if showMode or getProperty('showMode') and not getProperty('isCameraOnForcedPos')  then
            if character == "dad" then
                --setProperty("camFollow.x", getProperty("camFollow.x") + 300)
                setProperty("camFollow.x", 230.5)
            else
                --setProperty("camFollow.x", getProperty("camFollow.x") - 360)
                setProperty("camFollow.x", 917.5)
            end
        else
            if character == "dad" then
                --setProperty("camFollow.x", getProperty("camFollow.x") + 300)
                --setProperty("camFollow.x", 230.5)
                setProperty("camFollow.x", -92)
            else
                setProperty("camFollow.x", 1275.5)
            end
        end

        targetCamX, targetCamY = getProperty("camFollow.x"), getProperty("camFollow.y")
    end
end