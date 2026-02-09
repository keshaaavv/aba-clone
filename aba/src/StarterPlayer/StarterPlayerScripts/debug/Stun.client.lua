local ReplicatedStorage = game:GetService("ReplicatedStorage")
local stunDebug = ReplicatedStorage.Remotes:WaitForChild("stunDebug")
local UserInputService = game:GetService("UserInputService")


UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.LeftBracket then
		stunDebug:FireServer("Down")
		print("<client> fired server with stun down")
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.LeftBracket then
		stunDebug:FireServer("Up")
		print("<client> fired server with stun up")
	end
end)
