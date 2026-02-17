function onCreate()
	makeLuaSprite('redVG', 'bg/redThing', 0, 0)
    	setObjectCamera('redVG', 'camHUD')
     	scaleObject('redVG', 1, 1);
    	setProperty('redVG.alpha', 0.0001)
    	addLuaSprite('redVG', true)
end

function onUpdate()
	if curStep == 1280 then	
		runTimer('fadeIN', 0.0001)
	end
end

function onTimerCompleted(tag)
	if tag == 'fadeIN' then
        	doTweenAlpha('RedTween1','redVG', 1, 0.8, 'linear')
	elseif tag == 'fadeOUT' then
        	doTweenAlpha('RedTween2', 'redVG', 0, 1, 'linear')
	end
end

function onTweenCompleted(tag)
	if tag == 'RedTween1' then
		runTimer('fadeOUT', 0.4)
	elseif tag == 'RedTween2' then
		runTimer('fadeIN', 0.4)
	end
end