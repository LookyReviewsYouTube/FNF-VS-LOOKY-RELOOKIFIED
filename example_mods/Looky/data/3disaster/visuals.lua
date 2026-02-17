local posS = {-100, 720}
local posV = {-30, 660}
local cinemaOn = false
function onCreate()
	for i=1,2 do
		makeLuaSprite('cinemaBar'..i, nil, 0, posS[i])
		makeGraphic('cinemaBar'..i, screenWidth, 100, '000000')
		setObjectCamera('cinemaBar'..i, 'other')
		addLuaSprite('cinemaBar'..i)
		--setProperty('bar'..i..'.x', -75)
	end
end

function onUpdate(elapsed)
	if cinemaOn then
		for i=1,2 do
			setProperty('cinemaBar'..i..'.y', lerp(getProperty('cinemaBar'..i..'.y'), posV[i], elapsed))
		end
	else
		for i=1,2 do
			setProperty('cinemaBar'..i..'.y', lerp(getProperty('cinemaBar'..i..'.y'), posS[i], elapsed))
		end
	end
end

function onChange()
	if cinemaOn then
		cinemaOn = false
		setProperty('ratings.alpha', 1)
		doTweenAlpha('ratingsin', 'ratings', 1, 0.3, 'linear')
	else
		cinemaOn = true
		doTweenAlpha('ratingsout', 'ratings', 0, 0.5, 'linear')
	end
end

function lerp(a, b, ratio)
	return a + ratio * (b - a)
end

function onStepHit()
    if curStep == 389 or curStep == 512 then
            onChange()
    end
end