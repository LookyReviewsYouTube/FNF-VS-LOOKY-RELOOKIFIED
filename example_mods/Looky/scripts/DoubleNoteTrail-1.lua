local distX = {150, 0, 0, -150} -- The distance in x
local distY = {0, -80, 80, 0} -- e
local ass = 'cubeIn' -- my ass :v
local c = 100 -- Color intensity
local krilin = 'hardlight' -- blend
local dur = 4 -- Duration in Steps
local alpha = 0.6 -- Initial ghost visibility
local n = {'Ghost Note'} -- Alternative Note to activate the ghost

local gC = 0
local aG = {}

local prevTime = {bf = -1, dad = -1, gf = -1}
local susTime = {bf = -1, dad = -1, gf = -1}
local pred = {bf = '', dad = '', gf = ''}
local susdir = {bf = '', dad = '', gf = ''}

function HomeroChino(character, id, d, t, sus)
    local strumTime = getPropertyFromGroup('notes', id, 'strumTime')
    local isGfNote = getPropertyFromGroup('notes', id, 'gfNote')
    local char = isGfNote and 'gf' or character

    --debugPrint('no sirve', 'yellow')
    
    if not sus then
        if prevTime[char] == strumTime then
            ghostTrail(char, pred[char])
            susdir[char] = pred[char]
        end
        prevTime[char] = strumTime
        pred[char] = d
    else
        if susTime[char] == prevTime[char] then
            ghostSustain(char, susdir[char])
        end
        susTime[char] = prevTime[char] and susdir[char] == d
    end
    for _, n in ipairs(n) do
        if t == n then
            if not sus then
                ghostTrail(char, d)
            else
                ghostSustain(char, susdir[char])
            end
        end
    end
end

function goodNoteHit(id, d, t, sus)
    HomeroChino('boyfriend', id, d, t, sus)
end

function opponentNoteHit(id, d, t, sus)
    HomeroChino('dad', id, d, t, sus)
end

function getIconColor(chr)
    local arr = getProperty(chr .. ".healthColorArray")
    local intensity = 255 - math.floor((c / 100) * 255)
    return getColorFromHex(string.format('%.2x%.2x%.2x', 
        math.min(arr[1] + intensity, 255), 
        math.min(arr[2] + intensity, 255), 
        math.min(arr[3] + intensity, 255)))
end

function ghostSustain(char, dir)
    local gN = char .. 'Ghost' .. (gC - 1)
    if getProperty(gN .. '.visible') then
        cancelTween(gN .. 'fadeOut')
        cancelTween(gN .. 'X')
        cancelTween(gN .. 'Y')
        
        setProperty(gN .. '.alpha', alpha)
        setProperty(gN .. '.x', getProperty(char .. '.x'))
        setProperty(gN .. '.y', getProperty(char .. '.y'))
        
        doTweenAlpha(gN .. 'fadeOut', gN, 0, stepCrochet * 0.001 * dur, 'linear')
        doTweenX(gN .. 'X', gN, getProperty(gN .. '.x') + distX[dir + 1], stepCrochet * 0.001 * dur, 'linear')
        doTweenY(gN .. 'Y', gN, getProperty(gN .. '.y') + distY[dir + 1], stepCrochet * 0.001 * dur, 'linear')
        playAnim(gN, getProperty('singAnimations')[dir + 1], true)
    end
end

function ghostTrail(char, dir)
    local gId = char .. 'Ghost' .. gC
    local grp = (char == 'mom') and 'dad' or char
    
    createInstance(gId, 'objects.Character', {
        getProperty(char .. '.x'), 
        getProperty(char .. '.y'), 
        getProperty(char .. '.curCharacter'), 
        getProperty(char .. '.isPlayer')
    })
    
    local props = {'antialiasing', 'offset.x', 'offset.y', 'scale.x', 'scale.y', 'flipX', 'flipY', 'visible'}
    for _, prop in ipairs(props) do
        setProperty(gId .. '.' .. prop, getProperty(char .. '.' .. prop))
    end
    
    setProperty(gId .. '.color', getIconColor(char))
    setProperty(gId .. '.alpha', alpha * getProperty(char .. '.alpha'))
    setBlendMode(gId, krilin)
    
    addInstance(gId)
    setObjectOrder(gId, getObjectOrder(grp .. 'Group') - 0.1)
    playAnim(gId, getProperty('singAnimations')[dir + 1], true)
    
    local startX, startY = getProperty(gId .. '.x'), getProperty(gId .. '.y')
    
    setProperty(gId .. '.alpha', alpha)
    doTweenAlpha(gId .. 'fadeOut', gId, 0, stepCrochet * 0.001 * dur, 'linear')
    doTweenX(gId .. 'X', gId, getProperty(gId .. '.x') + distX[dir + 1], stepCrochet * 0.001 * dur, 'linear')
    doTweenY(gId .. 'Y', gId, getProperty(gId .. '.y') + distY[dir + 1], stepCrochet * 0.001 * dur, 'linear')
    
    aG[gId] = true
    gC = gC + 1
end

function onTweenCompleted(tag)
    for gId, _ in pairs(aG) do
        if tag == gId .. 'fadeOut' then
            callMethod(gId..'.kill', {''})
            callMethod('variables.remove', {gId})
            callMethod('remove', {instanceArg(gId)})
            callMethod(gId..'.destroy', {''})
            aG[gId] = nil
            break
        end
    end
end
function onCountdownStarted()
    for _, n in ipairs(n) do
        if not checkFileExists('custom_notetypes/'..n..'.txt') then
            saveFile('mods/'..modFolder..'/custom_notetypes/'..n..'.txt', 'E', true) -- por alguna razon no funciona si no uso la ruta absoluta
        end
    end
end