extends Node2D

@onready var interactable : Area2D = $interactable
@onready var sprite : Sprite2D = $Sprite2D

const lines: Array[String] = [
	"Halo Nak, Emak Minta Tolong Lagi Ya",
	"Selain tugas yg tadi, Emak Minta...",
]

const char_name: String = "Emak"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactable.interact = _on_interact

func _on_interact():
	TextBoxDialogueManager.start_dialogue(char_name, lines)
