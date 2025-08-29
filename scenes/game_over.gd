extends Control

func _ready():
	$Button.text = "Restart Game"
	$Button.pressed.connect(_on_restart_pressed)

func _on_restart_pressed():
	get_tree().change_scene_to_file("res://node_2d.tscn")
