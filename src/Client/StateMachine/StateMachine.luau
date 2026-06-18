--!nonstrict

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Modules
local MovementStates = require(ReplicatedStorage.Shared.Types.MovementStates)

-- Variables

local StateMachine = {}
StateMachine.__index = StateMachine

---------------------------------------- Functions
function StateMachine.new()
	local self = setmetatable({}, StateMachine)

	self.States = {}

	return self
end

function StateMachine:RegisterState(stateName, state)
	if self.States[stateName] then
		error(`[StateMachine] ${stateName} already registered.`)
	end

	self.States[stateName] = state
end

function StateMachine:GetState(stateName)
	local state = self.States[stateName]

	if not state then
		error(`[StateMachine] State ${stateName} is not registered.`)
	end
	return state
end

----------------------------------------

return StateMachine
