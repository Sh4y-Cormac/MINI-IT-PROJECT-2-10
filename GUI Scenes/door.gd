extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _input(event):
	if event.is_action_pressed("Enter"):
		print(get_overlapping_bodies().size())
