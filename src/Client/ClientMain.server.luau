-- Variables
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Modules
local AnimationController = require(ReplicatedStorage.Client.Controllers.AnimationController)
local CharacterController = require(ReplicatedStorage.Client.Controllers.CharacterController)
local InputController = require(ReplicatedStorage.Client.Controllers.InputController)
local MovementStates = require(ReplicatedStorage.Shared.Types.MovementStates)

local StateController = require(ReplicatedStorage.Client.Controllers.StateController)
local LocomotionFeature = require(ReplicatedStorage.Client.Features.Locomotion.LocomotionFeature)
local StateMachine = require(ReplicatedStorage.Client.StateMachine.StateMachine)

local IdleState = require(ReplicatedStorage.Client.StateMachine.States.IdleState)
local WalkState = require(ReplicatedStorage.Client.StateMachine.States.WalkState)

local stateMachine = StateMachine.new()
local stateController = StateController.new(stateMachine)
local characterController = CharacterController.new()

local humanoid = characterController:GetHumanoid()

local idleState = IdleState.new(stateController)
local walkState = WalkState.new(stateController)
local locomotionFeature = LocomotionFeature.new(stateController, humanoid)
local inputController = InputController.new(locomotionFeature)
local animationController = AnimationController.new(stateController, characterController)

-- Registering
stateMachine:RegisterState(MovementStates.Idle, idleState)
stateMachine:RegisterState(MovementStates.Walk, walkState)

-- Listening to State Changes

stateController.stateChanged:Connect(function(newState, oldState)
	print("state changed")
end)

characterController.CharacterLoaded:Connect(function(character, humanoid, animator, rootPart)
	locomotionFeature:SetHumanoid(humanoid)
	print("Rebound locomotion feature")
end)
characterController:Start()

-- Requesting State
stateController:RequestState(MovementStates.Idle)

inputController:Start()
