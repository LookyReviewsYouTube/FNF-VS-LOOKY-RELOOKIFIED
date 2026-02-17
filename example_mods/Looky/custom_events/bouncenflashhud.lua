 local turnvalue = 20

bitchhoe = 39
bounce = false
fladsh = false

function onBeatHit()

doDaBeat()

end


function doDaBeat()


turnvalue = -2
if curBeat % 2 == 0 then
turnvalue = 2
end
doTweenAngle('iconTween12','camHUD',0,crochet/1000,'circOut')

	if bounce == true then
		setProperty('camHUD.angle',turnvalue)
		triggerEvent('Add Camera Zoom', 0.04,0.04)

	end


end




function onEvent(name, value1, value2)
	if name == 'bouncenflashhud' then
		if value1 == 'on' then
			bounce = true		
		end
		if value1 == 'off' then
			bounce = false			
		end
		if value1 == 'on' and value2 == 'flash' then
			fldash = true			
			bounce = true			
		end
		if value1 == 'off' and value2 == 'flash' then
			fladsh = false			
			bounce = false			
		end
	end
end
