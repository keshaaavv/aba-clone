-- ServerScriptService/HighlightModule.lua
local HighlightModule = {}

-- Create a highlight for a player’s character
function HighlightModule.addHighlight(player)
	if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
		return
	end

	-- Avoid duplicates
	if player.Character:FindFirstChild("Highlight") then
		return
	end

	local highlight = Instance.new("Highlight")
	highlight.Name = "Highlight"
	highlight.Parent = player.Character
end

-- Change highlight properties for a player
function HighlightModule.setHighlight(player, props)
	if not player.Character then
		return
	end
	local highlight = player.Character:FindFirstChild("Highlight")
	if not highlight then
		return
	end

	-- Apply any properties passed in
	for key, value in pairs(props) do
		if highlight[key] ~= nil then
			highlight[key] = value
		end
	end
end

-- Remove highlight if needed
function HighlightModule.removeHighlight(player)
	if not player.Character then
		return
	end
	local highlight = player.Character:FindFirstChild("Highlight")
	if highlight then
		highlight:Destroy()
	end
end

return HighlightModule
