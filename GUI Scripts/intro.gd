extends Node2D

func _ready():
	$AnimationPlayer.play("Fade in")
	await get_tree().create_timer(4).timeout
	$AnimationPlayer.play("Typewriter")
	await get_tree().create_timer(6).timeout
	$AnimationPlayer.play("Fade out")
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://GUI Scenes/StartMenu.tscn")

func _input(event):
	if event.is_action_pressed("skip_keybind"):
		get_tree().change_scene_to_file("res://GUI Scenes/StartMenu.tscn")
