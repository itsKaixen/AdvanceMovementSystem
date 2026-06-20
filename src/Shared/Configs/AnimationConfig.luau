-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Modules
local MovementStates = require(ReplicatedStorage.Shared.Types.MovementStates)

return {
	[MovementStates.Idle] = {
		AnimationId = "rbxassetid://YOUR_IDLE_ID",
		Looped = true,
	},

	[MovementStates.Walk] = {
		AnimationId = "rbxassetid://132792657547651",
		Looped = true,
	},
}
