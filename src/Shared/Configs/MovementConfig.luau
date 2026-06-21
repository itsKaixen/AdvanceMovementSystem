local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MovementStates = require(ReplicatedStorage.Shared.Types.MovementStates)

return {
	[MovementStates.Walk] = {
		WalkSpeed = 8,
	},

	[MovementStates.Run] = {
		WalkSpeed = 18,
	},
}
