extends Panel

@export var item : Item = null:
	set(value):
		item = value
		
		if value == null:
			$Icon.texture = null
			return
		
		$Icon.texture = value.icon

@export var amount : int = 0:
	set(value):
		amount = value
		$Amount.text = str(value)
		if amount <= 0:
			item = null

func set_amount(value: int):
	amount = value

func add_amount(value : int):
	amount += value

func _can_drop_data(_at_position, data):
	if "item" in data:
		return is_instance_of(data.item, Item)
	return false

func _drop_data(_at_position, data):
	var temp = item
	item = data.item
	data.item = temp
	
	temp = amount
	amount = data.amount
	data.amount = temp


func _get_drag_data(_at_position):
	if item:
		var preview_texture = TextureRect.new()
		
		preview_texture.texture = item.icon
		preview_texture.size = Vector2(50, 50)
		preview_texture.position = -Vector2(8, 8)
		
		var preview = Control.new()
		preview.add_child(preview_texture)
		set_drag_preview(preview)
		
	return self
