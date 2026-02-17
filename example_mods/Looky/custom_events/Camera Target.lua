local onGF = false; --ayo --code by SaltyBoii
local dadX = -715
local dadY = -395
local bfX = 280
local bfY = -290
function onEvent(n,v1, v2)
    if n == 'Camera Target' then
        if string.lower(v1) == 'b' then
            if v2 == 'c' then
                triggerEvent('Camera Follow Pos',getMidpointX('boyfriend')-bfX,getMidpointY('boyfriend')+bfY);
            else
                cameraSetTarget('boyfriend');
            end
        elseif string.lower(v1) == 'd' then
                if v2 == 'c' then
                    triggerEvent('Camera Follow Pos',getMidpointX('dad')+dadX,getMidpointY('dad')+dadY);
                else
                    cameraSetTarget('dad');
                end
        elseif string.lower(v1) == 'g' then
            onGF = true;
            triggerEvent('Camera Follow Pos',getMidpointX('gf')+getProperty('gf.cameraPosition[0]'),getMidpointY('gf')+getProperty('gf.cameraPosition[1]'));
        end
    end  
end

function opponentNoteHit()
    if (onGF) then
        triggerEvent('Camera Follow Pos',nil,nil);
        onGF = false;
    end
end

function goodNoteHit()
    if (onGF) then
        triggerEvent('Camera Follow Pos',nil,nil);
        onGF = false;
    end
end