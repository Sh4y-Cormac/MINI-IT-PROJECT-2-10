extends Control

@export var Options : NinePatchRect

@export var animation_player : AnimationPlayer

func show_animation(first : String):
	animation_player.play("show_" + first)
	
func hide_animation(first : String):
	animation_player.play("hide_" + first)

enum STATE { FEEDBACK }




func _on_feedback_button_pressed() -> void:
	STATE.FEEDBACK
	$"Enter Sound Effect".play()
	show_animation("feedback")


func _on_start_button_mouse_entered() -> void:
	$"Clicking And Hovering".play()

func _on_customise_button_mouse_entered() -> void:
	$"Clicking And Hovering".play()

func _on_load_button_mouse_entered() -> void:
	$"Clicking And Hovering".play()


func _on_start_button_pressed() -> void:
	$"Enter Sound Effect".play()
	await $"Enter Sound Effect".finished
	get_tree().change_scene_to_file("res://scenes/game.tscn")
	


func _on_exit_button_mouse_entered() -> void:
	$"Clicking And Hovering".play()

func _on_quit_button_mouse_entered() -> void:
	$"Clicking And Hovering".play()

func _on_quit_button_pressed() -> void:
	$"Enter Sound Effect".play()
	await $"Enter Sound Effect".finished
	get_tree().quit()
	
func _on_exit_button_pressed() -> void:
	$"Enter Sound Effect".play()
	hide_animation("feedback")

func _on_feedback_button_mouse_entered() -> void:
	$"Clicking And Hovering".play()
	
func _on_customise_button_pressed() -> void:
	$"Enter Sound Effect".play()
	await $"Enter Sound Effect".finished

func _on_load_button_pressed() -> void:
	$"Enter Sound Effect".play()
	await $"Enter Sound Effect".finished
