st, h, combo, valCombo = true, 50, 0, 50

local hiddenElements = {'timeTxt', 'timeBar', 'botplayTxt'}
local iconElements = {'iconP1', 'iconP2'}
local comboOffset = {0, 0}

function onCountdownStarted()
    setObjectOrder('noteGroup', getObjectOrder('uiGroup') + 92)
    setObjectOrder('comboGroup', getObjectOrder('boyfriendGroup') + 4)
    if version >= '1.0.0' then
        setProperty('comboGroup.camera', instanceArg('camGame'), false, true)
    else
        setObjectCamera('comboGroup','camGame')
    end
    setScrollFactor('comboGroup', 0.7, 0.7)

    makeLuaSprite('FCsprite', 'FC', 0, getProperty('healthBar.y') - 30)
    scaleObject('FCsprite', 0.5, 0.5, false)
    addLuaSprite('FCsprite', true)
    if version >= '1.0.0' then
        setProperty('FCsprite.camera', instanceArg('camHUD'), false, true)
    else
        setObjectCamera('FCsprite','camHUD')
    end
    setObjectOrder('FCsprite', getObjectOrder('uiGroup') + 1)
    setProperty('FCsprite.visible', true) 

    for i = 1, #hiddenElements do
        setProperty(hiddenElements[i] .. '.visible', false)
    end

    setTextSize('scoreTxt', 17)
    setTextFont('scoreTxt', 'FNF.ttf')
    callMethod('scoreTxt.setPosition', {155, downscroll and 105 or 670})
    setTextBorder('scoreTxt', 3, '000000')

    setTextBorder('botplayTxt', 9, '000000')
    setTextFont('botplayTxt', 'FNF.ttf')

    comboOffset[1] = getPropertyFromClass('backend.ClientPrefs', 'data.comboOffset[0]')
    comboOffset[2] = getPropertyFromClass('backend.ClientPrefs', 'data.comboOffset[1]')
end

function onUpdateScore()
    setTextString('scoreTxt', 'Score: ' .. callMethodFromClass('flixel.util.FlxStringUtil', 'formatMoney', {score, false}))
end

function onUpdatePost(e)
    h = math.min(lerp(h, getProperty('healthBar.percent'), e * 4.5))
    setProperty('healthBar.percent', h)
    
    local healthBarX = getProperty('healthBar.x')
    setProperty('FCsprite.x', healthBarX + 562 - (h * 6))
    
    local healthBarMidX = getMidpointX('healthBar')
    setProperty('iconP1.x', healthBarMidX + 324)
    setProperty('iconP2.x', healthBarMidX - 474)
    
    for i = 1, #iconElements do
        setProperty(iconElements[i] .. '.origin.y', 0)
    end
end
function onBeatHit()
    local s = curBeat % 2 == 0 and 0.85 or 1.2
    
    scaleObject('iconP1', s, s, false)
    scaleObject('iconP2', 2 - s, 2 - s, false)
end

function goodNoteHit(_, _, _, s)
    combo = not s and combo + 1
    st = false 
    runTimer('sh', 0.4)
    
    local character = gfNote and 'gf' or 'boyfriend'
    local charGroup = character .. 'Group'
    
    callMethod('comboGroup.setPosition', {
        getProperty(charGroup .. '.x') + comboOffset[1] - 850,
        getProperty(charGroup .. '.y') + comboOffset[2] - 250
    })
    
    if combo == valCombo then
        playAnim('gf', combo >= 200 and gfName == 'nene' and 'fawn' or 'cheer', true)
        setProperty('gf.specialAnim', true)
        valCombo = valCombo * 2
    end
end

function onTimerCompleted(t) 
    if t == 'sh' then st = true end 
end

function lerp(a, b, t) 
    return a + (b - a) * t 
end

function noteMiss()
    if combo >= 50 then 
        playAnim('gf', 'sad', true)
        setProperty('gf.specialAnim', true)
        combo = 0
        valCombo = 50
    end
    setProperty('FCsprite.visible', false) 
    
    if not st then 
        playSound('missnote' .. math.random(1, 3), 0.45) 
    end 
end

function opponentNoteHit(_, _, _, isSustain) 
    if not isSustain and getHealth('health') > 0.2 then 
        setProperty('health', getHealth('health') - 0.016) 
    end 
end

function onKeyPress(k) 
    if st then 
        playAnim('boyfriend', getProperty('singAnimations')[k + 1], true) 
    end 
end