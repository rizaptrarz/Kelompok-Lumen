extends CharacterBody2D

@export var movement_speed : float = 100
@export var run_speed_multiplier: float = 3

@export var default_stamina_max: float = 100.0
var stamina_max: float

@export var stamina_regen_rate: float = 10.0
@export var stamina_drain_rate: float = 10.0
@export var min_stamina_to_run: float = 30.0

@onready var animSprite : AnimatedSprite2D = $AnimatedSprite2D
var character_direction : Vector2 = Vector2.ZERO
var current_stamina: float
var is_running: bool = false
var can_move: bool = true
var last_direction: String = "down"  # default idle menghadap bawah


const STAMINA_CAP : float = 150.0

signal stopPlayer

func _ready() -> void:
	stamina_max = default_stamina_max
	current_stamina = stamina_max
	
	connect("stopPlayer", Callable(self, "_on_stop_player"))

func _physics_process(delta):
	if not can_move:
		velocity = Vector2.ZERO
		move_and_slide()
		return
	
	character_direction.x = Input.get_axis("move_left", "move_right")
	character_direction.y = Input.get_axis("move_up", "move_down")
	character_direction = character_direction.normalized()
	
	# flip sprite animation for iddle
	
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
	
	if character_direction:

	if character_direction != Vector2.ZERO:
		velocity = character_direction * current_speed
		# Menentukan arah anim sprite
		if abs(character_direction.x) > abs(character_direction.y):
			if character_direction.x > 0:
				last_direction = "right"
			else:
				last_direction = "left"
		else:
			if character_direction.y > 0:
				last_direction = "down"
			else:
				last_direction = "up"
		animSprite.play("run_" + last_direction)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, current_speed)
		velocity = Vector2.ZERO
		animSprite.play("iddle_" + last_direction)
	
	if character_direction.x > 0:
		$Sprite2D.flip_h = false
	elif character_direction.x < 0:
		$Sprite2D.flip_h = true

	move_and_slide()
<<<<<<< Updated upstream
	print("Stamina: ", current_stamina)
=======
	
>>>>>>> Stashed changes

func _on_stop_player():
	can_move = false
	velocity = Vector2.ZERO
	
func apply_stamina_boost():
	var old_stamina_max = stamina_max
	
	var stamina_percentage: float = 0
	if old_stamina_max > 0:
		stamina_percentage = current_stamina / old_stamina_max
	
	var new_stamina_max = default_stamina_max * 1.5
	stamina_max = min(new_stamina_max, STAMINA_CAP)
	
	current_stamina = stamina_percentage * stamina_max
	
	print("Stamina Maksimum baru: ", stamina_max)
