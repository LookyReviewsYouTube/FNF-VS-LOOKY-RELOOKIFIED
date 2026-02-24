function onUpdatePost()
      for i = 1,2 do
           if getProperty('iconP'..i..'.graphic.width') > 300 then
                setProperty('iconP'..i..'.animation.curAnim.curFrame',getHealth() > 1.6 and (i == 1 and 2 or 1) or getHealth() < 0.4 and (i == 2 and 2 or 1) or 0)
           end
      end
end