function onCreate()

	makeLuaSprite('Back', 'Back', 0, 0);
	scaleObject('Back', 1, 1)

	makeLuaSprite('Middle', 'Middle', 0, 0);
	scaleObject('Middle', 1, 1)

	makeLuaSprite('Front', 'Front', 0, 0);
	scaleObject('Front', 1, 1)

        addLuaSprite('Back', false);
        addLuaSprite('Middle', true);
        addLuaSprite('Front', true);
end
