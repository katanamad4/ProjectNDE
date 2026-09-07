local state = require "state"

local sound = {}

function sound.load()
	for i = 1, state.sourcesPerSound, 1 do 
        for key, data in pairs(state.sounds) do
            data.source[i] = love.audio.newSource(data.path, "static")
        end
    end
end

function sound.play(soundName, pitchRange)
	for key, source in pairs(state.sounds[soundName].source) do
		if not source:isPlaying() then
			if pitchRange then
		    	state.sounds[soundName].source[key]:setPitch((math.random() * pitchRange) + 1)
			end				
		    state.sounds[soundName].source[key]:play()
		end	
	end

end

return sound