extends Area2D

@onready var sprite = $Sprite2D
@onready var detector = $PlayerDetector
var player_in_range := false

func _ready():
	input_pickable = true
	monitoring = true
	detector.body_entered.connect(_on_player_detector_body_entered)
	detector.body_exited.connect(_on_player_detector_body_exited)

func _on_player_detector_body_entered(body: Node2D) -> void:
	if body.name == "Player":  # memastikan player
		player_in_range = true
	

func _on_player_detector_body_exited(body: Node2D) -> void:
	if body.name == "Player":  
		player_in_range = false

func _input_event(viewport, event, shape_idx):
	if not player_in_range:
		return  # abaikan klik jika player belum mendekat

	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("Poop dibersihkan!")
		sprite.visible = false
		set_deferred("monitoring", false)
