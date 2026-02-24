local move = 20 --Pixel To Move

local c = {
    on = true,
    ang = false,
    n = {'GF Sing','note1','note2'},
    tar = false,
    off = move,
    a = move*0.04,
    defA = 0,
    e = 'linear',
    done = false,
    bX = 0, bY = 0, dX = 0, dY = 0
}

local conv = {
    ['true'] = true, ['false'] = false,
    ['0'] = false, ['1'] = true,
    ['t'] = true, ['f'] = false,
    ['on'] = true, ['off'] = false,
    ['yes'] = true, ['no'] = false
}

function onCreate()
    setMid('bf')
    setMid('dad')

    c.defA = getProperty('camGame.angle')
end

function setMid(ch)
    if ch == 'bf' then
        c.bX = getMidpointX('boyfriend') - getProperty('boyfriendCameraOffset[0]') - getProperty('boyfriend.cameraPosition[0]')
        c.bY = getMidpointY('boyfriend') + getProperty('boyfriendCameraOffset[1]') + getProperty('boyfriend.cameraPosition[1]')
    elseif ch == 'dad' then
        c.dX = getMidpointX('dad') + getProperty('opponentCameraOffset[0]') + getProperty('dad.cameraPosition[0]')
        c.dY = getMidpointY('dad') + getProperty('opponentCameraOffset[1]') + getProperty('dad.cameraPosition[1]')
    end
end

function goodNoteHit(_,dir,typ,sus)
    follow(dir,true,typ)
end

function opponentNoteHit(_,dir,typ,sus)
    follow(dir,false,typ)
end

function noteMiss(_,_,typ,sus)
    if not sus then
        follow(nil,false,typ)
    end
end

function follow(dir,mt,typ)
    if c.on then 
        for _, n in ipairs(c.n) do
            if mustHitSection == mt and typ ~= n then
                local xo = (dir == 0 and -c.off or dir == 3 and c.off or 0)
                local yo = (dir == 1 and c.off or dir == 2 and -c.off or 0)
                local ao = (dir == 0 and c.defA - c.a or dir == 3 and c.defA + c.a or dir == 1 and c.defA -c.a/4 or dir == 2 and c.defA +c.a/4 or c.defA)
                setPos(xo, yo, ao)
            end
        end 
    end
end

function onUpdate()
    sec = 1 / getProperty('cameraSpeed')

    if c.tar == 'bf' then
        cameraSetTarget('boyfriend')
    elseif c.tar == 'dad' then
        cameraSetTarget('dad')
    end
end

function onBeatHit()
    if getProperty('dad.animation.curAnim.name') == 'idle' and
       getProperty('boyfriend.animation.curAnim.name') == 'idle' then
        setPos(0, 0, c.defA)
    end
end

function onEvent(n, v1, v2)
    if n == 'camFunction' then
        if v1 == 'target' then
            c.tar = v2
            if v2 == 'gf' then
                triggerEvent('Camera Follow Pos', (c.bX < c.dX and c.bX or c.dX) + math.abs(c.bX - c.dX)/2,(c.bY < c.dY and c.bY or c.dY) + math.abs(c.bY - c.dY)/2 - 150)
            elseif v2 == '' then
                triggerEvent('Camera Follow Pos', '', '')
            end
        elseif v1 == 'cam' then
            c.on = conv[v2] or false
        elseif v1 == 'camAngle' then
            cancelTween('camGameAngle')
            c.ang = conv[v2] or false
        elseif v1 == 'ag' then
            c.a = tonumber(v2) or 0
        elseif v1 == 'offset' then
            c.off = tonumber(v2) or move
        end
    end
    
    if n == 'Change Character' then
        local char = ''
        if tonumber(v1) == 0 then char = 'bf'
        elseif tonumber(v1) == 1 then char = 'dad'
        else char = v1 end
        setMid(char)
    end
end

function setPos(x, y, a)
    setProperty('camGame.targetOffset.x', x)
    setProperty('camGame.targetOffset.y', y)
    if c.ang then
        doTweenAngle('camGameAngle', 'camGame', a, sec, c.e)
    end
end