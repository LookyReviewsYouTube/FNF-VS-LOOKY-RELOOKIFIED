--works fine to get the middle
--except on pixel stages
--and zoom a bit broken too

--Made by Held_der_Zeit

onBoth = false --used for trigger event, if sciript is active

isBoth = false --if the CAM shows at both
sectRun = false --if the sections are running
sectNum = 0 --amount of sections it should hold
camNum = 0

curSection = 0

function onCreatePost()
    --cam offsets
    bfCamX = getProperty("boyfriend.cameraPosition[0]") --+ getProperty("boyfriendCameraOffset[0]")
    bfCamY = getProperty("boyfriend.cameraPosition[1]") --+ getProperty("boyfriendCameraOffset[1]")
    dadCamX = getProperty("dad.cameraPosition[0]") --+ getProperty("opponentCameraOffset[0]")
    dadCamY = getProperty("dad.cameraPosition[1]") --+ getProperty("opponentCameraOffset[1]")

    --character stage position offsets
    bfOffX = getProperty("boyfriend.positionArray[0]")
    bfOffY = getProperty("boyfriend.positionArray[1]")
    dadOffX = getProperty("dad.positionArray[0]")
    dadOffY = getProperty("dad.positionArray[1]")

    zeroBfOffX = getMidpointX("boyfriend")-100
    zeroBfOffY = getMidpointY("boyfriend")-100
    zeroDadOffX = getMidpointX("dad") +150
    zeroDadOffY = getMidpointY("dad") -100

    stageZoom = getProperty("defaultCamZoom")

 

end

function onEvent(name, value1, value2)
    if name == 'Cam_Both' then
        --debugPrint("cam to middle")
        triggerEvent("Camera Follow Pos",
            (zeroBfOffX<zeroDadOffX and zeroBfOffX or zeroDadOffX) + math.abs(zeroBfOffX - zeroDadOffX)/2,
            (zeroBfOffY<zeroDadOffY and zeroBfOffY or zeroDadOffY) + math.abs(zeroBfOffY - zeroDadOffY)/2
        )

        --sections to hold
        if tonumber(value1) ~= nil then
            sectNum = tonumber(value1)
        else
            sectNum = 1
        end

        --custom camzoom (for when chars are further away)
        if tonumber(value2) ~= nil then
            --debugPrint(value2)
            camNum = sectNum
            setProperty("defaultCamZoom", value2)
            --debugPrint(getProperty("defaultCamZoom"))
        end

        onBoth = true

        isBoth = true
        sectRun = true
    end

    --in case that it changes
    -- if name == "Change Character" then
    --     if value1 == ("boyfriend" or 2) then
    --         bfCamX = getProperty("boyfriend.cameraPosition[0]")
    --         bfCamY = getProperty("boyfriend.cameraPosition[1]")
    --     elseif value1 == ("dad" or 0) then
    --         dadCamX = getProperty("dad.cameraPosition[0]")
    --         dadCamY = getProperty("dad.cameraPosition[1]")
    --     end
    -- end
end

function onSectionHit()
    curSection = curSection + 1
    --debugPrint("Section: ", curSection)

    --reset cam
    if sectRun and sectNum <= 0 then
        -- isBoth = false
        --triggerEvent("Camera Follow Pos", "", "")
        --setProperty("defaultCamZoom", stageZoom)
        --triggerEvent("Camera Follow Pos", "", "")
        if mustHitSection then
            cameraSetTarget("boyfriend")
            triggerEvent("Camera Follow Pos", "", "")
        else
            cameraSetTarget("dad")
            triggerEvent("Camera Follow Pos", "", "")
        end
        --isBoth = false
        --debugPrint("back to normal")
        sectRun = false

        if onBoth then
            --used for any extra scripts, that want to implement it
            --debugPrint("finished....")
            triggerEvent('Cam_Both Finish',nil,nil)
        end
    end

    if sectRun then
        sectNum = sectNum-1
    end

    -- if isBoth then
    --     camNum = camNum -1
    -- end

    if isBoth and camNum <= 0 then
        -- isBoth = false
        --triggerEvent("Camera Follow Pos", "", "")
        setProperty("defaultCamZoom", stageZoom)
        --triggerEvent("Camera Follow Pos", "", "")
        isBoth = false
        --debugPrint("back to normal")
    end
    

    if isBoth then
        camNum = camNum -1
    end
end
