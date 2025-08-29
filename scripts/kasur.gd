extends Node2D

@onready var interactable: Area2D = $interactable
@onready var sprite: Sprite2D = $Sprite2D
@export var player_path: NodePath
@onready var player = get_node(player_path)

var progress: int = 0
var can_interact: bool = true

func _ready() -> void:
	sprite.show()
	interactable.interact = _on_interact
	
	TaskManager.add_task("Bed")

func _on_interact():
	if not can_interact:
		return

	
	player.emit_signal("stopPlayer")

	progress = clamp(progress + 100, 0, 100)
	print("Progress: %d%%" % progress)

	if progress >= 100:
		print("Kasur berhasil dibereskan!!")
		TaskManager.check_task_complete("Bed") # Mark task as complete
		player.can_move = true
	else:
		can_interact = false
		await get_tree().create_timer(3.0).timeout
		can_interact = true
		player.can_move = true
