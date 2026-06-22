--!nonstrict

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

-- Modules
local AnimationConfig = require(ReplicatedStorage.Shared.Configs.AnimationConfig)

-- Variables

local AnimationController = {}
AnimationController.__index = AnimationController

---------------------------------------- Functions
function AnimationController.new(stateController, characterController)
	local self = setmetatable({}, AnimationController)

	self.StateController = stateController
	self.CharacterController = characterController

	self.Animator = nil
	self.Tracks = {}
	self.CurrentTrack = nil
	self.AnimationsLoaded = false
	self.PendingStateName = nil

	self:_setupCharacterConnections()
	self:_setupStateConnections()

	return self
end

function AnimationController:_setupCharacterConnections()
	self.CharacterController.CharacterLoaded:Connect(function(_character, _humanoid, animator, _rootPart)
		self.Animator = animator

		self:LoadAnimations()
	end)
end

function AnimationController:_setupStateConnections()
	self.StateController.stateChanged:Connect(function(newState, oldState)
		self:OnStateChanged(newState, oldState)
	end)

	RunService.RenderStepped:Connect(function()
		local currentState = self.StateController:GetCurrentState()

		if not currentState then
			return
		end

		if currentState.Name == "Crouch" then
			self:UpdateCrouchAnimation()
		end
	end)
end

function AnimationController:LoadAnimations()
	if not self.Animator then
		warn("[AnimationController] No Animator found.")
		return
	end

	self.AnimationsLoaded = false
	self.CurrentTrack = nil
	table.clear(self.Tracks)

	for stateName, animationData in pairs(AnimationConfig) do
		local animationId = animationData.AnimationId

		if typeof(animationId) == "number" then
			animationId = `rbxassetid://{animationId}`
		elseif typeof(animationId) == "string" and string.match(animationId, "^%d+$") then
			animationId = `rbxassetid://{animationId}`
		end

		if typeof(animationId) ~= "string" or animationId == "" or string.find(animationId, "YOUR_") then
			warn(`[AnimationController] Skipping invalid animation id for {stateName}`)
			continue
		end

		local animation = Instance.new("Animation")

		animation.AnimationId = animationId

		local success, track = pcall(function()
			return self.Animator:LoadAnimation(animation)
		end)

		if not success then
			warn(`[AnimationController] Failed to load animation for {stateName}: {track}`)
			continue
		end

		track.Looped = animationData.Looped == true

		self.Tracks[stateName] = track
	end

	self.AnimationsLoaded = true
	print("[AnimationController] Loaded animations.")

	local currentState = self.StateController:GetCurrentState()
	local stateName = self.PendingStateName or (currentState and currentState.Name)

	if stateName then
		self.PendingStateName = nil
		self:PlayAnimation(stateName)
	end
end

function AnimationController:PlayAnimation(stateName)
	local track = self.Tracks[stateName]

	if not track then
		if not self.AnimationsLoaded then
			self.PendingStateName = stateName
			return
		end

		warn(`[AnimationController] No track found for {stateName}`)
		return
	end

	if self.CurrentTrack == track then
		return
	end

	if self.CurrentTrack then
		self.CurrentTrack:Stop(0.15)
	end

	track:Play(0.15)

	self.CurrentTrack = track
end

function AnimationController:StopCurrentAnimation()
	if not self.CurrentTrack then
		return
	end

	self.CurrentTrack:Stop(0.15)
	self.CurrentTrack = nil
end

function AnimationController:OnStateChanged(newState, oldState)
	if oldState and newState == oldState then
		return
	end

	if newState.Name == "Crouch" then
		self:UpdateCrouchAnimation()
		return
	end

	self:PlayAnimation(newState.Name)
end

function AnimationController:UpdateCrouchAnimation()
	if not self.CharacterController then
		return
	end

	local humanoid = self.CharacterController:GetHumanoid()

	if not humanoid then
		return
	end

	local moving = humanoid.MoveDirection.Magnitude > 0

	if moving then
		self:PlayAnimation("CrouchWalk")
	else
		self:PlayAnimation("CrouchIdle")
	end
end

----------------------------------------

return AnimationController
