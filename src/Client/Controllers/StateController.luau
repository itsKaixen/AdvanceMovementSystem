--!nonstrict

-- Services

-- Modules

-- Variables

local StateController = {}
StateController.__index = StateController
---------------------------------------- Functions

function StateController.new(stateMachine)
	local self = setmetatable({}, StateController)

	self.StateMachine = stateMachine

	self.CurrentState = nil
	self.PreviousState = nil
	self.BufferedAction = nil

	return self
end

function StateController:GetCurrentState()
	return self.CurrentState
end

function StateController:GetPreviousState()
	return self.PreviousState
end

function StateController:RequestState(stateName)
	-- validation later
	self:SetState(stateName)
end

function StateController:SetState(stateName)
	local newState = self.StateMachine:GetState(stateName)

	if self.CurrentState then
		self.CurrentState:Exit()
	end

	self.PreviousState = self.CurrentState
	self.CurrentState = newState

	self.CurrentState:Enter()
end
----------------------------------------

return StateController
