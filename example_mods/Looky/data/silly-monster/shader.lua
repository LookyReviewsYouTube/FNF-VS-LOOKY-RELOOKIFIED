function onCreatePost() 
    if shadersEnabled then
        makeLuaSprite('ca')
        setSpriteShader('ca', 'Chrom')
        setShaderFloat('ca', 'ca', 0.0014)
        
        runHaxeCode([[
            game.camGame.setFilters([
                new ShaderFilter(game.getLuaObject('ca').shader)
            ]);
            game.camHUD.setFilters([
                new ShaderFilter(game.getLuaObject('ca').shader)
            ]);
        ]])
    end
end
function onDestroy()
    if shadersEnabled then
        runHaxeCode([[
            game.camGame.setFilters([]);
            game.camHUD.setFilters([]);
        ]])
    end
end
function lerp(a, b, t) return a + (b - a) * t end
