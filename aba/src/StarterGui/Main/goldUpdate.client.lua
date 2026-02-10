local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- remote
local updateGoldEvent = ReplicatedStorage.Remotes.Data.UpdateGold

-- listen from server
updateGoldEvent.OnClientEvent:Connect(function(newGoldAmount)
	local moneyUI = script.Parent.Money
	moneyUI.Text = ("$" .. newGoldAmount)
end)
