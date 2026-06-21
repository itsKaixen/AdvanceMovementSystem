--!nonstrict

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Modules
local MovementConfig = require(ReplicatedStorage.Shared.Configs.MovementConfig)

-- Variablesg
local MovementController = {}
MovementController.__index = MovementController

---------------------------------------- Functions
function MovementController.new(stateController, characterController)
	local self = setmetatable({}, MovementController)

	self.StateController = stateController
	self.CharacterController = characterController

	self.Humanoid = nil

	self:_setupCharacterConnection()
	self:_setupStateConnections()

	return self
end

function MovementController:_setupCharacterConnection()
	self.CharacterController.CharacterLoaded:Connect(function(_character, humanoid)
		self.Humanoid = humanoid
	end)
end

function MovementController:_setupStateConnections()
	self.StateController.stateChanged:Connect(function(newState, oldState)
		self:OnStateChanged(newState, oldState)
	end)
end

function MovementController:OnStateChanged(newState, oldState)
	if not self.Humanoid then
		return
	end
	local config = MovementConfig[newState.Name]
	if not config then
		return
	end
	self.Humanoid.WalkSpeed = config.WalkSpeed
end
----------------------------------------

return MovementController
