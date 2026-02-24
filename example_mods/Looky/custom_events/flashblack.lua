function onEvent(n, v1, v2)
    if n == 'flashblack' then
        local cam = (v2 == '' and 'game') or v2
        local dur = (v1 == '' and 7) or tonumber(v1)
        
        cameraFlash(cam, '000000', stepCrochet * 0.001 * dur, true)
    end
end