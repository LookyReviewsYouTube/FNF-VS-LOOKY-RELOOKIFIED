function onEvent(name, value1, value2)
	if name == 'killBf' then
		playSound('epicvineboom', value1)
		setProperty('cameraSpeed', 2)
		makeLuaSprite('kill', 'AAUGH', 175, 0)
		addLuaSprite('kill')
		scaleObject('kill', 1, 0.83)
		setObjectCamera('kill', 'other')
		doTweenAlpha('flash', 'kill', 0, 0.7)
		function onUpdatePost()
			setProperty('boyfriend.angle', getProperty('boyfriend.angle') + 8)
			setProperty('boyfriend.x', getProperty('boyfriend.x') + 20)
			setProperty('boyfriend.y', getProperty('boyfriend.y') - 10)
			triggerEvent('Camera Follow Pos', getProperty('boyfriend.x') + 450, getProperty('boyfriend.y') + 200)
		end
	end
end