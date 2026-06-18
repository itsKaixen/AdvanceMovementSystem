--!nonstrict

-- Services
local RunService = game:GetService("RunService")

-- Modules

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
	RunService.RenderStepped:Connect(function()
		self.LocomotionFeature:Update()
	end)
end
----------------------------------------

return InputController
