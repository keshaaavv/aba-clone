local DataManager = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local dataRemotes = ReplicatedStorage.Remotes.Data

-- stores profilestore from profiles
DataManager.Profiles = {}

function DataManager.AddGold(player: Player, amount: number)
	local profile = DataManager.Profiles[player]
	if not profile then
		return
	end

	profile.Data.Gold += amount
	player.leaderstats.Gold.Value = profile.Data.Gold
	dataRemotes.UpdateGold:FireClient(player, profile.Data.Gold)
end

function DataManager.AddLevel(player: Player, amount: number)
	local profile = DataManager.Profiles[player]
	if not profile then
		return
	end

	profile.Data.Level += amount
	player.leaderstats.Level.Value = profile.Data.Level
	dataRemotes.UpdateLevel:FireClient(player, profile.Data.Level)
end

function DataManager.AddExp(player: Player, amount: number)
	local profile = DataManager.Profiles[player]
	if not profile then
		return
	end

	profile.Data.Exp += amount
	player.leaderstats.Level.Exp = profile.Data.Exp
	dataRemotes.UpdateExp:FireClient(player, profile.Data.Exp)
end

return DataManager
