--!nonstrict

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Modules
local BaseState = require(ReplicatedStorage.Client.StateMachine.BaseState)

-- Variables

local RunState = {}
RunState.__index = RunState
setmetatable(BaseState, RunState)

---------------------------------------- Functions
function RunState.new(stateController)
	local self = BaseState.new("Run", stateController)
	setmetatable(self, RunState)

	return self
end

function RunState:Enter()
	print("RunState Entered")
end

function RunState:Exit()
	print("RunState Exited")
end
----------------------------------------

return RunState
