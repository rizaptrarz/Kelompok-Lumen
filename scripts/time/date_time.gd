class_name DateTime extends Resource

@export_range(0,59) var seconds: int = 0
@export_range(0,59) var minutes: int = 0
@export_range(0,59) var hours: int = 0
@export var days: int = 0

var delta_time: float = 0

func increase_by_sec(delta_second: float) -> void:
	delta_time += delta_second
	if delta_time < 1: return
	
	var delta_second_int: int = delta_time
	delta_time -= delta_second_int
	
	seconds += delta_second_int
	minutes = seconds / 60
	hours = minutes / 60
	days = hours / 24
	
	seconds = seconds % 60
	minutes = minutes % 60
	hours = hours % 60
	
	
