extends Control


var current_scene

@export var inventory : GridContainer

func _on_grid_container_equip(item: Item) -> void:
	if current_scene != null:
		current_scene.currently_equipped = item
