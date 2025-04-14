extends Node2D

func _ready():
	$AnimationPlayer.play("Fade in")
	await get_tree().create_timer(6).timeout
	$AnimationPlayer.play("Typewriter")
	await $AnimationPlayer.animation_finished
	$AnimationPlayer.play("Fade out")
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://GUI Stuff/StartMenu.tscn")
