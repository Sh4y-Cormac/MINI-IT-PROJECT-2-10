extends Node

var inventory_ui: Control = null
var inventory_data: Array = []

func register_inventory(ui: Control):
	inventory_ui = ui
	load_inventory()

func add_item(item: Item):
	if inventory_ui:
		inventory_ui.add_item(item)
		save_item_to_data(item)
	

func save_item_to_data(item: Item):
	if item.origin_path == "":
		print("item not found:", item.title)
		return

	inventory_data = inventory_data.filter(func(e):
		return !(e["slot"] == item.inventarSlot and e["pos"] == item.InventarPosition))

	inventory_data.append({
		"path": item.origin_path,
		"slot": item.inventarSlot,
		"pos": item.InventarPosition
	})

func load_inventory():
	for entry in inventory_data:
		var item = load(entry["path"]) as Item
		if item:
			item = item.duplicate()
			item.origin_path = entry["path"]
			item.inventarSlot = entry["slot"]
			item.InventarPosition = entry["pos"]
			inventory_ui.add_item(item)
		
