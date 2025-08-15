extends Node

# Dictionary untuk task yg berpengaruh pada win condition
var tasks: Dictionary = {}

# Tambah new task
func add_task(task_name: String) -> void:
	tasks[task_name] = false
	print("Task ditambahkan:", task_name)
	check_win_condition()
	
# Hapus task
func remove_task(task_name: String) -> void:
	if task_name in tasks:
		tasks.erase(task_name)
		print("Task dihapus:", task_name)
		check_win_condition()

# Tandai task selesai
func check_task_complete(task_name: String) -> void:
	if task_name in tasks:
		tasks[task_name] = true
		print("Task selesai:", task_name)
		check_win_condition()
	else:
		print("Task tidak ditemukan:", task_name)

# Cek win condition
func check_win_condition() -> void:
	if tasks.size() == 0:
		print("Task kosong/tidak ada!!.")
		return

	if tasks.values().all(func(v): return v):
		menang()
		
# Menang (Switch scene)
func menang() -> void:
	print("Semua task selesai! WIN!")
	get_tree().change_scene_to_file("res://scenes/win_screen.tscn")  # Ganti dengan scene kamu

# Kalah (Switch scene)
func game_over() -> void:
	print("Game Over!")
	get_tree().change_scene_to_file("res://scenes/game_over_screen.tscn")
