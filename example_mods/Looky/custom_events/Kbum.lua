function onCountdownStarted()
    kbumActive = false
    angleIntensity = 0.8
    defG = 0
    defH = 0
end

function onEvent(name, value1, value2)
    if name == 'Kbum' then
        kbumActive = not kbumActive
        if value1 ~= '' then
            angleIntensity = tonumber(value1) or angleIntensity 
        end
        if not kbumActive then
            resetCamera()
        else
            defG = getProperty('camGame.angle')
        end
    end
end
function onBeatHit()
    if kbumActive then
        direction = curBeat % 2 == 0 and 1 or -1
        currentAngle = angleIntensity * direction
        effect(currentAngle)
    end
end

function effect(angle)
    setProperty('camHUD.angle', defH + (angle * 3))
    setProperty('camGame.angle', defG + (angle * 3))
    
    doTweenAngle('hudTurn', 'camHUD', defH + angle, stepCrochet * 0.002, 'circOut')
    doTweenAngle('gameTurn', 'camGame', defG + angle, stepCrochet * 0.002, 'circOut')
    doTweenX('hudMoveX', 'camHUD', defH + (-angle * 8), crochet * 0.001, 'linear')
    doTweenX('gameMoveX', 'camGame', defG + (-angle * 8), crochet * 0.001, 'linear')
end

function resetCamera()
    setProperty('camHUD.angle', defH)
    setProperty('camGame.angle', defG)
    
    doTweenAngle('hudTurn', 'camHUD', defH, stepCrochet * 0.002, 'circOut')
    doTweenAngle('gameTurn', 'camGame', defG, stepCrochet * 0.002, 'circOut')
    doTweenX('hudMoveX', 'camHUD', 0, crochet * 0.001, 'linear')
    doTweenX('gameMoveX', 'camGame', 0, crochet * 0.001, 'linear')
end