extends Control

func _ready():
	Ui.hide()
	$AnimationPlayer.play("Credit_Scene")
	await $AnimationPlayer.animation_finished
	Functions.load_screen_to_scene("res://GUI Scenes/StartMenu.tscn")
