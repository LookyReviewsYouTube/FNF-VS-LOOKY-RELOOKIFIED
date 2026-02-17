local startTimer = 3 -- do not write 1 or less than 1 , 2 or 3 are recommended
local camCamera = 'hud' --hud or other
local tweenZaman = 1
otuzbir = {}
function lerp(a, b, ratio)
	return a + ratio * (b - a); --the funny lerp
end
function onSongStart()
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then

			notePoss = getPropertyFromGroup('unspawnNotes', i, 'strumTime')

	table.insert(otuzbir, notePoss)

en_kucuk = otuzbir[1]

end
end
        makeLuaText('kalanZaman', '1', 100,0,0)
        setObjectCamera('kalanZaman', camCamera)
	setTextSize('kalanZaman', 24)
        setProperty('kalanZaman.alpha',1)
	screenCenter('kalanZaman')
	addLuaText('kalanZaman',true)

	makeLuaSprite('arasBar','circleThing',0,0)
        setObjectCamera('arasBar',camCamera)
	scaleObject('arasBar',0.75,0.75)
	screenCenter('arasBar')
	addLuaSprite('arasBar', true)
	updateYer()
	setSpriteShader('arasBar',"cicrle")
  setShaderFloat("arasBar", "percent", 1)

	makeLuaSprite('percentDerece','',1,9999999999)
	addLuaSprite('percentDerece',false)

tweenZaman = tamZamam

	doTweenX('percentDereceScale','percentDerece',0, tweenZaman/getProperty('playbackRate'),'linear')
end
function updateYer()
	if not downscroll and not middlescroll then
        setProperty('kalanZaman.y', getProperty('kalanZaman.y')-260)
        setProperty('arasBar.y', getProperty('arasBar.y')-260)
end
	if not downscroll and middlescroll then
        setProperty('kalanZaman.y', getProperty('kalanZaman.y')-148)
        setProperty('arasBar.y', getProperty('arasBar.y')-148)
end
	if downscroll and not middlescroll then
        setProperty('kalanZaman.y', getProperty('kalanZaman.y')+260)
        setProperty('arasBar.y', getProperty('arasBar.y')+260)
end
	if downscroll and middlescroll then
        setProperty('kalanZaman.y', getProperty('kalanZaman.y')+148)
        setProperty('arasBar.y', getProperty('arasBar.y')+148)
end

end
local takeTweenTime = true
function onUpdate(elapsed)
en_kucuk = math.min(unpack(otuzbir))
noteTimer = en_kucuk - getSongPosition()
tamZamam = math.floor(noteTimer/1000)
     setTextString('kalanZaman', tamZamam)
setProperty('arasBar.alpha',getProperty('kalanZaman.alpha'))
  setShaderFloat("arasBar", "percent", getProperty('percentDerece.x'))
setTextString('botplayTxt', ' ')
	for i=#otuzbir,1,-1 do
		if getSongPosition() >= otuzbir[i] then
			table.remove(otuzbir, i)
end
end
	if noteTimer > 1000*startTimer then
        setProperty('kalanZaman.alpha', lerp(getProperty('kalanZaman.alpha'), 1, elapsed * 32))
	if takeTweenTime then
tweenZaman = tamZamam
aramYap()
end
takeTweenTime = false
end
	if noteTimer < 1000 then
        setProperty('kalanZaman.alpha', lerp(getProperty('kalanZaman.alpha'), 0, elapsed * 8))
takeTweenTime = true
end

end
function aramYap()
	setProperty('percentDerece.x',1)
	doTweenX('percentDereceScale','percentDerece',0, tweenZaman/getProperty('playbackRate'),'linear')
end
