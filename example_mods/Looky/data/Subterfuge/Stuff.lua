function onCreate()
     	makeLuaSprite('blackBorder', 'vig_Black', 0, 0)
     	setScrollFactor('blackBorder', 0, 0);
     	scaleObject('blackBorder', 1, 1);
     	setObjectCamera('blackBorder', 'camHUD')
     	setProperty('blackBorder.alpha', 0.65)
     	addLuaSprite('blackBorder', true)

     	makeLuaSprite('blacks', null, 0, 0)
     	makeGraphic('blacks', 2500, 2500, '000000')
     	setScrollFactor('blacks', 0, 0);
     	scaleObject('blacks', 2, 2);
     	setObjectCamera('blacks', 'camHUD')
     	setProperty('blacks.alpha', 1)
     	addLuaSprite('blacks', false)

     	makeLuaSprite('blacks2', null, 0, 0)
     	makeGraphic('blacks2', 2500, 2500, '000000')
     	setScrollFactor('blacks2', 0, 0);
     	scaleObject('blacks2', 2, 2);
     	setObjectCamera('blacks2', 'other')
     	setProperty('blacks2.alpha', 0.0001)
     	addLuaSprite('blacks2', false)

     	makeLuaSprite('lordXBalls', 'bg/lordSex', 50, 0)
     	setScrollFactor('lordXBalls', 0, 0);
     	scaleObject('lordXBalls', 2.4, 2);
     	setObjectCamera('lordXBalls', 'other')
     	setProperty('lordXBalls.alpha', 0.0001)
     	addLuaSprite('lordXBalls', false)

     	setProperty('healthBar.alpha', 0.0001)	
     	setProperty('scoreTxt.alpha', 0.0001)
     	setProperty('iconP1.alpha', 0.0001)	
     	setProperty('iconP2.alpha', 0.0001)

	for i = 0, getProperty('unspawnNotes.length')-1 do
		setPropertyFromGroup('unspawnNotes', i, 'rgbShader.enabled', false)
	end
end

function onUpdatePost()
     	setProperty('timeBar.alpha', 0.0001)	
     	setProperty('timeTxt.alpha', 0.0001)
	for i = 0,3 do
		setPropertyFromGroup('strumLineNotes', i, 'x', -400)
    	end
end

function onStepHit()
	if curStep == 16 then
		cameraFlash('other', white, 0.8, true)
     		setProperty('healthBar.alpha', 1)	
     		setProperty('scoreTxt.alpha', 1)
     		setProperty('iconP1.alpha', 1)
     		setProperty('iconP2.alpha', 1)
	     	setProperty('blacks.alpha', 0.0001)
	end
	if curStep == 272 then
		doTweenAlpha('Tween1', 'blacks', 1, 1, 'quadOut')
	end
	if curStep == 280 then
		setProperty('camZooming', false)
	end
	if curStep == 288 then
		setProperty('camZooming', true)
		setProperty('blacks2.alpha', 1)
	end
	if curStep == 304 then
		setProperty('blacks2.alpha', 0.8)
	end
	if curStep == 308 then
		setProperty('blacks2.alpha', 0.6)
	end
	if curStep == 312 then
		setProperty('blacks2.alpha', 0.4)
	end
	if curStep == 316 then
		setProperty('blacks2.alpha', 0.0001)
	end
	if curStep == 320 then
		setProperty('blacks.alpha', 0.0001)	
	end
	if curStep == 416 then
		doTweenAlpha('Tween2', 'blacks', 1, 1, 'quadOut')
	end
	if curStep == 448 then
		setProperty('blacks.alpha', 1)	
	end
	if curStep == 452 then
		setProperty('blacks.alpha', 0.0001)	
	end
	if curStep == 1008 then
		doTweenAlpha('TweenBalls', 'lordXBalls', 0.66, 80)
	end
	if curStep == 1216 then
		doTweenAlpha('Tween3', 'blacks', 1, 1, 'quadOut')
		setProperty('lordXBalls.alpha', 0.0001)	
		doTweenAlpha('TweenBalls', 'lordXBalls', 0.0001, 0.0001)
	end
	if curStep == 1280 then
		setProperty('blacks.alpha', 0.0001)	
	end
	if curStep == 1520 then
		setProperty('blacks.alpha', 1)	
	end
	if curStep == 1536 then
		setProperty('blacks.alpha', 0.0001)	
	end
	if curStep == 1791 then
		doTweenAlpha('Tween4', 'blacks2', 1, 3.2, 'quadOut')	
	end
end





