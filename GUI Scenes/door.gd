extends Area2D

@export_file("*.tscn", "*.scn")
var target_scene: String

func _ready():
	pass

func _input(event):
	if event.is_action_pressed("Enter"):
		if !target_scene:
			print("no scene in this door")
			return
		if get_overlapping_bodies().size() > 0:
			next_level()

func next_level():
	var ERR = get_tree().change_scene_to_file(target_scene)
	
	if ERR != OK:
		print("something failedin the door scene")
