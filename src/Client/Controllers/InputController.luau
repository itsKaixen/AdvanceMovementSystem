--!nonstrict

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Modules
local InputState = require(ReplicatedStorage.Shared.Systems.InputState)

-- Variables

local InputController = {}
InputController.__index = InputController

---------------------------------------- Functions

function InputController.new(LocomotionFeature)
	local self = setmetatable({}, InputController)

	self.LocomotionFeature = LocomotionFeature

	return self
end

function InputController:Start()
	UserInputService.InputBegan:Connect(function(input, GameProcessed)
		-- if GameProcessed then
		-- 	return
		-- end

		if input.KeyCode == Enum.KeyCode.LeftShift then
			InputState.Sprint = true
			print("SPRINT")
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.KeyCode == Enum.KeyCode.LeftShift then
			InputState.Sprint = false
			print("no run")
		end
	end)

	RunService.RenderStepped:Connect(function()
		self.LocomotionFeature:Update()
	end)
end
----------------------------------------

return InputController
