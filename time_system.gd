extends Node2D

var timer: float = 0
var winTime: float = 10
var gameWon : bool = false
@export var debugMode: bool

func _process(delta: float) -> void:
	timer += delta;
	
	if debugMode:
		print(timer)
	
	if !gameWon:
		CheckWin()
	
	
pass

func CheckWin() -> void:
	if timer >= winTime:
		print("you win")
		gameWon = true
	
pass
