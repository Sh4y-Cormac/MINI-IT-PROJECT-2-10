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
