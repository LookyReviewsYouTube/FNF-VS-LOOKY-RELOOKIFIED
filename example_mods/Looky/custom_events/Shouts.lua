function onEvent(tag, v1, v2)
    if tag == 'Shouts' then
        if v1 == 'objection' then
            cameraFlash('other', 'FFFFFF', '0.2', true)
            makeAnimatedLuaSprite('objection', 'ui/objection', 0, 0)
            scaleObject('objection', 3, 3)
            screenCenter('objection', 'xy')
            setObjectCamera('objection', 'other')
            setProperty('objection.antialiasing', false)
            addAnimationByIndices('objection', 'shout', 'objection idle', '0, 1, 2, 3, 4, 5, 6, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8', 24)
            addLuaSprite('objection', true)
            playAnim('objection', 'shout', true)
        elseif v1 == 'hold it' then
            cameraFlash('other', 'FFFFFF', '0.2', true)
            makeAnimatedLuaSprite('holdit', 'ui/hold it', 0, 0)
            scaleObject('holdit', 3, 3)
            screenCenter('holdit', 'xy')
            setObjectCamera('holdit', 'other')
            setProperty('holdit.antialiasing', false)
            addAnimationByIndices('holdit', 'shout', 'hold it idle', '0, 1, 2, 3, 4, 5, 6, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8', 24)
            addLuaSprite('holdit', true)
            playAnim('holdit', 'shout', true)
        elseif v1 == 'not guilty' then
            makeAnimatedLuaSprite('notguilty', 'ui/not guilty', 0, 0)
            scaleObject('notguilty', 3.5, 3.5)
            screenCenter('notguilty', 'xy')
            setObjectCamera('notguilty', 'other')
            setProperty('notguilty.antialiasing', false)
            addAnimationByIndices('notguilty', 'not', 'not guilty idle', '0, 0,1,1, 2,2, 3,3, 4,4, 5,5, 6,6, 7,7, 8,8, 9,9, 10,10', 48)
            addAnimationByIndices('notguilty', 'guilty', 'not guilty idle', '11, 11, 12, 12, 13, 13, 14, 14, 15, 15, 16, 16, 17, 17, 18, 18, 19, 19, 20, 20, 21, 21', 48)
            addLuaSprite('notguilty', true)
        end
        if v2 == 'not' then
            playAnim('notguilty', v2, true)
        elseif v2 == 'guilty' then
            playAnim('notguilty', v2, true)
        elseif v2 == 'delete' then
            startTween('fadeoutnotguilty', 'notguilty', {alpha = 0, ['scale.x'] = 3.8, ['scale.y'] = 3.8}, 0.5, {ease = 'quartIn', onComplete = 'onTweenCompleted'})
        end
    end
end

lolnames = {'objection', 'holdit'}
function onUpdate(elapsed)
    for i = 0, #lolnames do
        if getProperty(lolnames[i+1] .. '.animation.curAnim.finished') then
            removeLuaSprite(lolnames[i+1], true)
        end
    end
end

function onTweenCompleted(tag)
    if tag == 'fadeoutnotguilty' then
        removeLuaSprite('notguilty', true)
    end
end