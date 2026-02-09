local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Block = ReplicatedStorage.Remotes:WaitForChild("Block")
local StateMachine = require(game.ServerScriptService.FSM.StateMachine)
local BlockHandler = require(game.ServerStorage.Combat.Common.Block)

Block.OnServerEvent:Connect(function(player, action)
	local fsm = StateMachine.getFSM(player)
	if not fsm then
		return
	end
	BlockHandler.onBlockEvent(player, action, fsm)
end)

game.Players.PlayerAdded:Connect(function(player)
	BlockHandler.onPlayerAdded(player, StateMachine.getFSM)
end)
