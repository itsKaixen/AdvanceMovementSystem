--!strict

-- Services

-- Modules

-- Variables

local BaseState = {}
BaseState.__index = BaseState

---------------------------------------- Functions

function BaseState.new(name: string, stateController)
	local self = setmetatable({}, BaseState)

	self.Name = name
	self.StateController = stateController

	return self
end

function BaseState:Enter()
	error(`[BaseState (StateMachine)] {self.Name}:Enter() not implemented`)
end

function BaseState:Exit()
	error(`[BaseState (StateMachine)] {self.Name}:Exit() not implemented`)
end

function BaseState:Update()
	-- optional
end

function BaseState:CanTransitionTo(_stateName: string): boolean
	return true
end
----------------------------------------

return BaseState
