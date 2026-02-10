local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- remote
local updateLevelInfoEvent = ReplicatedStorage.Remotes.Data.UpdateLevelInfo

-- listen from server
updateLevelInfoEvent.OnClientEvent:Connect(function(newLevel, newPrestige, newTitle)
	local levelUI = script.Parent.Level

	-- repeat "X" for prestige count
	local prestigeString = string.rep("X", newPrestige)

	-- format: Lvl. (LEVEL) | (PRESTIGE) (TITLE)
	levelUI.Text = ("Lvl. %d | %s %s"):format(newLevel, prestigeString, newTitle)
end)
