extends Node2D

@export var player_path: NodePath
@onready var interactable: Area2D = $interactable
@onready var sprite: Sprite2D = $sprite
@onready var player = get_node(player_path)

var progress: int = 0
var can_interact: bool = true

func _ready() -> void:
	sprite.show()
	interactable.interact = _on_interact
	# Register this task in the TaskManager
	TaskManager.add_task("Homework")

func _on_interact():
	if not can_interact:
		return

	# Stop the player from moving
	player.emit_signal("stopPlayer")

	progress = clamp(progress + 10, 0, 100)
	print("Homework Progress: %d%%" % progress)

	if progress >= 100:
		print("PR Berhasil Dikerjakan")  # Homework done!
		TaskManager.check_task_complete("Homework") # Mark as complete
		player.can_move = true
	else:
		can_interact = false
		await get_tree().create_timer(3.0).timeout
		can_interact = true
		player.can_move = true
