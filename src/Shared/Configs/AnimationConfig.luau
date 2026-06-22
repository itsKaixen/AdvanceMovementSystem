-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Modules
local MovementStates = require(ReplicatedStorage.Shared.Types.MovementStates)

return {
	[MovementStates.Idle] = {
		AnimationId = "rbxassetid://130189740964780",
		Looped = true,
	},

	[MovementStates.Walk] = {
		AnimationId = "rbxassetid://132792657547651",
		Looped = true,
	},
	[MovementStates.Run] = {
		AnimationId = "rbxassetid://138954048505570",
		Looped = true,
	},
	CrouchIdle = {
		AnimationId = "rbxassetid://CROUCH_IDLE_ID",
		Looped = true,
	},

	CrouchWalk = {
		AnimationId = "rbxassetid://CROUCH_WALK_ID",
		Looped = true,
	},
}
