extends Panel

@export var item : Item:
	set(value):
		item = value
		if value != null:
			$Icon.texture = value.icon
			$Price.text = "$ " + str(value.price)
		else:
			$Icon.texture = null
			$Price.text = ""

func _on_gui_input(event):
	if event is InputEventMouseButton and ShopSystem.mode == ShopSystem.MODE.ON:
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_RIGHT:
			pass
