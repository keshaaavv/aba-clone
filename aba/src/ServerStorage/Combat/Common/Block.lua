local BlockHandler = {}

local holdingBlock = {}

function BlockHandler.onBlockEvent(player, action, fsm)
	if action == "Down" then
		holdingBlock[player.UserId] = true

		-- Try immediately
		if player:GetAttribute("canBlock") and fsm:getState() ~= "Block" then
			print("{server} " .. player.UserId .. " : start blocking")
			fsm:setState("Block")
		end
	elseif action == "Up" then
		holdingBlock[player.UserId] = false

		if fsm:getState() == "Block" then
			print("{server} " .. player.UserId .. " : stopped blocking")
			fsm:setState("Neutral")
		end
	end
end

-- Hook attribute changes
function BlockHandler.onPlayerAdded(player, fsmGetter)
	player:GetAttributeChangedSignal("canBlock"):Connect(function()
		local fsm = fsmGetter(player)
		if not fsm then
			return
		end

		if player:GetAttribute("canBlock") and holdingBlock[player.UserId] and fsm:getState() ~= "Block" then
			print(player.Name .. " auto-started blocking once available")
			fsm:setState("Block")
		end
	end)
end

return BlockHandler
