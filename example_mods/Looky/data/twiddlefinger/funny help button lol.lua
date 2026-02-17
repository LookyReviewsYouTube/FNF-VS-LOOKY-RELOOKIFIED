--[[
hi looky!!!!
here how to use:

open file grr

you wanna set your image first, so go to line 23 and set the image you want it to set it to!
    PLEASE MAKE SURE ITS 1000 x 212

first, find your appearing curStep
    this can be found in the chart editor!

second, you want to put the curstep you found in your chart editor in line 24

third, find your dissapearing curStep
    this can be found in the chart editor! (again)

lastly, you want to put the curStep you found in your chart editor in line 25

you're done! now test it :)
]]

local helpImage = "helphim" -- (IMAGE) set it to whatever image you like!
local curStepAppear = 1567 -- (APPEARING) change to the number to whatever curstep you want it to use!
local curStepDissapear = 1807 -- (DISSAPEARING) change to the number to whatever curstep you want it to use!
local RequiteHit = 30 -- (CLICKING) how much you want the player to click!!!!

local hitButton = 0
function onCreatePost()
    --the sprite, not the clickable stuf
    makeLuaSprite("help", helpImage, (screenWidth/2), 130)
    setObjectCamera("help", "camHUD")
    scaleObject("help", 0, 0)
    addLuaSprite("help")
    
    --clickable lol
    makeLuaSprite("haelp", helpImage, getProperty('help.x') - 175, getProperty('help.y') - 37)
    setObjectCamera("haelp", "camHUD")
    setProperty("haelp.visible", false)
    setProperty("haelp.alpha", 0)
    scaleObject("haelp", 0.35, 0.35)
    addLuaSprite("haelp")
end

function onUpdate(elapsed)
    --debugPrint(hitButton)

    local mouseX, mouseY = getMouseX('camHUD'), getMouseY('camHUD')

    local helpY = getProperty("haelp.y")
    local helpX = getProperty("haelp.x")
    local helpHeight = getProperty("haelp.height")
    local helpWidth = getProperty("haelp.width")
    local helpAlpha = getProperty("haelp.alpha")

    if mouseClicked("left") then
        if mouseX >= helpX and mouseX <= helpX + helpWidth and
        mouseY >= helpY and mouseY <= helpY + helpHeight and
        helpAlpha == 1 then
            hitButton = hitButton + 1
        end
    end
end

function onStepHit()
    if curStep == curStepAppear then
        appearButton()
    end
    if curStep == curStepDissapear then
        dissapearButton()
        if hitButton > RequiteHit then
            debugPrint("you fuckign alive")
        elseif hitButton < RequiteHit then
            debugPrint("you fuckign die")
        end
    end
end

function appearButton()
    setPropertyFromClass('flixel.FlxG', 'mouse.visible', true)
    setProperty("haelp.alpha", 1)
    doTweenX("help X", "help.scale", 0.35, 1, "backOut")
    doTweenY("help Y", "help.scale", 0.35, 1, "backOut")
end

function dissapearButton()
    setPropertyFromClass('flixel.FlxG', 'mouse.visible', false)
    setProperty("haelp.alpha", 0)
    doTweenX("help X", "help.scale", 0, 1, "backIn")
    doTweenY("help Y", "help.scale", 0, 1, "backIn")
end

--basically hides the mouse when you exit the song
function onDestroy()
    setPropertyFromClass('flixel.FlxG', 'mouse.visible', false)
end