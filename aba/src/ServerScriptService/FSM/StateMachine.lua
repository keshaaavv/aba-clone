--[[
REMEMBER TO USE THIS WHEN USING FSM
local States = require(script.States)
local StateMachine = require(script.StateMachine)
]]

local StateMachine = {}
StateMachine.__index = StateMachine

-- keyed by UserId
StateMachine.fsms = {}

function StateMachine.new(player, states)
	local self = setmetatable({}, StateMachine)
	self.player = player
	self.currentState = nil
	self.states = states or {}

	-- store lobablly
	StateMachine.fsms[player.UserId] = self
	return self
end

function StateMachine:setState(name)
	-- exit old state
	if self.currentState then
		local exitFunc = self.states[self.currentState].onExit
		if exitFunc then
			exitFunc(self.player)
		end
	end

	-- enter new state
	self.currentState = name
	local enterFunc = self.states[name].onEnter
	if enterFunc then
		enterFunc(self.player)
	end
end

function StateMachine:getState()
	return self.currentState
end

-- helper to fetch FSM by player
function StateMachine.getFSM(player)
	return StateMachine.fsms[player.UserId]
end

-- cleanup when player leaves
function StateMachine.removeFSM(player)
	StateMachine.fsms[player.UserId] = nil
end

return StateMachine
