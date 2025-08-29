extends Node2D

@export var player_path: NodePath
@onready var interactable: Area2D = $interactable
@onready var sprite: Sprite2D = $sprite
@onready var player = get_node(player_path)

var progressrate: float = 1
var progress: float = 0
var is_interacting: bool = false
var can_interact: bool = true

func _ready() -> void:
	sprite.show()
	TaskManager.add_task("Homework")

func _process(delta: float) -> void:
	if is_interacting and can_interact:
		player.emit_signal("stopPlayer")
		progress = clamp(progress + progressrate * delta, 0.0, 100.0) # % per second
		print("Homework Progress: %d%%" % int(progress))  # round just for display

		if progress >= 100.0:
			print("PR Berhasil Dikerjakan")  
			TaskManager.check_task_complete("Homework")
			is_interacting = false
			player.can_move = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if can_interact:
			is_interacting = true
	elif event.is_action_released("interact"):
		is_interacting = false
		player.can_move = true
