--!nonstrict

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Modules
local InputState = require(ReplicatedStorage.Shared.Systems.InputState)
local MovementStates = require(ReplicatedStorage.Shared.Types.MovementStates)

-- Variables

local CrouchFeature = {}
CrouchFeature.__index = CrouchFeature

---------------------------------------- Functions
function CrouchFeature.new(stateController, humanoid)
	local self = setmetatable({}, CrouchFeature)

	self.stateController = stateController
	self.humanoid = humanoid

	return self
end

function CrouchFeature:Update()
	print("CrouchFeature Running", InputState.Crouch)
	local currentState = self.StateController:GetCurrentState()

	if InputState.Crouch then
		if currentState.Name ~= MovementStates.Crouch then
			self.StateController:RequestState(MovementStates.Crouch)
		end

		return
	end

	if currentState.Name ~= MovementStates.Crouch then
		return
	end

	local moving = self.Humanoid and self.Humanoid.MoveDirection.Magnitude > 0

	if moving then
		if InputState.Sprint then
			self.StateController:RequestState(MovementStates.Run)
		else
			self.StateController:RequestState(MovementStates.Walk)
		end
	else
		self.StateController:RequestState(MovementStates.Idle)
	end
end
----------------------------------------

return CrouchFeature
