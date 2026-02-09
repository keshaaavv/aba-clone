local ReplicatedStorage = game:GetService("ReplicatedStorage")
local M1Remote = ReplicatedStorage.Remotes:WaitForChild("M1")
local StateMachine = require(game.ServerScriptService.FSM.StateMachine)

M1Remote.OnServerEvent:Connect(function(player)
	local fsm = StateMachine.getFSM(player)
	if not fsm then
		return
	end

	-- Example: only allow M1 if not stunned
	if player:GetAttribute("canAttack") then
		print(player.Name .. " performed M1 attack")
	else
		print(player.Name .. " tried to attack but cannot")
	end
end)
