local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer

-- remote
local updateGoldEvent = ReplicatedStorage.Remotes.Data.UpdateGold

-- listen from server
updateGoldEvent.OnClientEvent:Connect(function(newGoldAmount)
	local moneyUI = script.Parent.Money
	moneyUI.Text = ("$" .. newGoldAmount)
end)
