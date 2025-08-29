extends Node

@onready var text_baloon_scene = preload("res://scenes/text_baloon.tscn")

var dialogue_lines: Array[String] = []
var current_line_index = 0

var text_baloon
var text_baloon_position: Vector2

var is_dialogue_active = false
var can_advance_line = false

func start_dialogue(position: Vector2, lines: Array[String]):
	if is_dialogue_active:
		return
	
	dialogue_lines = lines
	text_baloon_position = position
	_show_text_baloon()
	
	is_dialogue_active = true
	
func _show_text_baloon():
	text_baloon = text_baloon_scene.instantiate()
	text_baloon.finished_displaying.connect(_on_text_baloon_finished_displaying)
	get_tree().root.add_child(text_baloon)
	text_baloon.global_position = text_baloon_position
	text_baloon.display_text(dialogue_lines[current_line_index])
	can_advance_line = false
	
func _on_text_baloon_finished_displaying():
	can_advance_line = true
	
func _unhandled_input(event):
	if (
		event.is_action_pressed("advance_dialogue") &&
		is_dialogue_active &&
		can_advance_line
	):
		text_baloon.queue_free()
		
		current_line_index += 1
		if current_line_index >= dialogue_lines.size():
			is_dialogue_active = false
			current_line_index = 0
			return
			
		_show_text_baloon()
