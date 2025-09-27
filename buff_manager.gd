extends Node

# Referensi ke player
@export var player: NodePath
var player_ref: CharacterBody2D = null

# === UI BUFF ===
@export var buff_ui_container: NodePath      # GridContainer untuk sprite buff
@export var energik_icon: Texture2D          # icon sprite untuk buff Energik
@export var senang_icon: Texture2D           # icon sprite untuk buff Senang
@export var segar_icon: Texture2D            # icon sprite untuk buff Segar
@export var kesundul_icon: Texture2D         # icon sprite untuk debuff Kesundul
@export var sedih_icon: Texture2D            # icon sprite untuk debuff Sedih
@export var stress_icon: Texture2D           # icon sprite untuk debuff Stress

# List buff aktif
var active_buffs: Array[String] = []
var buff_icons: Dictionary = {} # simpan buff_name -> TextureRect

# === VARIABEL BONUS ===
var interaction_bonus: float = 1.0

# Daftar efek buff/debuff
var buff_effects := {
	"Energik": func():
		if player_ref:
			var old_stamina_max = player_ref.stamina_max
			var stamina_percentage = player_ref.current_stamina / old_stamina_max if old_stamina_max > 0 else 1.0

			player_ref.stamina_max = min(player_ref.default_stamina_max * 1.5, player_ref.STAMINA_CAP)
			player_ref.current_stamina = stamina_percentage * player_ref.stamina_max
			player_ref._update_stamina_ui()
			print("Buff [Energik] aktif → stamina_max jadi: ", player_ref.stamina_max),

	"Senang": func():
		if player_ref:
			interaction_bonus *= 1.3
			print("Buff [Senang] aktif → interaction speed +30%"),

	"Segar": func():
		if player_ref:
			player_ref.move_speed *= 1.2
			print("Buff [Segar] aktif → movement speed +20%"),

	"Kesundul": func():
		if player_ref:
			if "Segar" in active_buffs:
				remove_buff("Segar")
			player_ref.move_speed *= 0.55
			print("Debuff [Kesundul] aktif → movement speed -45%"),

	"Sedih": func():
		if player_ref:
			if "Senang" in active_buffs:
				remove_buff("Senang")
				interaction_bonus = 1.0  # reset dulu
			interaction_bonus *= 0.85
			print("Debuff [Sedih] aktif → interaction speed -15%"),

	"Stress": func():
		if player_ref:
			interaction_bonus *= 0.5
			print("Debuff [Stress] aktif → interaction speed -50%"),
}

func _ready() -> void:
	if player != null:
		player_ref = get_node(player)

	# pastikan GridContainer valid
	if buff_ui_container != null:
		var container = get_node(buff_ui_container)
		if container is GridContainer:
			container.columns = 1
			container.add_theme_constant_override("h_separation", 0)
			container.add_theme_constant_override("v_separation", 0)

	# contoh auto-buff
	# add_buff("Senang")

# Tambah buff ke player
func add_buff(buff_name: String) -> void:
	if buff_name in active_buffs:
		print("Buff [%s] sudah aktif." % buff_name)
		return

	active_buffs.append(buff_name)
	print("Buff ditambahkan: ", buff_name)

	# Terapkan efek
	if buff_name in buff_effects:
		buff_effects[buff_name].call()

	# Tambah icon di UI
	_show_buff_icon(buff_name)

# Hapus buff
func remove_buff(buff_name: String) -> void:
	if buff_name == "Energik":
		print("Buff [Energik] tidak bisa dihapus [STC].")
		return

	if buff_name in active_buffs:
		active_buffs.erase(buff_name)
		print("Buff dihapus: ", buff_name)
		_remove_buff_icon(buff_name)

		# Reset efek khusus
		if buff_name == "Senang":
			interaction_bonus = 1.0
			print("Buff [Senang] hilang → interaction speed reset normal.")
		elif buff_name == "Segar":
			if player_ref: player_ref.move_speed /= 1.2
		elif buff_name == "Kesundul":
			if player_ref: player_ref.move_speed /= 0.55
		elif buff_name == "Sedih" or buff_name == "Stress":
			interaction_bonus = 1.0
	else:
		print("Buff tidak ditemukan: ", buff_name)

# Cek apakah buff aktif
func has_buff(buff_name: String) -> bool:
	return buff_name in active_buffs

# === UI HANDLING ===
func _show_buff_icon(buff_name: String) -> void:
	var container := get_node(buff_ui_container) if buff_ui_container != null else null
	if not container:
		return

	var icon := TextureRect.new()
	icon.expand = true
	icon.stretch_mode = TextureRect.STRETCH_SCALE
	icon.custom_minimum_size = Vector2(164, 54)
	icon.size_flags_horizontal = Control.SIZE_FILL
	icon.size_flags_vertical = Control.SIZE_FILL

	match buff_name:
		"Energik":
			icon.texture = energik_icon
		"Senang":
			icon.texture = senang_icon
		"Segar":
			icon.texture = segar_icon
		"Kesundul":
			icon.texture = kesundul_icon
		"Sedih":
			icon.texture = sedih_icon
		"Stress":
			icon.texture = stress_icon
		_:
			return

	container.add_child(icon)
	buff_icons[buff_name] = icon

func _remove_buff_icon(buff_name: String) -> void:
	if buff_name in buff_icons:
		var icon = buff_icons[buff_name]
		if is_instance_valid(icon):
			icon.queue_free()
		buff_icons.erase(buff_name)
