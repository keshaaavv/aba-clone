local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local M1Remote = ReplicatedStorage.Remotes:WaitForChild("M1")

-- track whether M1 is held
local holdingM1 = false

-- Fire rate control (to avoid spamming too fast)
local fireInterval = 0.2 -- seconds between each fire
local lastFire = 0

-- Input began: start holding
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then
		return
	end
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		holdingM1 = true
	end
end)

-- Input ended: stop holding
UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		holdingM1 = false
	end
end)

-- Loop to constantly fire while held
task.spawn(function()
	while true do
		task.wait(0.05) -- small heartbeat
		if holdingM1 then
			local now = os.clock()
			if now - lastFire >= fireInterval then
				M1Remote:FireServer()
				print("<client> fired M1 attack")
				lastFire = now
			end
		end
	end
end)
