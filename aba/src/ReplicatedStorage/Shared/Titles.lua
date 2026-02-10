-- Titles.lua
local Titles = {}

-- Define ranges
Titles.Ranges = {
	{ min = 1, max = 4, title = "Newbie" },
	{ min = 5, max = 9, title = "Rookie" },
	{ min = 10, max = 14, title = "Novice" },
	{ min = 15, max = 19, title = "Adept" },
	{ min = 20, max = 24, title = "Intermediate" },
	{ min = 25, max = 29, title = "Advanced" },
	{ min = 30, max = 34, title = "Experienced" },
	{ min = 35, max = 39, title = "Skilled" },
	{ min = 40, max = 44, title = "Proficient" },
	{ min = 45, max = 49, title = "Semi-Pro" },
	{ min = 50, max = 54, title = "Pro" },
	{ min = 55, max = 59, title = "Veteran" },
	{ min = 60, max = 64, title = "Elite" },
	{ min = 65, max = 69, title = "Super Elite" },
	{ min = 70, max = 74, title = "Ultra Elite" },
	{ min = 75, max = 79, title = "Master" },
	{ min = 80, max = 84, title = "Legend" },
	{ min = 85, max = 89, title = "Champion" },
	{ min = 90, max = 94, title = "Immortal" },
	{ min = 95, max = 99, title = "Demi-God" },
	{ min = 100, max = 104, title = "God" },
	{ min = 105, max = 349, title = "X" },
	{ min = 350, max = 999, title = "Y" },
}

-- Fallback title
Titles.Fallback = "Z"

-- Helper function
function Titles.getTitle(level: number): string
	for _, range in ipairs(Titles.Ranges) do
		if level >= range.min and level <= range.max then
			return range.title
		end
	end
	return Titles.Fallback
end

return Titles
