local StunHandler = {}

function StunHandler.stun(fsm, duration)
	local player = fsm.player

	-- Check if player can be stunned
	if not player:GetAttribute("canStun") then
		print("{server} " .. player.UserId .. " - nostun")
		return
	end

	local now = os.clock()
	local newEnd = now + duration

	-- store stun end time on the player
	player:SetAttribute("stunEndTime", newEnd)

	-- enter stunned state
	fsm:setState("Stun")

	-- delay check
	task.delay(duration, function()
		-- only exit stun if the current time is past the latest stunEndTime
		if os.clock() >= player:GetAttribute("stunEndTime") then
			if fsm:getState() == "Stun" then
				fsm:setState("Neutral")
			end
		end
	end)
end

return StunHandler
