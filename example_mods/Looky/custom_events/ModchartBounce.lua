--Made by BlueColorsin#5597
--Inspired by Soulless DX

function onCreatePost()
    C4 = crochet / 1000 * (0.75)
	C1 = crochet / 1000 * (0.25)
    value1 = (downscroll and 23.2 or 584.8)
    value2 = (downscroll and -1.8 or 559.8)

    value3 = (downscroll and 8.2 or 569.8)
end

function onBeatHit()
    if bouncey == true then --Yes I did this cause I hate naming things
        doTweenY('OkaySoyeah', 'camHUD', 15, C1, 'sineIn')
        if icoBouncey == true then
            doTweenY(RNG(), 'iconP1', value1, C1, 'sineIn')
            doTweenY(RNG(), 'iconP2', value1, C1, 'sineIn')
        end
    else
        if TimesLol2 == 2 then
            doTweenAngle(RNG(), 'camHUD', 0, C4)
            doTweenAngle(RNG(), 'iconP1', 0, C4)
            doTweenAngle(RNG(), 'iconP2', 0, C4)
        end
        TimesLol2 = 1
    end
end

TimesLol = 0
function onTweenCompleted(tag)
    if tag == 'OkaySoyeah' then
        if TimesLol == 2 then TimesLol = 0 end
        TimesLol = TimesLol + 1 
        doTweenY(RNG(), 'camHUD', 0, C4, 'sineOut')
        if icoBouncey == true then
            doTweenY(RNG(), 'iconP1', value2, C4, 'sineOut')
            doTweenY(RNG(), 'iconP2', value2, C4, 'sineOut')
        end

        if TimesLol == 1 then
            doTweenAngle(RNG(), 'camHUD', -0.5, C4)
            if icoBouncey == true then
                doTweenAngle(RNG(), 'iconP1', -3, C4)
                doTweenAngle(RNG(), 'iconP2', -3, C4)
            end
        elseif TimesLol == 2 then
            doTweenAngle(RNG(), 'camHUD', 0.5, C4)
            if icoBouncey == true then
                doTweenAngle(RNG(), 'iconP1', 3, C4)
                doTweenAngle(RNG(), 'iconP2', 3, C4)
            end
        end
    end
end


RNG = function () --returns a random number string
	return tostring(math.random())
end

function onEvent(tag, var1, var2)
    if tag == 'ModchartBounce' then 
        if var1:upper() == 'ON' then
            bouncey = true
        elseif var1:upper() == 'OFF' then
            bouncey = false
            TimesLol2 = 2
        end
        if var2:upper() == 'ON' then
            icoBouncey = true
        elseif var2:upper() == 'OFF' then
            icoBouncey = false
        end
    end
end