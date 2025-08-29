extends Node

var timer: float = 0.0
@export var winTime: float = 30
var gameWon: bool = false
@export var debugMode: bool = false

func _process(delta: float) -> void:
	if gameWon:
		return
	print(timer)
	timer += delta
	
	if debugMode:
		print("Timer:", timer)
	
	if timer >= winTime:
		CheckWin()

func CheckWin() -> void:
	if gameWon:
		return
	gameWon = true
	print("Timer selesai, cek win condition via TaskManager")
	TaskManager.timer_win_reached()
