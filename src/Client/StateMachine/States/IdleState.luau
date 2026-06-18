--!nonstrict

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Modules
local BaseState = require(ReplicatedStorage.Client.StateMachine.BaseState)

-- Variables
local IdleState = {}
IdleState.__index = IdleState
setmetatable(BaseState, IdleState)

---------------------------------------- Functions
function IdleState.new(stateController)
	local self = BaseState.new("Idle", stateController)
	setmetatable(self, IdleState)

	return self
end

function IdleState:Enter()
	print("Entered Idle")
end

function IdleState:Exit()
	print("Exited Idle")
end
----------------------------------------

return IdleState
