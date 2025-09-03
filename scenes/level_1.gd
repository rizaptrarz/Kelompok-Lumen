extends Button

func _on_pressed() -> void:
	var level_scene = preload("res://node_2d.tscn").instantiate()
	level_scene.starting_value = 1.5   # Float you want to pass
	_change_scene(level_scene)


func _change_scene(new_scene: Node):
	var tree = get_tree()
	tree.root.add_child(new_scene)
	tree.current_scene.queue_free()
	tree.current_scene = new_scene
