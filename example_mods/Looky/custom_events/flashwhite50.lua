function onCreatePost()
    makeLuaSprite('flas', '', 0, 0)
    makeGraphic('flas', screenWidth, screenHeight, 'FFFFFF')
    if version >= '1.0.0' then
        setProperty('flas.camera', instanceArg('camOther'), false, true)
    else
        setObjectCamera('flas','camOther')
    end
    setProperty('flas.alpha', 0.001)
    setObjectOrder('flas', 0)
    addLuaSprite('flas', false)
end

function onEvent(n, v1, v2)
    if n == 'flashwhite50' then
        se = 7 or v1
        setProperty('flas.alpha', 0.34)
        doTweenAlpha('flasadsu', 'flas', 0, stepCrochet * 0.001 * se, 'linear')
    end
end