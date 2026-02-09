local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Block = ReplicatedStorage.Remotes:WaitForChild("Block")
local UserInputService = game:GetService("UserInputService")

UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.F then
		Block:FireServer("Down")
		print("<client> fired server with block down")
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.F then
		Block:FireServer("Up")
		print("<client> fired server with block up")
	end
end)
