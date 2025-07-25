extends Node2D

@onready var interactable : Area2D = $interactable
@onready var sprite: Sprite2D = $sprite

# image sprite
@export var texture_empty: Texture2D
@export var texture_j3baju: Texture2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.show()
	interactable.interact = _on_interact

func _on_interact():
	if sprite.texture == texture_empty:
		sprite.texture = texture_j3baju
	else:
		sprite.texture = texture_empty
