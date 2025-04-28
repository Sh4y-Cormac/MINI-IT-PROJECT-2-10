extends Control

@onready var option_button = $"Resolution HboxContainer/Resolution OptionBox" as OptionButton

const RESOLUTION_DICTIONARY : Dictionary = {
	"1152 * 648" : Vector2i(1152, 648),
	"1280 * 720" : Vector2i(1280, 720),
	"1920 * 1080" : Vector2i(1920, 1080)
}

func _ready():
	option_button.item_selected.connect(resolution_selected)
	add_resolution()
	
func add_resolution() -> void:
	for resolution_size in RESOLUTION_DICTIONARY:
		option_button.add_item(resolution_size)
	
	
func resolution_selected(index : int) -> void:
	DisplayServer.window_set_size(RESOLUTION_DICTIONARY.values()[index])
	
