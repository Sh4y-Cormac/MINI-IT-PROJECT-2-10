extends Node


const scene_lobby = preload("res://GUI Scenes/ShopIsland.tscn")
const scene_level1 = preload("res://GUI Scenes/insideshop.tscn")

var spawn_door_tag

func go_to_level(level_tag, destination_tag):
	var scene_to_load
	
	match level_tag:
		"lobby":
			scene_to_load = scene_lobby
		
		"level_1":
			scene_to_load = scene_level1
		
	if scene_to_load != null: 
		spawn_door_tag = destination_tag
		get_tree().change_scene_to_packed(scene_to_load)
		
 
