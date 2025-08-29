extends Node

var tasks: Dictionary = {}
var jemuran_nodes: Array[Node] = []
var timer_finished: bool = false   # flag dari TimerWin

func add_task(task_name: String) -> void:
	tasks[task_name] = false
	print("Task ditambahkan:", task_name)

func remove_task(task_name: String) -> void:
	if task_name in tasks:
		tasks.erase(task_name)
		print("Task dihapus:", task_name)

func check_task_complete(task_name: String) -> void:
	if task_name in tasks:
		tasks[task_name] = true
		print("Task selesai:", task_name)
	else:
		print("Task tidak ditemukan:", task_name)

func register_jemuran(jemuran: Node) -> void:
	if jemuran not in jemuran_nodes:
		jemuran_nodes.append(jemuran)
		if jemuran.has_signal("JemuranDestroyed"):
			jemuran.JemuranDestroyed.connect(_on_jemuran_destroyed)

func is_all_jemuran_alive() -> bool:
	for jem in jemuran_nodes:
		if jem.is_dead:
			return false
	return true

func are_all_tasks_complete() -> bool:
	if tasks.size() == 0:
		return false
	return tasks.values().all(func(v): return v)

# dipanggil dari TimerWin.gd saat waktu habis
func timer_win_reached() -> void:
	timer_finished = true
	check_win_condition()

func check_win_condition() -> void:
	if not timer_finished:
		return
	
	# kalah kalau timer habis tapi jemuran mati
	if not is_all_jemuran_alive():
		kalah()
		return
	
	# kalah kalau timer habis tapi ada task belum selesai
	if not are_all_tasks_complete():
		print("Timer selesai, tapi masih ada task belum selesai!")
		kalah()
		return

	# kalau semua syarat terpenuhi
	menang()

func menang() -> void:
	print("Timer selesai, semua jemuran hidup, semua task selesai! WIN!")
	get_tree().change_scene_to_file("res://scenes/win_screen.tscn")

func kalah() -> void:
	print("GAME OVER!")
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")

func _on_jemuran_destroyed() -> void:
	kalah()
