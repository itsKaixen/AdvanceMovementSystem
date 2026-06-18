-- Variables
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Modules
local MovementStates = require(ReplicatedStorage.Shared.Types.MovementStates)

local StateController = require(ReplicatedStorage.Client.Controllers.StateController)
local StateMachine = require(ReplicatedStorage.Client.StateMachine.StateMachine)

local IdleState = require(ReplicatedStorage.Client.StateMachine.States.IdleState)
local WalkState = require(ReplicatedStorage.Client.StateMachine.States.WalkState)

local stateMachine = StateMachine.new()
local stateController = StateController.new(stateMachine)

local idileState = IdleState.new(stateController)
local walkState = WalkState.new(stateController)

-- Registering
stateMachine:RegisterState(MovementStates.Idle, idileState)
stateMachine:RegisterState(MovementStates.Walk, walkState)

-- Requesting State
stateController:RequestState(MovementStates.Idle)

task.wait(5)

stateController:RequestState(MovementStates.Walk)
