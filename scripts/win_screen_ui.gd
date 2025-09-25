extends Control
@onready var MainMenu = preload("res://scenes/main_menu.tscn")
@onready var indexPict : TextureRect = $PanelContainer/MarginContainer/VBoxContainer/TextureRect
@onready var Text : Label = $PanelContainer/MarginContainer/VBoxContainer/Text

@export var indexA : Texture2D
@export var indexB : Texture2D
@export var indexC : Texture2D
@export var indexD : Texture2D
@export var indexE : Texture2D
@export var progress_score : float = 30.0


func _ready():
	visible = false
	$AnimationPlayer.play("RESET")
	
func update_index_picture():
	if progress_score >= 90:
		indexPict.texture = indexA
	elif progress_score >= 80:
		indexPict.texture = indexB
	elif progress_score >= 65:
		indexPict.texture = indexC
	elif progress_score >= 45:
		indexPict.texture = indexD
	else:
		indexPict.texture = indexE
	
	Text.text = "Progress : %d%%" % int(progress_score)

func resume():
	get_tree().paused = false
	visible = false
	$AnimationPlayer.play_backwards("blur")

func pause():
	get_tree().paused = true
	visible = true
	$AnimationPlayer.play("blur")


func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
	
func _on_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_next_pressed() -> void:
	pass # Replace with function body.

func _process(delta):
	update_index_picture()
