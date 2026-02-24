function onCreatePost()
    makeLuaSprite('POPEYE', '', -1, -1)
    makeGraphic('POPEYE', screenWidth + 1, screenHeight + 1, '000000')
    setScrollFactor('POPEYE', 0, 0)
    addLuaSprite('POPEYE', true)
    setObjectCamera('POPEYE', 'camOther')
end
function onSongStart()
      doTweenAlpha('zzz','POPEYE',0.00001,stepCrochet * 0.001 * 16,'sineOut')
end

function onTweenCompleted(t)
    if t == 'zzz' then
        removeLuaSprite('POPEYE')
    end
end