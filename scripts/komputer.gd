extends Node2D

@onready var interactable : Area2D = $interactable
@onready var sprite : Sprite2D = $sprite

const lines: Array[String] = [
	"Halo Nak, Mama Minta Tolong Ya",
	"Jemur Pakaian, dan jangan lupa kerjain juga PR nya",
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactable.interact = _on_interact

func _on_interact():
	DialogueManager.start_dialogue(global_position, lines)
