extends Node2D

@onready var interactable = $interactable

@export var player_path: NodePath

func _ready() -> void:
	interactable.interact = _on_interact

func _on_interact():

	var player = get_node(player_path)

	if player:
		player.apply_stamina_boost()
		
		self.queue_free()
