extends Node

var inventory_ui: Control = null

func register_inventory(ui: Control):
	inventory_ui = ui

func add_item(item: Item):
	if inventory_ui:
		inventory_ui.add_item(item)
	else:
		push_error("Inventory UI not registered!")
