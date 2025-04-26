extends Control

@onready var bagcontainer = $"Inventory GUI/BagSlot"
@onready var Hotbarcontainer = $"Inventory GUI/Hotbar"
@onready var equipment = $"Inventory GUI/Equipment"


func _get_drag_data(at_position):
	var dragslotnode = get_slot_node_position(at_position)
	
	if dragslotnode == null or dragslotnode.texture == null: return
	
	var dragpreviewnode = dragslotnode.duplicate()
	dragpreviewnode.custom_minimum_size = Vector2(60, 60)
	set_drag_preview(dragpreviewnode)
	
	return dragslotnode


func _can_drop_data(at_position, data):
	var targetslotnode = get_slot_node_position(at_position)
	
	return targetslotnode != null

func _drop_data(at_position, dragslotnode):
	var targetslotnode = get_slot_node_position(at_position)
	var targettexture = targetslotnode.texture
	
	targetslotnode.texture  = dragslotnode.texture
	
	if targettexture == null:
		dragslotnode.texture = null
	
	else:
		dragslotnode.texture = targettexture

func get_slot_node_position(position):
	var allslotnodes = (bagcontainer.get_children() + Hotbarcontainer.get_children() + equipment.get_children())
	
	for node in allslotnodes:
		var noderect = node.get_global_rect()
		
		if noderect.has_point(position): return node
