extends Control

@export var Options : NinePatchRect

@export var animation_player : AnimationPlayer

func hide_and_show(first : String):
	animation_player.play("show_" + first)

enum STATE { FEEDBACK }


func _on_feedback_button_pressed() -> void:
	STATE.FEEDBACK
	$"Clicking And Hovering".play()
	hide_and_show("feedback")


func _on_start_button_mouse_entered() -> void:
	$"Clicking And Hovering".play()

func _on_customise_button_mouse_entered() -> void:
	$"Clicking And Hovering".play()

func _on_load_button_mouse_entered() -> void:
	$"Clicking And Hovering".play()


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")
