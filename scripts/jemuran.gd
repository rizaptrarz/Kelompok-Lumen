extends Node2D

@onready var interactable: Area2D = $interactable
@onready var sprite: Sprite2D = $sprite
@onready var jemuranTimer: Timer = $JemuranTimer

@export var texture_empty: Texture2D
@export var texture_j3baju: Texture2D

@export var max_health: int = 100
var current_health: float = 100
var is_taking_damage: bool = false
var is_dead: bool = false

@export var event_chance_per_second: float = 0.5
@export var damage_per_second: float = 10
@export var cooldown: float = 5.0
var cooldownTimer: float = 0.0

var random_event_timer: float = 0.0
signal JemuranDestroyed

func _ready() -> void:
	sprite.show()
	interactable.interact = _on_interact
	current_health = max_health
	
	# Connect ke timer jemuran (selesai jemur)
	jemuranTimer.timeout.connect(_on_jemuran_timer_timeout)
	
	# Daftar jemuran ke TaskManager
	TaskManager.register_jemuran(self)


func _on_interact() -> void:
	# Player "menolong" jemuran
	is_taking_damage = false
	cooldownTimer = cooldown
	if is_dead:
		return
	
	# Hanya bisa mulai jemur kalau kosong
	if sprite.texture == texture_empty:
		sprite.texture = texture_j3baju
		jemuranTimer.start()
		print("Mulai Jemur")


func _process(delta: float) -> void:
	# Coba trigger random serangan setiap detik
	random_event_timer += delta
	if random_event_timer >= 1.0 and not is_taking_damage:
		random_event_timer = 0.0
		if randf() <= event_chance_per_second and not is_dead and cooldownTimer <= 0.0:
			is_taking_damage = true
			print("⚠️ Hewan menyerang jemuran!")

	# Jika sedang diserang → ambil damage terus
	if is_taking_damage:
		var damage := damage_per_second * delta
		current_health -= damage
	

		if current_health <= 0:
			current_health = 0
			is_taking_damage = false
			_on_health_depleted()
	
	# Cooldown berjalan saat aman
	if not is_taking_damage and cooldownTimer > 0.0:
		cooldownTimer -= delta


func _on_health_depleted() -> void:
	is_dead = true
	print("💀 Jemuran hancur!")
	jemuranTimer.stop()
	JemuranDestroyed.emit()   # Optional: if you still want other scripts to react
	TaskManager.kalah()       # ⬅️ langsung game over


func _on_jemuran_timer_timeout() -> void:
	sprite.texture = texture_empty
	
	if current_health > 0:
		print("✅ Jemuran berhasil dipakai.")
	else:
		print("❌ Health terlalu rendah, jemuran gagal dipakai.")
	
	# Tidak perlu check_win_condition di sini,
	# biarkan TaskManager handle di akhir timer
