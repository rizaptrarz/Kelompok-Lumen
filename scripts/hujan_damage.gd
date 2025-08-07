extends Node
class_name DamageDealer

@export var damage: int = 1
@export var reason: String = "hujan"
@export var interval: float = 1.0

var target_node: Node
var timer: Timer

func _ready():
	# setup timer
	timer = Timer.new()
	timer.wait_time = interval
	timer.autostart = false
	timer.one_shot = false
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)


func set_target(node: Node) -> void:
	target_node = node

func start():
	timer.start()

func stop():
	timer.stop()

func _on_timer_timeout():
	if target_node and target_node.has_method("decrease_health"):
		target_node.decrease_health(damage, reason)
