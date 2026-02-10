local DataManager = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local dataRemotes = ReplicatedStorage.Remotes.Data
local Loaded = ServerScriptService.Data.Loaded

local Titles = require(ReplicatedStorage.Shared:WaitForChild("Titles"))

-- stores profilestore from profiles
DataManager.Profiles = {}

function DataManager.AddGold(player: Player, amount: number)
	local profile = DataManager.Profiles[player]
	if not profile then
		return
	end

	local folderName = ("Player_" .. player.UserId)
	local LoadedData = Loaded:FindFirstChild(folderName)

	profile.Data.Gold += amount
	LoadedData.Gold.Value = profile.Data.Gold
	dataRemotes.UpdateGold:FireClient(player, profile.Data.Gold)
end

function DataManager.AddLevelInfo(player: Player, amountLevel: number, amountPrestige: number)
	local profile = DataManager.Profiles[player]
	if not profile then
		return
	end

	local folderName = "Player_" .. player.UserId
	local LoadedData = Loaded:FindFirstChild(folderName)
	if not LoadedData then
		return
	end

	profile.Data.Level += amountLevel
	LoadedData.Level.Value = profile.Data.Level

	profile.Data.Prestiges += amountPrestige
	LoadedData.Prestiges.Value = profile.Data.Prestiges

	-- module to get title
	local title = Titles.getTitle(profile.Data.Level)
	profile.Data.Title = title
	LoadedData.Title.Value = title

	dataRemotes.UpdateLevelInfo:FireClient(player, profile.Data.Level, profile.Data.Prestiges, profile.Data.Title)
end

function DataManager.AddExp(player: Player, amount: number)
	local profile = DataManager.Profiles[player]
	if not profile then
		return
	end

	local folderName = ("Player_" .. player.UserId)
	local LoadedData = Loaded:FindFirstChild(folderName)

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
