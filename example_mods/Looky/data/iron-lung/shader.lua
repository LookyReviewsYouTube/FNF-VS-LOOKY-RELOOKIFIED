function onCreatePost()
    initLuaShader("VCR")
    initLuaShader("oldtimey")
    initLuaShader("fisheye")
    
    makeLuaSprite("chromatic")
    makeGraphic("chromatic", screenWidth, screenHeight)
    
    setSpriteShader("chromatic", "VCR")
	
	makeLuaSprite("fisheye")
    makeGraphic("fisheye", screenWidth, screenHeight)
    
    setSpriteShader("fisheye", "fisheye")
	
	makeLuaSprite("oldtimey")
    makeGraphic("oldtimey", screenWidth, screenHeight)
	 setSpriteShader("oldtimey", "oldtimey")
    setProperty('camZooming',true)
   
	
	
    

    addHaxeLibrary("ShaderFilter", "openfl.filters")
    runHaxeCode([[
     
		game.camGame.setFilters([new ShaderFilter(game.getLuaObject("oldtimey").shader),new ShaderFilter(game.getLuaObject("fisheye").shader),new ShaderFilter(game.getLuaObject("chromatic").shader)]);
		game.camHUD.setFilters([new ShaderFilter(game.getLuaObject("chromatic").shader)]);
       
    ]])

    checkChrom();
end

function setChrome(chromeOffset)
    setShaderFloat("chromatic", "rOffset", chromeOffset);
    setShaderFloat("chromatic", "gOffset", 0.0);
    setShaderFloat("chromatic", "bOffset", chromeOffset * -1);
end

function checkChrom()
    setChrome(0.0020);
end
 function onUpdate(elapsed)
            setShaderFloat('fisheye', 'iTime', os.clock())
        end