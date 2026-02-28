-- recoded (a little) by dxv, for Boozled
function onCreate()
   makeLuaSprite('WBG') makeGraphic('WBG',screenWidth,screenHeight,'ffffff')
   scaleObject('WBG',4,4) setScrollFactor('WBG',0,0) screenCenter('WBG')
   addLuaSprite('WBG') setProperty('WBG.visible',false)
end
function onEvent(Name,Value1)
   if Name == 'WBG' then
      if Value1 == 'Won' or Value1 == 'won' then
         setProperty('WBG.colorTransform.redOffset',0)
         setProperty('WBG.colorTransform.greenOffset',0)
         setProperty('WBG.colorTransform.blueOffset',0)

         setProperty('dadGroup.color',getColorFromHex('ffffff'))
         setProperty('dad.colorTransform.redOffset',-255)
         setProperty('dad.colorTransform.greenOffset',-255)
         setProperty('dad.colorTransform.blueOffset',-255)

         setProperty('gfGroup.color',getColorFromHex('ffffff'))
         setProperty('gf.colorTransform.redOffset',-255)
         setProperty('gf.colorTransform.greenOffset',-255)
         setProperty('gf.colorTransform.blueOffset',-255)

         setProperty('boyfriendGroup.color',getColorFromHex('ffffff'))
         setProperty('boyfriend.colorTransform.redOffset',-255)
         setProperty('boyfriend.colorTransform.greenOffset',-255)
         setProperty('boyfriend.colorTransform.blueOffset',-255)

         setProperty('WBG.visible',true)
         setProperty('timeTxt.visible',false)
         setProperty('scoreTxt.visible',false)
         setProperty('iconP1.visible',false)
         setProperty('iconP2.visible',false)
         setProperty('healthBar.visible',false)
      elseif Value1 == 'Bon' or Value1 == 'bon' then
         setProperty('WBG.colorTransform.redOffset',-255)
         setProperty('WBG.colorTransform.greenOffset',-255)
         setProperty('WBG.colorTransform.blueOffset',-255)

         setProperty('dadGroup.color',getColorFromHex('ffffff'))
         setProperty('dad.colorTransform.redOffset',255)
         setProperty('dad.colorTransform.greenOffset',255)
         setProperty('dad.colorTransform.blueOffset',255)

         setProperty('gfGroup.color',getColorFromHex('ffffff'))
         setProperty('gf.colorTransform.redOffset',255)
         setProperty('gf.colorTransform.greenOffset',255)
         setProperty('gf.colorTransform.blueOffset',255)

         setProperty('boyfriendGroup.color',getColorFromHex('ffffff'))
         setProperty('boyfriend.colorTransform.redOffset',255)
         setProperty('boyfriend.colorTransform.greenOffset',255)
         setProperty('boyfriend.colorTransform.blueOffset',255)

         setProperty('WBG.visible',true)
         setProperty('timeTxt.visible',false)
         setProperty('scoreTxt.visible',false)
         setProperty('iconP1.visible',false)
         setProperty('iconP2.visible',false)
         setProperty('healthBar.visible',false)
      elseif Value1 == 'Perd' or Value1 == 'perd' then
         setProperty('WBG.colorTransform.redOffset',-255)
         setProperty('WBG.colorTransform.greenOffset',-255)
         setProperty('WBG.colorTransform.blueOffset',-255)

         setProperty('dadGroup.color',getColorFromHex('ffffff'))
         setProperty('dad.colorTransform.redOffset',160)
         setProperty('dad.colorTransform.greenOffset',32)
         setProperty('dad.colorTransform.blueOffset',240)

         setProperty('gfGroup.color',getColorFromHex('ffffff'))
         setProperty('gf.colorTransform.redOffset',254)
         setProperty('gf.colorTransform.greenOffset',255)
         setProperty('gf.colorTransform.blueOffset',153)

         setProperty('boyfriendGroup.color',getColorFromHex('ffffff'))
         setProperty('boyfriend.colorTransform.redOffset',0)
         setProperty('boyfriend.colorTransform.greenOffset',255)
         setProperty('boyfriend.colorTransform.blueOffset',255)

         setProperty('WBG.visible',true)
         setProperty('timeTxt.visible',false)
         setProperty('scoreTxt.visible',false)
         setProperty('iconP1.visible',false)
         setProperty('iconP2.visible',false)
         setProperty('healthBar.visible',false)
  elseif Value1 == 'Con' or Value1 == 'con' then
         setProperty('WBG.colorTransform.redOffset',-255)
         setProperty('WBG.colorTransform.greenOffset',-255)
         setProperty('WBG.colorTransform.blueOffset',-255)

         setProperty('dadGroup.color',getColorFromHex('000000'))
         setProperty('dad.colorTransform.redOffset',getProperty('dad.healthColorArray[0]'))
         setProperty('dad.colorTransform.greenOffset',getProperty('dad.healthColorArray[1]'))
         setProperty('dad.colorTransform.blueOffset',getProperty('dad.healthColorArray[2]'))

         setProperty('gfGroup.color',getColorFromHex('000000'))
         setProperty('gf.colorTransform.redOffset',getProperty('gf.healthColorArray[0]'))
         setProperty('gf.colorTransform.greenOffset',getProperty('gf.healthColorArray[1]'))
         setProperty('gf.colorTransform.blueOffset',getProperty('gf.healthColorArray[2]'))

         setProperty('boyfriendGroup.color',getColorFromHex('000000'))
         setProperty('boyfriend.colorTransform.redOffset',getProperty('boyfriend.healthColorArray[0]'))
         setProperty('boyfriend.colorTransform.greenOffset',getProperty('boyfriend.healthColorArray[1]'))
         setProperty('boyfriend.colorTransform.blueOffset',getProperty('boyfriend.healthColorArray[2]'))

         setProperty('WBG.visible',true)
         setProperty('timeTxt.visible',false)
         setProperty('scoreTxt.visible',false)
         setProperty('iconP1.visible',false)
         setProperty('iconP2.visible',false)
         setProperty('healthBar.visible',false)
      elseif Value1 == 'Off' or Value1 == 'off' then
         setProperty('WBG.colorTransform.redOffset',0)
         setProperty('WBG.colorTransform.greenOffset',0)
         setProperty('WBG.colorTransform.blueOffset',0)

         setProperty('dadGroup.color',getColorFromHex('ffffff'))
         setProperty('dad.colorTransform.redOffset',0)
         setProperty('dad.colorTransform.greenOffset',0)
         setProperty('dad.colorTransform.blueOffset',0)

         setProperty('gfGroup.color',getColorFromHex('ffffff'))
         setProperty('gf.colorTransform.redOffset',0)
         setProperty('gf.colorTransform.greenOffset',0)
         setProperty('gf.colorTransform.blueOffset',0)

         setProperty('boyfriendGroup.color',getColorFromHex('ffffff'))
         setProperty('boyfriend.colorTransform.redOffset',0)
         setProperty('boyfriend.colorTransform.greenOffset',0)
         setProperty('boyfriend.colorTransform.blueOffset',0)

         setProperty('WBG.visible',false)
         setProperty('timeTxt.visible',true)
         setProperty('scoreTxt.visible',true)
         setProperty('iconP1.visible',true)
         setProperty('iconP2.visible',true)
         setProperty('healthBar.visible',true)
      end
   end
end