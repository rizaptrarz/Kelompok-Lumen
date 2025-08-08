extends Node2D

@onready var interactable: Area2D = $interactable
@onready var sprite: Sprite2D = $sprite
@onready var jemuranTimer: Timer = $JemuranTimer

@export var texture_empty: Texture2D
@export var texture_j3baju: Texture2D

@export var max_health: int = 100
var current_health: float = 100
var is_taking_damage := false
var is_dead := false

@export var event_chance_per_second := 0.5
@export var damage_per_second := 10
@export var cooldown : float = 5 
var cooldownTimer : float = cooldown

var task_name := "jemuran"
var random_event_timer := 0.0
signal JemuranDestroyed
func _ready() -> void:
	sprite.show()
	interactable.interact = _on_interact
	current_health = max_health
	
	# Connecting ke sinyal timeout JemuranTimer
	jemuranTimer.timeout.connect(_on_jemuran_timer_timeout)
	
	# add task jemuran ke task manager
	TaskManager.add_task(task_name)

func _on_interact():
	is_taking_damage = false
	cooldownTimer = cooldown
	if is_dead:
		return
	if sprite.texture == texture_empty:
		sprite.texture = texture_j3baju
		jemuranTimer.start()
		print("Mulai Jemur")
	else:
		sprite.texture = texture_empty
		jemuranTimer.stop()
		print("Jemur dibatalkan")
		


func _process(delta: float) -> void:

	random_event_timer += delta
	if random_event_timer >= 1.0 and not is_taking_damage:
		random_event_timer = 0.0
		if randf() <= event_chance_per_second and not is_dead and cooldownTimer <= 0:
			is_taking_damage = true
			print("Something is attacking!")

	if is_taking_damage:
		var damage := damage_per_second * delta
		current_health -= damage
		print("Health: " , current_health)

		if current_health <= 0:
			current_health = 0
			is_taking_damage = false
			_on_health_depleted()
			
			
	if not is_taking_damage and cooldownTimer > 0:
		cooldownTimer -= delta
		print("On cooldown: ", cooldownTimer)
	
func _on_health_depleted():
	is_dead = true
	print("Dead :(")
	jemuranTimer.stop()
	JemuranDestroyed.emit()



func _on_jemuran_timer_timeout() -> void:
	sprite.texture = texture_empty
	
	# Tandai task sebagai selesai
	if current_health > 0:
		print("Health cukup. Task jemur selesai.")
		TaskManager.check_task_complete(task_name)
	else:
		print("Health terlalu rendah. Gagal menyelesaikan task.")
