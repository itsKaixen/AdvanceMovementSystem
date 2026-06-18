--!nonstrict

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Modules
local MovementStates = require(ReplicatedStorage.Shared.Types.MovementStates)

-- Variables

local LocomotionFeature = {}
LocomotionFeature.__index = LocomotionFeature

---------------------------------------- Functions
function LocomotionFeature.new(stateController, humanoid)
	local self = setmetatable({}, LocomotionFeature)

	self.stateController = stateController
	self.humanoid = humanoid

	return self
end

function LocomotionFeature:Update()
	local moveDirection = self.humanoid.MoveDirection

	local currentState = self.stateController:GetCurrentState()

	if moveDirection.Magnitude > 0 then
		if currentState.Name ~= MovementStates.Walk then
			self.stateController:RequestState(MovementStates.Walk)
		end
	elseif currentState.Name ~= MovementStates.Idle then
		self.stateController:RequestState(MovementStates.Idle)
	end
end
----------------------------------------

return LocomotionFeature
