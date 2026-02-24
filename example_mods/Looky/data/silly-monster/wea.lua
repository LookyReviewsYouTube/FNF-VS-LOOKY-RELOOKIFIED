function onCreatePost()
    makeLuaSprite('over','ohWhat',0,0)
    addLuaSprite('over',false)
    if version >= '1.0.0' then
        setProperty('over.camera', instanceArg('camOther'), false, true)
    else
        setProperty('over.camera', 'camOther')
    end
    setObjectOrder('over', getObjectOrder('uiGroup')-2)
    setProperty('over.alpha',1)
end
function onStepHit()
    if curStep == 64 then
        setProperty('over.alpha',0.01)
    end
end
