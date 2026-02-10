-- services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- profilestore

local ProfileStore = require(ServerScriptService.ServerPackages.ProfileStore)
local Template = require(ServerScriptService.Data.Template)
local DataManager = require(ServerScriptService.Data.Manager)

local function getStoreName()
	return RunService:IsStudio() and "Test" or "Live"
end

-- access store

local PlayerStore = ProfileStore.New(getStoreName(), Template)

-- add & sync stats
local function init(player: Player, profile: typeof(PlayerStore:StartSessionAsync()))
	-- leaderstats ?? here
	local leaderstats = Instance.new("Folder")
	leaderstats.Parent = player
	leaderstats.Name = "leaderstats"

	-- store data elsewhere (SSS.Data.Loaded.Player.[data here])

	local loadedData = Instance.new("Folder")
	loadedData.Name = ("Player_" .. player.UserId)
	loadedData.Parent = ServerScriptService.Data.Loaded

	local Gold = Instance.new("NumberValue")
	Gold.Name = "Gold"
	Gold.Parent = loadedData
	Gold.Value = profile.Data.Gold

	local Level = Instance.new("NumberValue")
	Level.Name = "Level"
	Level.Parent = loadedData
	Level.Value = profile.Data.Level

	local Exp = Instance.new("NumberValue")
	Exp.Name = "Exp"
	Exp.Parent = loadedData
	Exp.Value = profile.Data.Exp

	-- sync
	ReplicatedStorage.Remotes.Data.UpdateGold:FireClient(player, profile.Data.Gold)
	ReplicatedStorage.Remotes.Data.UpdateLevel:FireClient(player, profile.Data.Level)
	ReplicatedStorage.Remotes.Data.UpdateExp:FireClient(player, profile.Data.Exp)
end

-- creates & stores file
local function PlayerAdded(player: Player)
	local profile = PlayerStore:StartSessionAsync("Player_" .. player.UserId, {
		Cancel = function()
			return player.Parent ~= Players
		end,
	})

	-- Sanity check for profile existence
	if profile ~= nil then
		profile:AddUserId(player.UserId)
		profile:Reconcile()
		-- session locking
		profile.OnSessionEnd:Connect(function()
			DataManager.Profiles[player] = nil
			player:Kick("your data is trying to be accessed elsewhere, please rejoin [sessionlock]")
		end)
		-- save profile for later
		if player.Parent == Players then
			DataManager.Profiles[player] = profile
			init(player, profile)
		else
			profile:EndSession()
		end
	else
		-- server shutting down while player is joining
		player:Kick("your data is trying to be accessed elsewhere, please rejoin [nilprofile]")
	end
end

for _, player in Players:GetPlayers() do
	task.spawn(PlayerAdded, player)
end

Players.PlayerAdded:Connect(PlayerAdded)

Players.PlayerRemoving:Connect(function(player)
	local profile = DataManager.Profiles[player]
	if not profile then -- if session already over
		return
	end

	profile:EndSession()
	DataManager.Profiles[player] = nil
end)
