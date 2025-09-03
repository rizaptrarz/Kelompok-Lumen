extends Control

@onready var main_buttons: VBoxContainer = $MainButtons
@onready var options_panel: Panel = $OptionsPanel
@onready var level_select : Panel = $"Level Select"
@onready var title : Label = $Title

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_buttons.visible = true
	options_panel.visible = false
	level_select.visible = false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_start_pressed() -> void:
	level_select.visible = true
	main_buttons.visible = false
	options_panel.visible = false
	title.visible = false
	

func _on_options_pressed() -> void:
	main_buttons.visible = false
	options_panel.visible = true

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_back_options_pressed() -> void:
	_ready()
