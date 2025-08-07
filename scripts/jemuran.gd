extends Node2D

@onready var interactable : Area2D = $interactable
@onready var sprite: Sprite2D = $sprite
@onready var jemurTimer: Timer = $JemurTimer
@onready var hujanDamage: DamageDealer = get_node("/root/game_scene/Rintangan/testHujan/HujanDamage")

# image sprite
@export var texture_empty: Texture2D
@export var texture_j3baju: Texture2D

# cuaca
@export var is_hujan: bool
@export 


var task_name := "jemuran"
var health := 100
const MIN_HEALTH := 0


func _ready() -> void:
	sprite.show()
	interactable.interact = _on_interact
	
	# sinyal timeout jemur timer
	jemurTimer.timeout.connect(_on_jemur_timer_timeout)
	
	# register task jemuran ke task manager
	TaskManager.add_task(task_name)
	
	if is_hujan:
		hujanDamage.set_target(self)

func _on_interact():
	if sprite.texture == texture_empty:
		sprite.texture = texture_j3baju
		jemurTimer.start()
		if is_hujan:
			hujanDamage.start()
		print("Mulai Jemur...")
	else:
		sprite.texture = texture_empty
		jemurTimer.stop()
		hujanDamage.start()
		print("Jemur dibatalkan")


func _on_jemur_timer_timeout() -> void:
	sprite.texture = texture_empty
	
	# Tandai task sebagai selesai
	if health > 0:
		print("Health cukup. Task jemur selesai.")
		TaskManager.check_task_complete(task_name)
	else:
		print("Health terlalu rendah. Gagal menyelesaikan task.")
	


func decrease_health(amount: int, reason: String = "") -> void:
	if health <= 0:
		return

	health = max(health - amount, 0)
	print("Health berkurang karena %s: %d" % [reason, health])

	if health <= 0:
		print("Health habis karena %s!" % reason)
		jemurTimer.stop()
		hujanDamage.stop()
		
		# Restart Scene utama
		get_tree().reload_current_scene()
