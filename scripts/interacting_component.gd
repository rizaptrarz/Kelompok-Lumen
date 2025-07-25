extends Node2D

@onready var interact_label:Label = $Label
var curr_interactions := []
var can_interact := true


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and can_interact:
		if curr_interactions:
			can_interact = false
			interact_label.hide()
			
			await curr_interactions[0].interact.call()
			
			can_interact = true

func _process(delta: float) -> void:
	if curr_interactions and can_interact:
		curr_interactions.sort_custom(_sort_by_nearest)
		if curr_interactions[0].is_interactable:
			interact_label.text = curr_interactions[0].interact_name
			interact_label.show()
	else:
		interact_label.hide()

func _sort_by_nearest(area1, area2):
	var area1_dist = global_position.direction_to(area1.global_position)
	var area2_dist = global_position.direction_to(area2.global_position)
	return area1_dist < area2_dist

func _on_interact_range_area_entered(area: Area2D) -> void:
	curr_interactions.push_back(area)

func _on_interact_range_area_exited(area: Area2D) -> void:
	curr_interactions.erase(area)
	
	
	
