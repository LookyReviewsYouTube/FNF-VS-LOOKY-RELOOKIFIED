function onEvent(n, v1, v2)
    if n == 'Intensity' then
	    howIntense = tonumber(v1);
		rhythm = tonumber(v2);
		intense = true;
	end
	if n == 'Stop Intensity' then
	    intense = false;
	end
end

function onBeatHit()
    if intense then
	    if curBeat % rhythm == 0 then
		    triggerEvent('Add Camera Zoom', howIntense);
		end
	end
end