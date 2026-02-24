function onCreatePost()
    if not getProperty('blackbg') then
        makeLuaSprite('blackbg', nil, -5000, -5000)
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
    if name ~= 'Black' then return end

    local duration = tonumber(v2) or 4
    local bgAlpha = (v1 ~= 'off') and 0.7 or 0
    doTweenAlpha('bgTween', 'blackbg', bgAlpha, stepCrochet * 0.001 * duration, 'linear')

    if getProperty('boyfriend.exists') then
        local bfColor = (v1 == 'off' or v1 == 'bf' or v1 == 'both') and 'FFFFFF' or '000000'
        doTweenColor('bfColorTween', 'boyfriend', bfColor, stepCrochet * 0.001 * duration, 'linear')
    end
    if getProperty('dad.exists') then
        local dadColor = (v1 == 'off' or v1 == 'dad' or v1 == 'both') and 'FFFFFF' or '000000'
        doTweenColor('dadColorTween', 'dad', dadColor, stepCrochet * 0.001 * duration, 'linear')
    end
    if getProperty('gf.exists') then
        local gfColor = (v1 == 'off' or v1 == 'gf') and 'FFFFFF' or '000000'
        doTweenColor('gfColorTween', 'gf', gfColor, stepCrochet * 0.001 * duration, 'linear')
    end
end