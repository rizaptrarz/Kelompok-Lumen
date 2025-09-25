extends CharacterBody2D

@export var movement_speed: float = 100
@export var run_speed_multiplier: float = 3

@export var default_stamina_max: float = 100.0
var stamina_max: float

@export var stamina_regen_rate: float = 10.0
@export var stamina_drain_rate: float = 10.0
@export var min_stamina_to_run: float = 30.0

@onready var animSprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var stamina_label: Label = $"../CanvasLayer/StaminaLabel"  # sesuaikan path ke label stamina

var character_direction: Vector2 = Vector2.ZERO
var current_stamina: float
var is_running: bool = false
var can_move: bool = true
var last_direction: String = "down"  # default idle menghadap bawah

const STAMINA_CAP: float = 150.0

signal stopPlayer

func _ready() -> void:
	stamina_max = default_stamina_max
	current_stamina = stamina_max
	
	connect("stopPlayer", Callable(self, "_on_stop_player"))
	_update_stamina_ui()  # update UI langsung pas game mulai

func _physics_process(delta: float) -> void:
	if not can_move:
		velocity = Vector2.ZERO
		move_and_slide()
		return
	
	character_direction.x = Input.get_axis("move_left", "move_right")
	character_direction.y = Input.get_axis("move_up", "move_down")
	character_direction = character_direction.normalized()
	
	if Input.is_action_pressed("run") and current_stamina > min_stamina_to_run:
		is_running = true
	else:
		is_running = false
	
	var current_speed = movement_speed
	if is_running:
		current_speed *= run_speed_multiplier
		current_stamina -= stamina_drain_rate * delta
		if current_stamina <= min_stamina_to_run:
			is_running = false
	else:
		current_stamina += stamina_regen_rate * delta
	
	current_stamina = clamp(current_stamina, 0, stamina_max)
	_update_stamina_ui()
	
	if character_direction != Vector2.ZERO:
		velocity = character_direction * current_speed
		if abs(character_direction.x) > abs(character_direction.y):
			last_direction = "right" if character_direction.x > 0 else "left"
		else:
			last_direction = "down" if character_direction.y > 0 else "up"
		animSprite.play("run_" + last_direction)
	else:
		velocity = Vector2.ZERO
		animSprite.play("idle_" + last_direction)
	
	move_and_slide()

func _on_stop_player() -> void:
	can_move = false
	velocity = Vector2.ZERO

# Fungsi update UI stamina
func _update_stamina_ui() -> void:
	if stamina_label:
		stamina_label.text = str(round(current_stamina)) + "/" + str(int(stamina_max))
		
