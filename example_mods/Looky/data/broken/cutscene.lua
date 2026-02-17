function onStartCountdown()
    if not allowEnd and not seenCutscene then
        startVideo('broken');
        allowEnd = true;
        return Function_Stop;
    end
    return Function_Continue;
end