function onEvent(tag, v1, v2)
    if tag == 'fade HUD' then
        startTween('fadeOut', 'this', {['camHUD.alpha'] = 0}, 0.5, {ease = 'quartIn', startDelay = 0, onComplete = 'onTweenCompleted'})
    end
end