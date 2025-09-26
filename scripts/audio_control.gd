extends HSlider

@export var audio_bus_name : String 

var audio_bus_id : int

func _ready() -> void:
	audio_bus_id = AudioServer.get_bus_index(audio_bus_name)
	value = VolumeGlobal.music_volume
	AudioServer.set_bus_volume_db(audio_bus_id, linear_to_db(value))
	

func _on_value_changed(value: float) -> void:
	var db : float = linear_to_db(value)
	AudioServer.set_bus_volume_db(audio_bus_id, db)
	VolumeGlobal.music_volume = value
