extends Control

@onready var bagcontainer = $"Inventory GUI/Bag"
@onready var itemHotbar = $"Inventory GUI/Item Hotbar"
@onready var equiment_left = $"Inventory GUI/Equipment Left"
@onready var equiment_right = $"Inventory GUI/Equipment Right"

func _get_drag_data(at_position):
	var dragslotnode = _get_slot_node_position(at_position)
	
	if dragslotnode.texture == null: return
	
	var dragpreviewnode = dragslotnode.duplicate()
	dragpreviewnode.custom_minimum_size = Vector2(60, 60)
	
	set_drag_preview(dragpreviewnode)
	
	return dragslotnode

func _can_drop_data(at_position, data):
	var targetslot = _get_slot_node_position(at_position)
	
	return targetslot != null

func _drop_item(at_position, dragslotnode):
	var targetslot = _get_slot_node_position(at_position)
	var targettexture = targetslot.texture
	
	targetslot.texture  = dragslotnode.texture
	
	if targetslot == null:
		dragslotnode.texture = null
	
	else:
		dragslotnode.texture = targettexture

func _get_slot_node_position(position):
	var allSlotNodes = (bagcontainer.get_children() + itemHotbar.get_children() 
	+ equiment_left.get_children() + equiment_right.get_children())
	
	for node in allSlotNodes:
		var nodeRect = node.get_global_rect()
		
		if nodeRect.has_point(position): return node
