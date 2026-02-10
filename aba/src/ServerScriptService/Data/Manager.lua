local DataManager = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local dataRemotes = ReplicatedStorage.Remotes.Data
local Loaded = ServerScriptService.Data.Loaded

-- stores profilestore from profiles
DataManager.Profiles = {}

function DataManager.AddGold(player: Player, amount: number)
	local profile = DataManager.Profiles[player]
	if not profile then
		return
	end

	local _folderName = ("Player_" .. player.UserId)
	local LoadedData = Loaded.folderName

	profile.Data.Gold += amount
	LoadedData.Gold.Value = profile.Data.Gold
	dataRemotes.UpdateGold:FireClient(player, profile.Data.Gold)
end

function DataManager.AddLevel(player: Player, amount: number)
	local profile = DataManager.Profiles[player]
	if not profile then
		return
	end

	local _folderName = ("Player_" .. player.UserId)
	local LoadedData = Loaded.folderName

	profile.Data.Level += amount
	LoadedData.Level.Value = profile.Data.Level
	dataRemotes.UpdateLevel:FireClient(player, profile.Data.Level)
end

function DataManager.AddExp(player: Player, amount: number)
	local profile = DataManager.Profiles[player]
	if not profile then
		return
	end

	local _folderName = ("Player_" .. player.UserId)
	local LoadedData = Loaded.folderName

	profile.Data.Exp += amount
	LoadedData.Exp.Value = profile.Data.Exp
	dataRemotes.UpdateExp:FireClient(player, profile.Data.Exp)
end

-- character stuff

function DataManager.ChangeCharacter(player: Player, character: string)
	local profile = DataManager.Profiles[player]
	if not profile then
		return
	end

	local folderName = "Player_" .. player.UserId
	local LoadedData = Loaded:FindFirstChild(folderName)

	if not profile.Data.CharactersOwned[character] then -- check if character is here
		return
	end

	-- update
	profile.Data.SelectedCharacter = character
	LoadedData.SelectedCharacter.Value = character

	-- notify
	dataRemotes.Characters.Update:FireClient(player, profile.Data.SelectedCharacter)
end

return DataManager
