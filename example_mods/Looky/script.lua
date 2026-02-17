-- Place this in your custom script file, or the appropriate section of your mod

function onGameOver()
    -- Make sure the video exists in your assets folder
    if not isVideoLoaded("death_video") then
        loadVideo("death_video", "assets/images/death_video.mp4")
    end
    
    -- Play the video when game over happens
    playVideo("death_video", true)  -- true makes it loop if you want that
end

function onUpdate(elapsed)
    -- You can check if the video is finished, and then restart or go to the next scene
    if isVideoFinished("death_video") then
        -- Optionally, restart the game or transition to a different scene
        restartGame()  -- Or you can replace it with sceneChange('nextScene') or something else.
    end
end

-- Optionally add a fallback for when the video fails to load
function onFailLoadVideo(videoName)
    print(videoName .. " failed to load!")
end
