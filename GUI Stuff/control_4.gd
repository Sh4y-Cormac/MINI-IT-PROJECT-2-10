extends Control

@onready var option_button = $"Window Mode HBoxContainer/Window Mode Option Button" as OptionButton

const WINDOW_MODE_ARRAY : Array[String] = [
	"Full Screen",
	"Window Mode",
	"Borderless Window",
	"Borderless Full Screen"
]


func _ready():
	add_window_mode()
	option_button.item_selected.connect(on_window_mode_selected)

func add_window_mode() -> void:
	for mode in WINDOW_MODE_ARRAY:
		option_button.add_item(mode)
		

func on_window_mode_selected(index : int) -> void:
	match index:
		0: #Full Screen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		1: # Window Mode
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		2: #Borderless
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
		3: #Borderless Full Screen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
