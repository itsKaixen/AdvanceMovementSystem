--!nonstrict

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Modules
local BaseState = require(ReplicatedStorage.Client.StateMachine.BaseState)

-- Variables

local WalkState = {}
WalkState.__index = WalkState
setmetatable(BaseState, WalkState)

---------------------------------------- Functions
function WalkState.new(stateController)
	local self = BaseState.new("Walk", stateController)
	setmetatable(self, WalkState)

	return self
end

function WalkState:Enter()
	print("Entered Walk")
end

function WalkState:Exit()
	print("Exited Walk")
end
----------------------------------------

return WalkState
