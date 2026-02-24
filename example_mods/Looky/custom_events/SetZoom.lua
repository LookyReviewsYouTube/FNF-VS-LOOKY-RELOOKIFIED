local defZoom = getProperty('defaultCamZoom')

function onEvent(n,v1,v2)
    local Zoom = (v1 == '' and defZoom) or v1
    local duration = 3
    local ease = 'smootherStepOut'
    if v2 and v2 ~= '' then
        local params = split(v2, ',')
        if #params >= 1 then
            duration = tonumber(params[1]) or 4
        end
        if #params == 2 then
            ease = params[2]
        end
    end
    if n == 'SetZoom' then
        setProperty('defaultCamZoom',Zoom)
        doTweenZoom('AddZoomCamZ','camGame',Zoom,stepCrochet * 0.001 * duration,ease)
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