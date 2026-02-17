function onCreate()

	makeLuaSprite('healthBarlung','healthBarlung',15,575)
	scaleObject('healthBarlung', 0.9, 0.9)
	setObjectCamera('healthBarlung','hud')
	addLuaSprite('healthBarlung',true)
	
	setProperty('healthBarBG.alpha',0)	
	
end
function onCreatePost()
	
	setObjectOrder('healthBarlung', getObjectOrder('healthBar') + 1)
	setObjectOrder('iconP1', getObjectOrder('healthBarlung') + 1)
	
	--setProperty('healthBar.x', 150)
	--setProperty('healthBar.y', 641)
	--scaleObject('healthBar',1.65,1.29)
	
end
function onUpdatePost()
	setProperty('healthBarBG.alpha',0)

		setProperty('iconP1.x',880)
	setProperty('iconP1.y',585)
	
	setProperty('iconP2.x',230)
	setProperty('iconP2.y',575)
	setProperty('healthBarlung.alpha',getProperty('healthBar.alpha'))
	setProperty('healthBarlung.visible',getProperty('healthBar.visible'))
	end