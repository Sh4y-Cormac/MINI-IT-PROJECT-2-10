extends Control

signal dropOut

@onready var bagcontainer = $"Inventory GUI/BagSlot"
@onready var ArmorSlot = $"Inventory GUI/Equipment"
@onready var WeaponSlot1 = $"Inventory GUI/Equipment2"
@onready var WeaponSlot2 = $"Inventory GUI/Equipment3"
@onready var trashcan = $"Inventory GUI/TrashCan"

var inventoryDict = {}
var items = ["res://Resources/Items/Short_sword.tres"]
var onInventory = false

func _ready():
	inventoryDict = {
		"BagSlot": bagcontainer,
		"Equipment": ArmorSlot,
		"Equipment1": WeaponSlot1,
		"Equipment2": WeaponSlot2
	}
	
	_refresh_ui()

func add_item(item: Item):
	item.inventarSlot = "BagSlot"
	item.InventarPosition = _get_next_empty_bag_slot()
	
	item.add(item.resource_path)

func _get_next_empty_bag_slot():
	for slot in inventoryDict["BagSlot"].get_children():
		if slot.texture == null:
			var slotnumber = int(slot.name.split("Slot")[1])
			return slotnumber

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
	var dragItem = data.itemResource
	
	var itemAllowed = _is_item_allowed(dragItem, targetslotnode)
	
	return targetslotnode != null || onTrashCan || not onInventory && itemAllowed

func _drop_data(at_position, dragslotnode):
	var onTrashCan = _on_trash_can(at_position)
	
	if onTrashCan:
		dragslotnode.set_new_data(null)
	
	elif not onInventory:
		dropOut.emit(dragslotnode.itemResource, at_position)
		dragslotnode.set_new_data(null)
	
	else:
		var targetslotnode = get_slot_node_position(at_position)
		var targettexture = targetslotnode.texture
		var targetResource = targetslotnode.itemResource
		
		targetslotnode.set_new_data(dragslotnode.itemResource)
		dragslotnode.set_new_data(targetResource)

func get_slot_node_position(position):
	
	var allslotnodes = (bagcontainer.get_children() + ArmorSlot.get_children() + WeaponSlot1.get_children() + WeaponSlot2.get_children())
	
	for node in allslotnodes:
		var noderect = node.get_global_rect()
		
		if noderect.has_point(position): return node

func _on_trash_can(position):
	return trashcan.get_global_rect().has_point(position)
	

func _refresh_ui():
	for item in items:
		item = load(item)
		
		var inventarSlot = item["inventarSlot"]
		var inventarPosition = item["InventarPosition"]
		var icon = item["icon"]
		
		for slot in inventoryDict[inventarSlot].get_children():
			var slotNumber = int(slot.name.split("Slot")[1])
			
			if slotNumber == inventarPosition:
				slot.set_new_data(item)

func _is_item_allowed(item, slotNode):
	if slotNode ==  null:return
	
	var slotName = slotNode.get_slot_name()
	var itemType = item.type
	var isequipmentslot = "Equipment" in slotName
	
	if not isequipmentslot: return true
	
	var accessSlot1 = slotName == "Slot 1" &&  itemType == "HeadArmor"
	var accessSlot2 = slotName == "Slot 2" &&  itemType == "Armor"
	var accessSlot3 = slotName == "Slot 3" &&  itemType == "Weapon"
	
	if accessSlot1 || accessSlot2 || accessSlot3:
		return true
	else:
		return false

func _on_inventory_gui_mouse_entered() -> void:
	onInventory = true


func _on_inventory_gui_mouse_exited() -> void:
	onInventory = false



func _on_button_pressed() -> void:
	$"../../audio/Enter Sound Effect".play()
	$"Inventory GUI".visible = false



func _on_button_mouse_entered() -> void:
	$"../../audio/Hovering Sound Effect".play()
