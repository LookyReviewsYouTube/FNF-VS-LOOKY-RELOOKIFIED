--[[Gemini
function onCreate()
    makeLuaSprite('particle', 'square', 0, 0)
    addLuaSprite('particle')
end

function onUpdate()
    -- Move the particle upwards
    setProperty('particle.y', getProperty('particle.y') - 1)

    -- Gradually reduce the particle's alpha (transparency)
    setProperty('particle.alpha', getProperty('particle.alpha') - 0.01)

    -- Remove the particle when it's fully faded
    if getProperty('particle.alpha') <= 0 then
        removeLuaSprite('particle')
    end
end

function onEvent(name, value1, value2)
    if name == "particles" then
        for i = 1, 10 do
            local x = math.random(0, screenWidth)
            local y = screenHeight
            makeLuaSprite('particle_' .. i, 'particleTexture', x, y)
            addLuaSprite('particle_' .. i)
        end
    end
end
]]

--[[chatGPT
local particles = {} -- Table to store particles
local particleImage = 'square' -- Replace with the name of your particle image file (without .png)

function spawnParticle(x, y)
    -- Create a new particle sprite
    local particle = makeLuaSprite('particle_' .. #particles + 1, particleImage, x, y)
    setProperty(particle .. '.alpha', 1) -- Set initial opacity
    setProperty(particle .. '.scale.x', 0.5) -- Set scale (adjust as needed)
    setProperty(particle .. '.scale.y', 0.5)
    
    -- Add the particle to the screen
    addLuaSprite(particle, true) -- 'true' makes it appear above other sprites

    -- Store particle data in a table
    table.insert(particles, {
        sprite = particle,
        speedY = math.random(50, 100), -- Vertical speed (adjust range as needed)
        fadeRate = 0.005 -- Fade rate (adjust as needed)
    })
end

function onUpdate(elapsed)
    -- Update each particle's position and opacity
    for i = #particles, 1, -1 do
        local particle = particles[i]
        
        -- Move the particle upwards
        local currentY = getProperty(particle.sprite .. '.y')
        setProperty(particle.sprite .. '.y', currentY - particle.speedY * elapsed)

        -- Fade the particle
        local currentAlpha = getProperty(particle.sprite .. '.alpha')
        setProperty(particle.sprite .. '.alpha', currentAlpha - particle.fadeRate)

        -- Remove particle if it is fully faded out
        if currentAlpha - particle.fadeRate <= 0 then
            removeLuaSprite(particle.sprite, true) -- Remove the sprite from memory
            table.remove(particles, i) -- Remove from the particles table
        end
    end
end

function onEvent(name, value1, value2)
    -- Check if the event name matches
    if name == "particles" then
        -- Parse the values from the event (coordinates can be passed as value1 and value2)
        local x = tonumber(value1) or math.random(100, 700) -- Default random x if not provided
        local y = tonumber(value2) or math.random(300, 500) -- Default random y if not provided

        -- Spawn a particle at the given coordinates
        spawnParticle(x, y)
    end
end
]]

-- anammar
