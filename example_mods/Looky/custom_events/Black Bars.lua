local dur = 1
function onCreate()
    makeLuaSprite('topBar', nil, -100,-500)
    makeGraphic('topBar', 1480, 500, '000000')
    screenCenter('topBar','x')
    scaleObject('topBar',5,1,false)
    addLuaSprite('topBar')

    makeLuaSprite('botBar', nil, -100,720)
    makeGraphic('botBar', 1480, 500, '000000')
    screenCenter('botBar','x')
    scaleObject('botBar',5,1,false)
    addLuaSprite('botBar')

    runHaxeCode([[
        var CinematicCam = new FlxCamera();
        CinematicCam.bgColor = 0x00;

        FlxG.cameras.remove(game.camHUD, false);
        FlxG.cameras.remove(game.camOther, false);

        FlxG.cameras.add(CinematicCam, false);
        FlxG.cameras.add(game.camHUD, false);
        FlxG.cameras.add(game.camOther, false);

        game.getLuaObject("topBar").camera = CinematicCam;
        game.getLuaObject("botBar").camera = CinematicCam;
    ]])
end

function onEvent(name, v1, v2)
    if name ~= "Black Bars" then return end
    dur = v2 or 1
    doTweenY("moveTopBar", "topBar", -500 + v1, stepCrochet * 0.001 * dur, "expoOut")
    doTweenY("moveBottomBar", "botBar", 720 - v1, stepCrochet * 0.001 * dur, "expoOut")
end