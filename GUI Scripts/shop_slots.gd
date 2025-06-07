extends PanelContainer

@onready var icon_node = $Icon

@export var item : Item:
	set(value):
		item = value
		$Icon.texture = item.icon


func _gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if item != null:
			owner.set_description(item)
