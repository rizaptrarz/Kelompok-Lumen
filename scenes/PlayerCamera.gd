extends Camera2D

@export var player: Node2D
@export var follow_speed := 5.0  # Tweak this value to your liking

func _physics_process(delta):
	if player:
		var factor = clamp(follow_speed * delta, 0.0, 1.0)
		global_position = global_position.lerp(player.global_position, factor)
