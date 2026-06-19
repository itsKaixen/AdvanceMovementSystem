--!nonstrict

-- Services

-- Modules

-- Variables
local Players = game:GetService("Players")

local CharacterController = {}
CharacterController.__index = CharacterController

---------------------------------------- Functions
function CharacterController.new()
	local self = setmetatable({}, CharacterController)

	self.Player = Players.LocalPlayer

	self.Character = nil
	self.Humanoid = nil
	self.Rootpart = nil
	self.Animator = nil

	return self
end

function CharacterController:LoadCharacter(Character)
	self.Character = Character
	self.Humanoid = Character:WaitForChild("Humanoid")
	self.Rootpart = Character:WaitForChild("HumanoidRootPart")

	self.Animator = self.Humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", self.Humanoid)
end

function CharacterController:GetCharacter()
	return self.Character
end

function CharacterController:GetHumanoid()
	return self.Humanoid
end

function CharacterController:GetRootpart()
	return self.Rootpart
end

function CharacterController:GetAnimator()
	return self.Animator
end

function CharacterController:Start()
	local character = self.Player.Character or self.Player.CharacterAdded:Wait()
	CharacterController:LoadCharacter(character)

	self.Player.CharacterAdded:Connect(function(newCharacter)
		self:LoadCharacter(newCharacter)
	end)
end
----------------------------------------

return CharacterController
