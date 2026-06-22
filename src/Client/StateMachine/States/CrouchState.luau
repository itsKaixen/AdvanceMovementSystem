--!nonstrict

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Modules
local BaseState = require(ReplicatedStorage.Client.StateMachine.BaseState)

-- Variables

local CrouchState = {}
CrouchState.__index = CrouchState
setmetatable(BaseState, CrouchState)

---------------------------------------- Functions
function CrouchState.new(stateController)
	local self = BaseState.new("Crouch", stateController)

	setmetatable(self, CrouchState)

	return self
end

function CrouchState:Enter()
	print("Crouch Entered")
end

function CrouchState:Exit()
	print("Crouch Exited")
end
----------------------------------------

return CrouchState
