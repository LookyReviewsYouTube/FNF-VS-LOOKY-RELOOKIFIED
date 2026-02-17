--Code made by Drawoon_
--if you use this please give me credit
function onSongStart()
    AnimAtlas={'LEFT','DOWN','UP','RIGHT','left','down','up','right'}
Post={defaultOpponentStrumX0,defaultOpponentStrumY0}
if downscroll then
    StrumPos=300
else
    StrumPos=-300
end
Separation=defaultOpponentStrumX1-defaultOpponentStrumX0
    setPropertyFromGroup('strumLineNotes',0,'y',defaultOpponentStrumY0+StrumPos)
    setPropertyFromGroup('strumLineNotes',1,'y',defaultOpponentStrumY1+StrumPos)
    setPropertyFromGroup('strumLineNotes',2,'y',defaultOpponentStrumY2+StrumPos)
    setPropertyFromGroup('strumLineNotes',3,'y',defaultOpponentStrumY3+StrumPos)
    for i=0,3 do
    makeAnimatedLuaSprite('StrumNote'..i,'NOTE_assets',Post[1]+Separation*(i),Post[2])
    setObjectCamera('StrumNote'..i,'hud')
    addAnimationByPrefix('StrumNote'..i,'static','arrow'..AnimAtlas[i+1],24,true)
    setObjectOrder('StrumNote'..i,-3)
    scaleObject('StrumNote'..i,0.7,0.7)
    addLuaSprite('StrumNote'..i,false)
    end


    
   
end
function onUpdate(elapsed)
    setPropertyFromGroup('strumLineNotes',0,'y',getProperty('StrumNote0.y')+StrumPos)
    setPropertyFromGroup('strumLineNotes',1,'y',getProperty('StrumNote1.y')+StrumPos)
    setPropertyFromGroup('strumLineNotes',2,'y',getProperty('StrumNote2.y')+StrumPos)
    setPropertyFromGroup('strumLineNotes',3,'y',getProperty('StrumNote3.y')+StrumPos)
    setPropertyFromGroup('strumLineNotes',0,'x',getProperty('StrumNote0.x'))
    setPropertyFromGroup('strumLineNotes',1,'x',getProperty('StrumNote1.x'))
    setPropertyFromGroup('strumLineNotes',2,'x',getProperty('StrumNote2.x'))
    setPropertyFromGroup('strumLineNotes',3,'x',getProperty('StrumNote3.x'))
    setProperty('StrumNote0.angle',getPropertyFromGroup('strumLineNotes',0,'angle'))
    setProperty('StrumNote1.angle',getPropertyFromGroup('strumLineNotes',1,'angle'))
    setProperty('StrumNote2.angle',getPropertyFromGroup('strumLineNotes',2,'angle'))
    setProperty('StrumNote3.angle',getPropertyFromGroup('strumLineNotes',3,'angle'))
end

