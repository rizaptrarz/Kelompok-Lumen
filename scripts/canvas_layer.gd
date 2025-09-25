extends CanvasLayer

@onready var pause_menu: Control = $PauseMenu
@onready var win_screen: Control = $WinScreenUI

func _ready():
	pause_menu.visible = false
	win_screen.visible = false

# ===== PAUSE MENU =====
func show_pause():
	pause_menu.visible = true

func hide_pause():
	pause_menu.visible = false

func show_win():
	win_screen.visible = true

func hide_win():
	win_screen.visible = false
