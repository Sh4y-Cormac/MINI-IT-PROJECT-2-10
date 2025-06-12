extends Control

signal dropOut

@onready var bagcontainer = $"Inventory GUI/BagSlot"
@onready var ArmorSlot = $"Inventory GUI/Equipment"
@onready var trashcan = $"Inventory GUI/TrashCan"
#@onready var stats_window: Control = $"Inventory GUI/Stats Window"
#@onready var card_symbol: HBoxContainer = $"../CardSymbol"
#@export var card_icon: Texture


#func update_card_ui():
#	var cards = get_active_cards()
#	var container = $"../CardSymbol"
#
#	for child in container.get_children():
#		child.queue_free()
#		
#	var card_counts := {}
#	for slot in bagcontainer.get_children():
#		var item = slot.itemResource
#		if item and item.type == "Card":
#			var key = item.resource_path 
#			if card_counts.has(key):
#				card_counts[key]["count"] += 1
#			else:
#				card_counts[key] = {"item": item, "count": 1}

#	for entry in card_counts.values():
#		var card = entry["item"]
#		var count = entry["count"]
#		
#		if card.card_icon:
#			var icon = TextureRect.new()
#			icon.texture = card.card_icon
#			icon.expand_mode = TextureRect.EXPAND_KEEP_SIZE
#			icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
#			icon.custom_minimum_size = Vector2(32, 32)
#			icon.tooltip_text = card.name
#			container.add_child(icon)

#			if count > 1:
#				var label = Label.new()
#				label.text = "x" + str(count)
#				label.add_theme_color_override("font_color", Color.WHITE)
#				label.add_theme_font_size_override("font_size", 12)
#				label.set_anchors_preset(Control.PRESET_BOTTOM_RIGHT)
#				label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
#				label.vertical_alignment = VERTICAL_ALIGNMENT_BOTTOM
#				icon.add_child(label)

#func get_active_card_counts() -> Dictionary:
#	var counts := {}
#	for slot in bagcontainer.get_children():
#		var item = slot.itemResource
#		if item and item.type == "Card":
#			var id = item.resource_path  
#			if counts.has(id):
#				counts[id]["count"] += 1
#			else:
#				counts[id] = {"item": item, "count": 1}
#	return counts
	
#func get_base_stats() -> Dictionary:
#	return{
#		"hp": stats_window.hp,
#		"atk": stats_window.atk,
#		"def": stats_window.def
#	}

#func get_active_cards() -> Array:
#	var cards = []
#	for slot in bagcontainer.get_children():
#		var item = slot.itemResource
#		if item and item.type == "Card":
#			cards.append(item)
#	return cards

#func apply_stat_cards(base: Dictionary, cards: Array) -> Dictionary:
#	var result = base.duplicate()
#	
#	for card in cards:
#		if card.effect_type == "flat" and result.has(card.stat_name):
#			result[card.stat_name] += card.value
	
#	for card in cards:
#		if card.effect_type == "percent" and result.has(card.stat_name):
#			if result.has(card.stat_name):
#				result[card.stat_name] += base[card.stat_name] * card.value
#	return result


var inventoryDict = {}
var items = [
	"res://Resources/Items/Short_sword.tres",
	"res://Resources/Items/Long_sword.tres",
	"res://Resources/Items/Apple.tres",
	"res://Resources/Items/Apple_Slice.tres",
	"res://Resources/Items/Blue_Popsicle.tres",
	"res://Resources/Items/Coffee.tres",
	"res://Resources/Items/Green_Popsicle.tres",
	"res://Resources/Items/IceCream1.tres",
	"res://Resources/Items/IceCream2.tres"
	#"res://Resources/Items/Sharpness.tres",
	#"res://Resources/Items/Atk_up.tres",
	#"res://Resources/Items/Hp up.tres",   
	#"res://Resources/Items/Armor Plate.tres",
	#"res://Resources/Items/Hp potions.tres",
	#"res://Resources/Items/Regeneration.tres",
	#"res://Resources/Items/LifeSteal.tres",
	]
var onInventory = false

func _ready():
	
	InventoryManager.register_inventory(self)
#	stats_window.visible = true
	inventoryDict = {
		"BagSlot": bagcontainer,
		"Equipment": ArmorSlot,
	}
	
#	await get_tree().process_frame
#	apply_regen_cards()
	

	_refresh_ui()

#	await get_tree().process_frame
	
#	stats_window.connect("leveled_up", Callable(self, "update_buffed_stats"))
#	update_buffed_stats()
	
#	await get_tree().process_frame
#	update_card_ui()

	
#func apply_regen_cards():
#	for slot in bagcontainer.get_children():
#		var item = slot.itemResource
#		if item and item.is_regen_card:
#			stats_window.apply_regen_card(item)
#			print("Regen card applied:", item.name)
#			break  # Only apply one regen card (optional)
			
#func get_lifesteal_percent() -> float:
#	for slot in bagcontainer.get_children():
#		var item = slot.itemResource
#		if item and item.is_lifesteal_card:
#			print("Lifesteal card found:", item.name)
#			return item.lifesteal_percent
	return 0.0
	
#func update_buffed_stats():
#	var cards = get_active_cards()
#	print("Active cards:", cards)
#	
#	var base = get_base_stats()
#	print("Base stats:", base)
#	
#	var final_stats = apply_stat_cards(base, cards)
#	print("Final stats after buffs:", final_stats)
#	
#	stats_window.update_stats_display(final_stats)
#	stats_window.set_lifesteal(get_lifesteal_percent())

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

	if item.InventarPosition < 0:
		print("Inventory full!")
		return

	for slot in inventoryDict["BagSlot"].get_children():
		var slotNumber = int(slot.name.split("Slot")[1])
		if slotNumber == item.InventarPosition:
			slot.set_new_data(item)
			break
	
	#update_buffed_stats()
	#update_card_ui()

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
	
	return targetslotnode != null || onTrashCan || not onInventory

func _drop_data(at_position, dragslotnode):
	var onTrashCan = _on_trash_can(at_position)
	
	if onTrashCan:
		dragslotnode.delete_resource()
	
	elif not onInventory:
		dropOut.emit(dragslotnode.itemResource, at_position)
		dragslotnode.delete_resource()
	
	else:
		var targetslotnode = get_slot_node_position(at_position)
		var targettexture = targetslotnode.texture
		var targetResource = targetslotnode.itemResource
		
		targetslotnode.set_new_data(dragslotnode.itemResource)
		dragslotnode.set_new_data(targetResource)
		
	#update_buffed_stats()

func get_slot_node_position(position):
	
	var allslotnodes = (bagcontainer.get_children() + ArmorSlot.get_children())
	
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
	
	var accessSlot1 = slotName == "Equipment_Slot1" &&  itemType == "Weapon"
	var accessSlot2 = slotName == "Equipment_Slot2" &&  itemType == "Armor"
	var accessSlot3 = slotName == "Equipment_Slot3" &&  itemType == "Weapon"
	
	if accessSlot1 || accessSlot2 || accessSlot3:
		return true
	else:
		return false



func _on_button_pressed() -> void:
	$"../audio/Enter Sound Effect".play()
	await $"../audio/Enter Sound Effect".finished
	$".".visible = false
	#stats_window.visible = false

func _on_button_mouse_entered() -> void:
	$"../audio/Hovering Sound Effect".play()


func _on_inventory_gui_mouse_entered() -> void:
	onInventory = true


func _on_inventory_gui_mouse_exited() -> void:
	onInventory = false
	
