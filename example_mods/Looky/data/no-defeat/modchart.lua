function onCreatePost()
    if universeEngine then
        -- modifiers
        startMod('stealth', 'StealthModifier', '', 0)
        startMod('stealthOpponent', 'StealthModifier', 'opponent', 0)
        startMod('stealthPlayer', 'StealthModifier', 'player', 0)
        startMod('middle', 'MiddleModifier', '', 0)
        startMod('tipsyY', 'TipsyYModifier', '', 0)
        startMod('waveX', 'WaveXModifier', '', 0)
        startMod('swapplayfield', 'SwapPlayfieldModifier', '', 0)
        startMod('confusion', 'ConfusionModifier', '', 0)
        startMod('tornado', 'TornadoModifier', '', 0)
        startMod('boost', 'BoostModifier', '', 0)
        startMod('brake', 'BrakeModifier', '', 0)
        startMod('boomerang', 'BoomerangModifier', '', 0)
        startMod('bounceY', 'BounceYModifier', '', 0)
        startMod('speed', 'SpeedModifier', '', 0)
        startMod('waveY', 'WaveYModifier', '', 0)
        startMod('reverseOpponent', 'ReverseModifier', 'opponent', 0)
        startMod('reverse', 'ReverseModifier', '', 0)
        startMod('wavelane', 'WaveLaneModifier', '', 0)
        startMod('x', 'XModifier', '', 0)
        startMod('xOpponent', 'XModifier', 'opponent', 0)
        startMod('xPlayer', 'XModifier', 'player', 0)
        startMod('y', 'YDModifier', '', 0)
        startMod('z', 'ZModifier', '', 0)
        startMod('incang', 'IncomingAngleModifier', '', 0)

        -- set mod
        setMod('stealth', 1)

        setMod('tipsyY', 1.5)
        setSubMod('tipsY', 'speed', 2.5)

        setMod('waveX', 2)
        setSubMod('waveX', 'speed', 2.5)

        setMod('swapplayfield', 0.5)

        -- ease shit
        ease(0, 10, 'expoOut', [[
                    0, stealth,
                    0.75, stealthOpponent,
                    0, stealthPlayer,
                ]])

        ease(68, 10, 'expoOut', [[
                    0, swapplayfield,
                    1, stealthOpponent,
                    0, waveX,
                    0, tipsyY,
                    360, confusion,
                ]])

        ease(84, 10, 'expoOut', [[
                    0.5, swapplayfield,
                    0, confusion,
                    0.75, waveY,
                    5, waveY:speed,
                ]])

        ease(100, 5, 'expoOut', [[
                    0.75, bounceY,
                    0.5, speed,
                    0.5, boost,
                ]])

        ease(132, 5, 'expoOut', [[
                    0.25, tornado,
                    0, bounceY,
                    0, boost,
                    1, speed,
                    1, brake,
                    1, reverse,
                ]])

        ease(164, 5, 'expoOut', [[
                    0, brake,
                    0.75, speed,
                    1, tornado,
                    0, reverse,
                ]])

        ease(196, 5, 'expoOut', [[
                    0, tornado,
                    1, speed,
                    1, boost,
                    1, waveX,
                    0, stealthOpponent,
                    0, swapplayfield,
                    0.5, speed,
                ]])

        ease(228, 5, 'expoOut', [[
                    90, incang:x,
                    40, incang:y,
                ]])

        ease(260, 5, 'expoOut', [[
                    -1, swapplayfield,
                    0, incang:x,
                    0, incang:y,
                    1, speed,
                    0, waveX,
                    0, boost,
                    0, waveY,
                ]])

        ease(292, 0, 'linear', [[
                    0.5, swapplayfield,
                    0.25, speed,
                    0.5, stealthOpponent,
                ]])

        -- rotate lol
        -- OPPONENT SIDE
        ease(292, 1, 'bounceOut', [[
                    90, confusion,
                ]])

        ease(296, 1, 'bounceOut', [[
                    180, confusion,
                ]])

        ease(300, 1, 'bounceOut', [[
                    270, confusion
                ]])

        ease(304, 1, 'bounceOut', [[
                    360, confusion
                ]])

        -- PLAYER SIDE
        ease(308, 0, 'linear', [[
                    0, confusion,
                ]])
        ease(308, 1, 'bounceOut', [[
                    90, confusion,
                ]])

        ease(312, 1, 'bounceOut', [[
                    180, confusion,
                ]])

        ease(316, 1, 'bounceOut', [[
                    270, confusion
                ]])

        ease(320, 1, 'bounceOut', [[
                    360, confusion
                ]])

        ease(356, 30, 'expoOut', [[
                    1, speed
                ]])

        ease(360, 0, 'linear', [[
                    0, confusion
                ]])

        ease(424, 10, 'expoOut', [[
                    1, reverseOpponent,
                    1, tipsyY,
                    1, waveX,
                    
                    2, tipsyY:speed.
                    2, waveX:speed,
                ]])

        -- endningg shitt
        ease(456, 8, "expoOut", [[
                    -100, xOpponent,
                    100, xPlayer,
                    90, incang:x,
                    60, incang:y,
                ]])

        ease(460, 8, "expoOut", [[
                    100, xOpponent,
                    -100, xPlayer,
                ]])

        ease(464, 8, "expoOut", [[
                    -100, xOpponent,
                    100, xPlayer,
                ]])

        ease(468, 8, "expoOut", [[
                    100, xOpponent,
                    -100, xPlayer,
                ]])

        -- 2nd time!!
        ease(472, 8, "expoOut", [[
                    -100, xOpponent,
                    100, xPlayer,
                ]])

        ease(476, 8, "expoOut", [[
                    100, xOpponent,
                    -100, xPlayer,
                ]])

        ease(480, 8, "expoOut", [[
                    -100, xOpponent,
                    100, xPlayer,
                ]])

        ease(484, 8, "expoOut", [[
                    100, xOpponent,
                    -100, xPlayer,
                ]])

        -- AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
        ease(488, 5, "linear", [[
                    0, xOpponent,
                    0, xPlayer,
                    1, stealth,
            
                    0, incang:x,
                    0, incang:y,
                ]])
    end
end
