

local profiler = {}

profiler.__index = profiler
profiler.results = {}
profiler.average = {}
profiler.count = {}
profiler.total = {}


function profiler.start(title)
	profiler.results[title] = love.timer.getTime()
	if not profiler.average[title] then
		profiler.average[title] = 0
		profiler.count[title] = 0
		profiler.total[title] = 0 

	end
end

function profiler.stop(title)
	profiler.results[title] = -(profiler.results[title] - love.timer.getTime() ) * 1000000
	profiler.count[title] = profiler.count[title] + 1 
	profiler.total[title] = profiler.total[title] + profiler.results[title] 
	profiler.average[title] = profiler.total[title] / profiler.count[title]
end

function profiler.print(self)
	print("Profiler")
	for title, timeAvg in pairs(profiler.average) do
			print(string.format("%s: avg:%.1fus last:%.1fus calls:%.0f ", title, timeAvg, self.results[title], self.count[title]))
	end
	print()
end

return profiler