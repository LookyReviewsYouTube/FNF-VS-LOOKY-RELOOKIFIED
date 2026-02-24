local fadeType = false

function onEvent(n, v1, v2)
    if n == 'CamFade' then
        local allParams = (v2 == '' or not v2) and v1 or v1..','..v2
        
        local params = {}
        for param in string.gmatch(allParams, "[^,]+") do
            table.insert(params, param:match("^%s*(.-)%s*$"))
        end
        
        local speed = (#params >= 1) and tonumber(params[1]) or 4
        local color = (#params >= 2) and tonumber(params[2]) or 1
        local cam = (v2 == '' and 'game') or v2
        
        local colorHex = (color == 0) and 'FFFFFF' or '000000'
        
        cameraFade(cam, colorHex, stepCrochet * 0.001 * speed, true, fadeType)
        fadeType = not fadeType
    end
end