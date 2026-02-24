local assetsPath = 'stages/spooky'

function onCreate()
    makeLuaSprite('bgRed' , assetsPath..'/bgRed', 0, 0);
    scaleLuaSprite('bgRed', 1, 1); 
    addLuaSprite('bgRed')
    
    makeLuaSprite('bgRedGlow' , assetsPath..'/bgRedGlow', 698, 188);
    scaleLuaSprite('bgRedGlow', 1, 1); 
    addLuaSprite('bgRedGlow', true)
    setBlendMode('bgRedGlow','add')

    local shaderSettings = {hue = -40, saturation = -2, contrast = 1, brightness = -39}
    if shadersEnabled then
        for _,target in pairs({'dad', 'boyfriend'}) do
            setSpriteShader(target, 'adjustColor')
            for k,v in pairs(shaderSettings) do setShaderFloat(target, k, v) end
        end
    end
end
