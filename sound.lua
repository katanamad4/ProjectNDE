local state = require "state"

local sound = {}

function sound.load()
	for i = 1, state.sourcesPerSound, 1 do 
        for key, data in pairs(state.sounds) do
            data.source[i] = love.audio.newSource(data.path, "static")
        end
    end
    for key, data in pairs(state.music) do
    	data.source = love.audio.newSource(data.path, "stream")
    	print(key .. " loaded")
    end
end

function sound.play(soundName, pitchRange)
	for key, source in ipairs(state.sounds[soundName].source) do
		if not source:isPlaying() then
			if pitchRange then
		    	state.sounds[soundName].source[key]:setPitch((math.random() * pitchRange) + 1)
			end				
		    state.sounds[soundName].source[key]:play()
		end	
	end
end

function sound.playMusic(musicName)
	state.music[musicName].source:play()
end

function sound.setVolume(value, type)
	if not type then
		state.masterVolume = value
	elseif type == "sfx" then
		state.sfxVolume = value
	elseif type == "music" then
		state.musicVolume = value
	else
		error("no such sound type " .. type)
	end
end

function sound.changeSourcesVolume()
	for i = 1, state.sourcesPerSound, 1 do 
        for key, data in pairs(state.sounds) do
            data.source[i]:setVolume(state.sfxVolume * state.masterVolume)
        end
    end
    for key, data in pairs(state.music) do
    	data.source:setVolume(state.musicVolume * state.masterVolume)
    end
end

return sound