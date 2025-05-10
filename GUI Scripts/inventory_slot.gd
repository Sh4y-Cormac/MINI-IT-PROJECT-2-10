extends TextureRect

@export var itemResource : Item

func set_new_data(resource: Item):
	if resource != null:
		itemResource = resource
		texture = itemResource.icon
		itemResource.inventarSlot = get_parent().name
		itemResource.InventarPosition = int(name.split("Slot")[1])
	else:
		itemResource = null
		texture = null
		
func get_slot_name():
	var ParentName = get_parent().name
	var parts = name.split("Slot ")
	
	if parts.size() > 1:
		var slotNumber = parts[1]
		return ParentName + slotNumber
	else:
		return ParentName + "_UnknownSlot"
