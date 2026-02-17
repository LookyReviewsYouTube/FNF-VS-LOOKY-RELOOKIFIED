function onCreate()
     	makeLuaSprite('bg1', 'bg/exesky', -1700, -1700)
     	setScrollFactor('bg1', 0.5, 0.5);
     	scaleObject('bg1', 2.4, 2.4);
     	setProperty('bg1.alpha', 1)
     	addLuaSprite('bg1', false)

     	makeLuaSprite('bg2', 'bg/ground', -800, 625)
     	setScrollFactor('bg2', 1, 1);
     	scaleObject('bg2', 2, 2);
     	setProperty('bg2.alpha', 1)
     	addLuaSprite('bg2', false)

     	makeLuaSprite('bg3', 'bg/ohLookABlackHol-AAAAAAAAAAAAAAAAAAAAAAA', -850, -1400)
     	setScrollFactor('bg3', 1, 1);
     	scaleObject('bg3', 2, 2);
     	setProperty('bg3.alpha', 0.0001)
     	addLuaSprite('bg3', false)

	makeAnimatedLuaSprite('static1', 'bg/STATIC', 0, 0);
        addAnimationByPrefix('static1', 'cannella', 'staticBackground', 24, true);
	setObjectCamera('static1', 'camHUD')
	setProperty('static1.alpha', 0.0001)
	setProperty('static1.visible', false);
	scaleObject('static1', 1, 1);
	addLuaSprite('static1', true)
end

function onUpdatePost()
     	setProperty('gf.alpha', 0)
end

function onStepHit()
	if curStep == 1 then
		objectPlayAnimation('static1', 'cannella', false);
		setProperty('static1.visible', true);
		doTweenAlpha('staticTween1', 'static1', 1, 3.5, 'quadInOut')
	end
	if curStep == 16 then
		setProperty('static1.visible', false);
	end
	if curStep >= 1280 then
		setProperty('boyfriend.visible', false);
		setProperty('boyfriend.x', getProperty('boyfriend.x'));
		setProperty('boyfriend.y', getProperty('boyfriend.y'));
		--cameraSetTarget('dad')
	end
	if curStep == 1280 then
     		setProperty('bg1.alpha', 0.0001)
     		setProperty('bg2.alpha', 0.0001)
     		setProperty('bg3.alpha', 1)
	end
end

