--!nonstrict

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Modules
local BaseState = require(ReplicatedStorage.Client.StateMachine.BaseState)

-- Variables
local LandingState = {}
LandingState.__index = LandingState
setmetatable(BaseState, LandingState)

---------------------------------------- Functions
function LandingState.new(stateController)
	local self = BaseState.new("Landing", stateController)
	setmetatable(self, LandingState)

	return self
end

function LandingState:Enter()
	print("Entered Landing")
end

function LandingState:Exit()
	print("Exited Landing")
end
----------------------------------------

return LandingState
