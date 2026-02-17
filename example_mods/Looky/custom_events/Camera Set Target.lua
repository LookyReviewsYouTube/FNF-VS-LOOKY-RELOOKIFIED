local onGF = false; --ayo

function onEvent(n,v1)
    if n == 'Camera Set Target' then
         if v1 == 'B' or v1 == 'boyfriend' then
            cameraSetTarget('boyfriend');
		end
        if v1 == 'D' or v1 == 'dad' then
            cameraSetTarget('dad');
        end 
		 if v1 == 'G' then
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