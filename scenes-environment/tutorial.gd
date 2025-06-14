extends Node2D

@onready var SceneTransitionAnimation: AnimationPlayer = $SceneTransitionAnimation/AnimationPlayer



func _ready() -> void:
	SceneTransitionAnimation.get_parent().get_node("ColorRect").color.a = 255
	SceneTransitionAnimation.play("fade_out")


func _process(delta: float) -> void:
	if !Global.playerAlive:
		Global.gameStarted = false
		SceneTransitionAnimation.play("fade_in")
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://GUI Scenes/gameover.tscn")


func _on_bag_icon_button_mouse_entered() -> void:
	$"audio/Hovering Sound Effect".play() 
	$AnimationPlayer.play("bag_animation")

func _on_bag_icon_button_mouse_exited() -> void:
	$AnimationPlayer.play_backwards("bag_animation")


func _on_bag_icon_button_pressed() -> void:
	$"audio/Enter Sound Effect".play()
	await $"audio/Enter Sound Effect".finished
	$CanvasLayer/Inventory.visible = true
