function onEvent(n, value1, value2) 
    if n == 'infryzoom' then
        cancelTween("asf")
        doTweenZoom('asf', 'camGame', value1, value2, 'cubeOut')
        setProperty('defaultCamZoom', value1)
        
    end
end