local DataManager = require(script.Parent.Parent.Data.Manager)

while true do
	for _, player in game:GetService("Players"):GetPlayers() do
		DataManager.AddGold(player, 0)
	end

	task.wait(2)
end
