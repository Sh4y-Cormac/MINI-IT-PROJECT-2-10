extends Control

@onready var bagcontainer = $"Inventory GUI/BagSlot"
@onready var Hotbarcontainer = $"Inventory GUI/Hotbar"
@onready var equipment = $"Inventory GUI/Equipment"
@onready var trashcan = $"Inventory GUI/TrashCan/Trash Icon"

var inventoryDict = {}

var items = ["res://GUI Scripts/sword.tres", "res://GUI Scripts/armor.tres"]

func _ready():
	inventoryDict = {
		"BagSlots": bagcontainer,
		"Hotbar": Hotbarcontainer,
		"Equipment": equipment
	}
	
	_refresh_ui()

func add_item(item:Item):
	item.inventarSlot = "BagSlots"
	item.InventarPosition = _get_next_empty_bag_slot()
	
	item.add(item.resource_path)
	
func _get_next_empty_bag_slot():
	for slot in inventoryDict["BagSlots"].get_children():
		if slot.texture == null:
			var slotNumber = int(slot.name.split("Slot")[1])
			return slotNumber


func _get_drag_data(at_position):
	var dragslotnode = get_slot_node_position(at_position)
	
	if dragslotnode == null or dragslotnode.texture == null: return
	
	var dragpreviewnode = dragslotnode.duplicate()
	dragpreviewnode.custom_minimum_size = Vector2(60, 60)
	set_drag_preview(dragpreviewnode)
	
	return dragslotnode


func _can_drop_data(at_position, data):
	var targetslotnode = get_slot_node_position(at_position)
	var onTrashCan = _on_trash_can(at_position)
	
	return targetslotnode != null || onTrashCan

func _drop_data(at_position, dragslotnode):
	var targetslotnode = get_slot_node_position(at_position)
	var targettexture = targetslotnode.texture
	var targetResource = targetslotnode.itemResource
	
	targetslotnode.set_new_data(dragslotnode.itemResource)
	dragslotnode.set_new_data(targetResource)

func get_slot_node_position(position):
	
	var allslotnodes = (bagcontainer.get_children() + Hotbarcontainer.get_children() + equipment.get_children())
	
	for node in allslotnodes:
		var noderect = node.get_global_rect()
		
		if noderect.has_point(position): return node

func _on_trash_can(postition):
	return trashcan.get_global_rect().has_point(position)

func _refresh_ui():
	for item in items:
		item = load(item)
		
		var inventarSlot = item["inventarSlot"]
		var inventarPosition = item["inventarPosition"]
		var icon = item["icon"]
		
		for slot in inventoryDict[inventarSlot].get_children():
			var slotNumber = int(slot.name.split("Slot")[1])
			
			if slotNumber == inventarPosition:
				slot.set_new_data(item)
			
	
