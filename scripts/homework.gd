extends Node2D

@onready var interactable : Area2D = $interactable
@onready var sprite: Sprite2D = $sprite


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.show()
	interactable.interact = _on_interact

func _on_interact():
	print("PR Berhasil Dikerjakan")
