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
	local self = BaseState.new("Idle", stateController)
	setmetatable(self, LandingState)
end

function LandingState:Enter()
	print("Entered Idle")
end

function LandingState:Exit()
	print("Exited Idle")
end
----------------------------------------

return LandingState
