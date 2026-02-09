local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Stun = ReplicatedStorage.Remotes:WaitForChild("stunDebug")
local StateMachine = require(game.ServerScriptService.FSM.StateMachine)
local StunHandle = require(game.ServerScriptService.StunHandle)

Stun.OnServerEvent:Connect(function(player, action)
	local fsm = StateMachine.getFSM(player)
	if not fsm then
		return
	end

	if action == "Down" then
		-- Use your StunHandler if you want timed stun logic
		StunHandle.stun(fsm, 1) -- example: stun for 3 seconds
	end
end)
