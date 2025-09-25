extends Control
@onready var MainMenu = preload("res://scenes/main_menu.tscn")

func _ready():
	visible = false
	$AnimationPlayer.play("RESET")

func resume():
	get_tree().paused = false
	visible = false
	$AnimationPlayer.play_backwards("blur")

func pause():
	get_tree().paused = true
	visible = true
	$AnimationPlayer.play("blur")

func testEsc():
	if Input.is_action_just_pressed("pause") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("pause") and get_tree().paused:
		resume()


func _on_resume_pressed():
	resume()

func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_quit_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _process(delta):
	testEsc()
