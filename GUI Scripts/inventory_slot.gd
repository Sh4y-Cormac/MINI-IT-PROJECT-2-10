extends TextureRect

@export var itemResource : Item


func set_new_data(resource: Item):
	itemResource = resource
	
	if resource != null:
		texture = itemResource.icon
		itemResource.inventarSlot = get_parent().name
		itemResource.InventarPosition = int(name.split("Slot")[1])
	else:
		itemResource = null
		texture = null


func get_slot_name():
	var parentName = get_parent().name
	var slotNumber = name.split("Slot")[1]
	return parentName + slotNumber


func delete_resource():
	if itemResource:
		InventoryManager.inventory_data = InventoryManager.inventory_data.filter(func(e):
			return !(e["slot"] == itemResource.inventarSlot and e["pos"] == itemResource.InventarPosition)
		)

	
	texture = null
	itemResource = null


func _gui_input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.pressed and event.double_click:
			if itemResource:
				itemResource.use() 
				delete_resource() 
