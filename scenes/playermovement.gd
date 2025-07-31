extends CharacterBody2D

@export var movement_speed : float = 100
@export var run_speed_multiplier: float = 3
@export var stamina_max: float = 100.0
@export var stamina_regen_rate: float = 10.0
@export var stamina_drain_rate: float = 10.0
@export var min_stamina_to_run: float = 30.0

var character_direction : Vector2 = Vector2.ZERO
var current_stamina: float = stamina_max
var is_running: bool = false

func _physics_process(delta):
	character_direction.x = Input.get_axis("move_left", "move_right")
	character_direction.y = Input.get_axis("move_up", "move_down")
	
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
		velocity = character_direction * current_speed
	else:
		velocity = velocity.move_toward(Vector2.ZERO, current_speed)
	
	if character_direction.x > 0:
		$Sprite2D.flip_h = false
	elif character_direction.x < 0:
		$Sprite2D.flip_h = true

	move_and_slide()
	print("Stamina: ", round(current_stamina))
