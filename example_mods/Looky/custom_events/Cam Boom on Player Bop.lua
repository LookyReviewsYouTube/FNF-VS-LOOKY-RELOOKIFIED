local boomspeed = 0
local bam = 0
local activate = false

function onEvent(name, value1, value2)
    if name == "Cam Boom on Player Bop" then
        activate = true
        boomspeed = tonumber(value1)
        bam = tonumber(value1)
    end
end

function onBeatHit()
    if activate then
        if curBeat %2== 0 then 
            triggerEvent('Add Camera Zoom', boomspeed,boomspeed)
            
     
    end
		end
end