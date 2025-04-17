extends Control

@onready var master_volume_num = $Label as Label
@onready var master_slider = $HSlider as HSlider

@export_enum("Master", "Music", "SFX") var bus_name : String 

var bus_index : int = 0

func _ready():
	master_slider.value_changed.connect(on_value_changed)
	get_bus_name_index()
	set_slider_value()
	
	
func set_audio_num_label_text() -> void:
	master_volume_num.text = str(master_slider.value * 100)
	

func get_bus_name_index() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)

func set_slider_value() -> void:
	master_slider.value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))
	set_audio_num_label_text()

func on_value_changed(value : float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	set_audio_num_label_text()
	
func _on_check_box_toggled(toggled_on: bool) -> void:
	get_bus_name_index()
	AudioServer.set_bus_mute(0,toggled_on)
