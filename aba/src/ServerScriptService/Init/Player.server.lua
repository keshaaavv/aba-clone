local ServerScriptService = game:GetService("ServerScriptService")
local fsmFolder = ServerScriptService.FSM

local States = require(fsmFolder.States)
local StateMachine = require(fsmFolder.StateMachine)
local HighlightModule = require(ServerScriptService.Highlight)

game.Players.PlayerAdded:Connect(function(player)
	-- Initialize attributes
	player:SetAttribute("canAttack", true)
	player:SetAttribute("canAbility", false)
	player:SetAttribute("canDash", true)
	player:SetAttribute("canBlock", true)
	player:SetAttribute("canStun", true)
end)

game.Players.PlayerAdded:Connect(function(player)
	local fsm = StateMachine.new(player, States)
	fsm:setState("Neutral") -- start state
end)

game.Players.PlayerRemoving:Connect(function(player)
	StateMachine.removeFSM(player)
end)

game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		print("{debug} " .. character.Name .. " - highlighted.")
		HighlightModule.addHighlight(player)

		HighlightModule.setHighlight(player, {
			FillColor = Color3.fromRGB(0, 255, 0),
			OutlineColor = Color3.fromRGB(255, 255, 255),
			FillTransparency = 0.8,
			OutlineTransparency = 1,
		})
	end)
end)
