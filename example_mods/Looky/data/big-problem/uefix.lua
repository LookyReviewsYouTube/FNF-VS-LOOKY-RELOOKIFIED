function onUpdate(elapsed)
    setProperty('scoreTxt.visible', false)
    setProperty('showRating', false)
    setProperty('showComboNum', false)

    if universeEngine then
        setProperty("boyfriendTrail.visible", false)
        setProperty("dadTrail.visible", false)
    
        setProperty('upButton.visible', false)
        setProperty('downButton.visible', false)
        setProperty('leftButton.visible', false)
        setProperty('rightButton.visible', false)

        setProperty('UEsong.visible', false)
        setProperty('UEtimeTxt.visible', false)
        setProperty('UEmiss.visible', false)
        setProperty('UEscore.visible', false)
        setProperty('UErating.visible', false)
        
        setProperty('UE ratingTxt.visible', false)
        setProperty('UE comboTxt.visible', false)

        setProperty('UEdiffucultyLVL.visible', false)

        setProperty('UE song name popup.visible', false)
        setProperty('UE info 1.visible', false)
        setProperty('UE info 2.visible', false)
    end
end