extends Node


const scene_outside_shop = preload("res://GUI Scenes/ShopIsland.tscn")
const scene_inside_shop = preload("res://GUI Scenes/insideshop.tscn")

var spawn_door_tag

func go_to_level(level_tag, destination_tag):
	var scene_to_load
	
	match level_tag:
		"Outside Shop":
			scene_to_load = scene_outside_shop
		
		"Inside shop":
			scene_to_load = scene_inside_shop
		
	if scene_to_load != null: 
		spawn_door_tag = destination_tag
		get_tree().change_scene_to_packed(scene_to_load)
		
