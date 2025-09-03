extends Control

@onready var main_buttons: VBoxContainer = $MainButtons
@onready var options_panel: Panel = $OptionsPanel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_buttons.visible = true
	options_panel.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://node_2d.tscn")

func _on_options_pressed() -> void:
	main_buttons.visible = false
	options_panel.visible = true

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_back_options_pressed() -> void:
	_ready()
