extends Control

signal dropOut

@onready var bagcontainer = $"Inventory GUI/BagSlot"
@onready var ArmorSlot = $"Inventory GUI/Equipment"
@onready var WeaponSlot1 = $"Inventory GUI/Equipment2"
@onready var WeaponSlot2 = $"Inventory GUI/Equipment3"
@onready var trashcan = $"Inventory GUI/TrashCan"
@onready var stats_window: Control = $"Inventory GUI/CanvasLayer/Stats Window"


func get_base_stats() -> Dictionary:
	return{
		"hp": stats_window.hp,
		"atk": stats_window.atk,
		"def": stats_window.def
	}

func get_active_cards() -> Array:
	var cards = []
	for slot in bagcontainer.get_children():
		var item = slot.itemResource
		if item and item.type == "Card":
			cards.append(item)
	return cards

func apply_stat_cards(base: Dictionary, cards: Array) -> Dictionary:
	var result = base.duplicate()
	
	for card in cards:
		if card.effect_type == "flat" and result.has(card.stat_name):
			result[card.stat_name] += card.value
	
	for card in cards:
		if card.effect_type == "percent" and result.has(card.stat_name):
			if result.has(card.stat_name):
				result[card.stat_name] += base[card.stat_name] * card.value
	return result


var inventoryDict = {}
var items = [
	"res://Resources/Items/Short_sword.tres",
	"res://Resources/Items/Sharpness.tres"
	]
var onInventory = false

func _ready():
	inventoryDict = {
		"BagSlot": bagcontainer,
		"Equipment": ArmorSlot,
		"Equipment1": WeaponSlot1,
		"Equipment2": WeaponSlot2
	}
	

	_refresh_ui()

	await get_tree().process_frame
	update_buffed_stats()


func update_buffed_stats():
	var cards = get_active_cards()
	print("Active cards:", cards)
	
	var base = get_base_stats()
	print("Base stats:", base)
	
	var final_stats = apply_stat_cards(base, cards)
	print("Final stats after buffs:", final_stats)
	
	stats_window.update_stats_display(final_stats)

func _get_next_empty_bag_slot() -> int:
	for slot in bagcontainer.get_children():
		if slot.texture == null:
			return int(slot.name.split("Slot")[1])
	return -1

func _refresh_ui():
	for path in items:
		var item = load(path) as Item
	
		var icon = item["icon"]
		
		if item.InventarPosition < 0:
			item.inventarSlot = "BagSlot"
			item.InventarPosition = _get_next_empty_bag_slot()
			if item.InventarPosition < 0:
				continue
				
		var inventarSlot = item["inventarSlot"]
		var inventarPosition = item["InventarPosition"]
		
		var container = inventoryDict.get(item.inventarSlot, null)
		if container:
			for slot in inventoryDict[inventarSlot].get_children():
				var slotNumber = int(slot.name.split("Slot")[1])
				if slotNumber == inventarPosition:
					slot.set_new_data(item)
					break

func add_item(item: Item):
	item.inventarSlot = "BagSlot"
	item.InventarPosition = _get_next_empty_bag_slot()
	
	item.add(item.resource_path)


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
	$".".visible = false



func _on_button_mouse_entered() -> void:
	$"../../audio/Hovering Sound Effect".play()
