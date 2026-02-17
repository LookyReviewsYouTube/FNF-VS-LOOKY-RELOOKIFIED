function onStartCountdown()
    if not allowCountdown then
        allowCountdown = true
        startDialogue('dialogue') -- Looks for dialogue.json
        return Function_Stop
    end
    return Function_Continue
end
