extends Node2D

func introgame():
	$AnimationPlayer.play("Fade In")
	await get_tree().create_timer(6).timeout
	$AnimationPlayer.play("Fade Out")
	await get_tree().create_timer(3).timeout
	get_tree().change_scene("res://GUI Stuff/StartMenu.tscn")
