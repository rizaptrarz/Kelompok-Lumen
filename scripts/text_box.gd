extends CanvasLayer

@onready var label_nama = $MarginContainer/MarginContainer/HBoxContainer/LabelNama
@onready var label_text = $MarginContainer/MarginContainer/HBoxContainer/LabelText
@onready var timer = $MarginContainer/LetterDisplayTimer
var nama = ""
var text = ""
var letter_index = 0

var letter_time = 0.03
var space_time = 0.06
var punctuation_time = 0.2

signal finished_displaying()

func display_text(nama_char: String, text_to_display: String):
	nama = nama_char
	text = text_to_display
	label_nama.text = nama_char
	label_text.text = text_to_display
	label_text.text = ""
	
	letter_index = 0
	_display_letter()
	
func _display_letter():
	label_text.text += text[letter_index]
	
	letter_index += 1
	if letter_index >= text.length():
		finished_displaying.emit()
		return
		
	match text[letter_index]:
		"!", ".", ",", "?":
			timer.start(punctuation_time)
		" ":
			timer.start(space_time)
		_:
			timer.start(letter_time)
	

func _on_letter_display_timer_timeout() -> void:
	_display_letter()
