function onEvent(n,v1,v2)
    local duration = 0.2
    local ease = 'smootherStepInOut'
    if v2 and v2 ~= '' then
        local params = split(v2, ',')
        if #params >= 1 then
            duration = tonumber(params[1]) or 0.2
        end
        if #params == 2 then
            ease = params[2]
        end
    end
    if n == 'angleCam' then
        doTweenAngle('Angl','camGame',v1,stepCrochet * 0.001 * duration,ease)
    end
end
function split(inputstr,sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end
function onTweenCompleted(t)
    if t == 'Angl' and getProperty('camGame.angle') == 360 or getProperty('camGame.angle') == 720 then
        setProperty('camGame.angle',0)
    end
end