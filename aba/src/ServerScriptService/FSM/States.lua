local States = {}

local ServerScriptService = game:GetService("ServerScriptService")
local HighlightModule = require(ServerScriptService.Highlight)

States["Neutral"] = {
	onEnter = function(player)
		print("[fsm] neutral" .. " - " .. player.UserId)
		-- set attributes
		player:SetAttribute("canAttack", true)
		player:SetAttribute("canAbility", true)
		player:SetAttribute("canDash", true)
		player:SetAttribute("canBlock", true)
		player:SetAttribute("canEvasive", false)
		HighlightModule.setHighlight(player, {
			FillColor = Color3.fromRGB(0, 255, 0), -- green fill
			OutlineColor = Color3.fromRGB(255, 255, 255), -- white outline
		})
	end,
	onExit = function(player)
		print("[fsm] exit block" .. " - " .. player.UserId)
	end,
}

States["Block"] = {
	onEnter = function(player)
		print("[fsm] block" .. " - " .. player.UserId)
		-- set attributes
		player:SetAttribute("canAttack", false)
		player:SetAttribute("canAbility", false)
		player:SetAttribute("canDash", true)
		player:SetAttribute("canBlock", true)
		player:SetAttribute("canStun", false)
		player:SetAttribute("canEvasive", false)
		HighlightModule.setHighlight(player, {
			FillColor = Color3.fromRGB(0, 0, 255), -- green fill
			OutlineColor = Color3.fromRGB(0, 0, 0), -- white outline
		})
	end,
	onExit = function(player)
		print("[fsm] exit block" .. " - " .. player.UserId)
		player:SetAttribute("canStun", true)
		player:SetAttribute("canEvasive", true)
	end,
}

States["Gaurdbreak"] = {
	onEnter = function(player)
		print("[fsm] gb" .. " - " .. player.UserId)
		-- set attributes
		player:SetAttribute("canAttack", false)
		player:SetAttribute("canAbility", false)
		player:SetAttribute("canDash", false)
		player:SetAttribute("canBlock", false)
		HighlightModule.setHighlight(player, {
			FillColor = Color3.fromRGB(255, 0, 0), -- green fill
			OutlineColor = Color3.fromRGB(150, 0, 0), -- white outline
		})
	end,
	onExit = function(player)
		print("[fsm] exit gb" .. " - " .. player.UserId)
	end,
}

States["Ability"] = {
	onEnter = function(player)
		print("[fsm] ability" .. " - " .. player.UserId)
		-- set attributes
		player:SetAttribute("canAttack", false)
		player:SetAttribute("canAbility", false)
		player:SetAttribute("canDash", true)
		player:SetAttribute("canBlock", false)
		player:SetAttribute("canEvasive", false)
		HighlightModule.setHighlight(player, {
			FillColor = Color3.fromRGB(0, 0, 255), -- green fill
			OutlineColor = Color3.fromRGB(255, 255, 255), -- white outline
		})
	end,
	onExit = function(player)
		print("[fsm] exit ability" .. " - " .. player.UserId)
	end,
}

States["Attack"] = {
	onEnter = function(player)
		print("[fsm] attack" .. " - " .. player.UserId)
		-- set attributes
		player:SetAttribute("canAttack", false)
		player:SetAttribute("canAbility", true)
		player:SetAttribute("canDash", false)
		player:SetAttribute("canBlock", false)
		player:SetAttribute("canEvasive", false)
		HighlightModule.setHighlight(player, {
			FillColor = Color3.fromRGB(0, 255, 0), -- green fill
			OutlineColor = Color3.fromRGB(0, 0, 0), -- white outline
		})
	end,
	onExit = function(player)
		print("[fsm] exit attack" .. " - " .. player.UserId)
	end,
}

States["Stun"] = {
	onEnter = function(player)
		print("[fsm] stun" .. " - " .. player.UserId)
		-- set attributes
		player:SetAttribute("canAttack", false)
		player:SetAttribute("canAbility", true)
		player:SetAttribute("canDash", false)
		player:SetAttribute("canBlock", false)
		player:SetAttribute("canEvasive", true)
		HighlightModule.setHighlight(player, {
			FillColor = Color3.fromRGB(255, 0, 0), -- green fill
			OutlineColor = Color3.fromRGB(0, 0, 0), -- white outline
		})
	end,
	onExit = function(player)
		print("[fsm] exit stun" .. " - " .. player.UserId)
		player:SetAttribute("canEvasive", false)
	end,
}

return States
