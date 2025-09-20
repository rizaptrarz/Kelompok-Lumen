extends Node2D

@onready var interactable = $interactable

@export var player_path: NodePath
@export var buff_manager_path: NodePath  # referensi ke BuffManager

func _ready() -> void:
	# Set fungsi callback interaksi
	interactable.interact = _on_interact

func _on_interact() -> void:
	var buff_manager = get_node(buff_manager_path)
	if buff_manager:
		buff_manager.add_buff("Energik")
		print("Player mendapatkan buff: Energik")
	
	# Hapus item setelah digunakan
	self.queue_free()
