extends CanvasLayer

@onready var pause_menu: Control = $PauseMenu
@onready var win_screen: Control = $WinScreenUI

func _ready():
	# awalnya semua disembunyikan
	pause_menu.visible = false
	win_screen.visible = false

# ===== PAUSE MENU =====
func show_pause():
	pause_menu.visible = true
	get_tree().paused = true

func hide_pause():
	pause_menu.visible = false
	get_tree().paused = false

# ===== WIN SCREEN =====
func show_win():
	win_screen.visible = true
	get_tree().paused = true

func hide_win():
	win_screen.visible = false
	get_tree().paused = false

# ===== KEDUANYA =====
func show_both():
	pause_menu.visible = true
	win_screen.visible = true
	get_tree().paused = true

func hide_all():
	pause_menu.visible = false
	win_screen.visible = false
	get_tree().paused = false
