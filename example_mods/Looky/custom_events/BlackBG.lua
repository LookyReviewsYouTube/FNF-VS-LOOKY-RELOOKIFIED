function onCreatePost()
    if not getProperty('blackbg') then
        makeLuaSprite('blackbg', nil, 0,0)
        makeGraphic('blackbg', screenWidth, screenWidth, '000001')
        setScrollFactor('blackbg', 0, 0)
        scaleObject('blackbg', 3.5, 3.5)
        setProperty('blackbg.alpha', 0)
        addLuaSprite('blackbg', false)
        screenCenter('blackbg', 'xy')
        setObjectOrder('blackbg', getObjectOrder('dadGroup')-2)
    end
end

function onEvent(name, v1, v2)
    if name == 'BlackBG' then
        for _, t in pairs({'ON', 'OFF'}) do
            cancelTween('bg'..t)
        end
        setObjectOrder('blackbg', getObjectOrder('dadGroup')-2)
        local targetAlpha = (v1 == 'on') and 0.8 or 0
        doTweenAlpha('bg'..v1:upper(), 'blackbg', targetAlpha, stepCrochet * 0.001 * v2)
    end
end