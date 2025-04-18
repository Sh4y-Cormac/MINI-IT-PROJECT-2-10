extends Control

@export var Options : NinePatchRect
@export var animation_player : AnimationPlayer


func _ready():
	$AnimationPlayer.play("Fade In")


func show_animation(first : String):
	animation_player.play("show_" + first)
	
func hide_animation(first : String):
	animation_player.play("hide_" + first)

enum STATE { FEEDBACK }

func _on_settings_button_pressed() -> void:
	STATE.FEEDBACK
	$"Enter Sound Effect".play()
	show_animation("options")
	$"Main Buttons/Start Button".disabled = true
	$"Main Buttons/Customise Button".disabled = true
	$"Main Buttons/Load Button".disabled = true
	$"Feedback Button".disabled = true

func _on_start_button_mouse_entered() -> void:
	$"Hovering Sound Effect".play()
		
func _on_customise_button_mouse_entered() -> void:
	$"Hovering Sound Effect".play()

func _on_load_button_mouse_entered() -> void:
	$"Hovering Sound Effect".play()


func _on_start_button_pressed() -> void:
	$"Enter Sound Effect".play()
	await $"Enter Sound Effect".finished
	Functions.load_screen_to_scene("res://scenes/game.tscn")

func _on_option_exit_button_mouse_entered() -> void:
	$"Hovering Sound Effect".play()

func _on_quit_button_mouse_entered() -> void:
	$"Hovering Sound Effect".play()

func _on_quit_button_pressed() -> void:
	$"Enter Sound Effect".play()
	await $"Enter Sound Effect".finished
	get_tree().quit()
	
func _on_option_exit_button_pressed() -> void:
	$"Enter Sound Effect".play()
	hide_animation("options")
	$"Main Buttons/Start Button".disabled = false
	$"Main Buttons/Customise Button".disabled = false
	$"Main Buttons/Load Button".disabled = false
	$"Feedback Button".disabled = false

func _on_settings_button_mouse_entered() -> void:
	$"Hovering Sound Effect".play()
	
	
func _on_customise_button_pressed() -> void:
	$"Enter Sound Effect".play()
	await $"Enter Sound Effect".finished
	show_animation("customize")
	$"Main Buttons/Start Button".disabled = true
	$"Main Buttons/Customise Button".disabled = true
	$"Main Buttons/Load Button".disabled = true
	$"Settings Button".disabled = true
	$"Feedback Button".disabled = true
	
func _on_load_button_pressed() -> void:
	$"Enter Sound Effect".play()
	await $"Enter Sound Effect".finished
	show_animation("load")
	$"Main Buttons/Start Button".disabled = true
	$"Main Buttons/Customise Button".disabled = true
	$"Main Buttons/Load Button".disabled = true
	$"Settings Button".disabled = true
	$"Feedback Button".disabled = true

func _on_customize_save_button_mouse_entered() -> void:
	$"Hovering Sound Effect".play()

func _on_customize_save_button_pressed() -> void:
	$"Enter Sound Effect".play()
	hide_animation("customize")
	$"Main Buttons/Start Button".disabled = false
	$"Main Buttons/Customise Button".disabled = false
	$"Main Buttons/Load Button".disabled = false
	$"Settings Button".disabled = false
	$"Feedback Button".disabled = false

func _on_customize_exit_button_mouse_entered() -> void:
	$"Hovering Sound Effect".play()

func _on_customize_exit_button_pressed() -> void:
	$"Enter Sound Effect".play()
	hide_animation("customize")
	$"Main Buttons/Start Button".disabled = false
	$"Main Buttons/Customise Button".disabled = false
	$"Main Buttons/Load Button".disabled = false
	$"Settings Button".disabled = false
	$"Feedback Button".disabled = false

func _on_feedback_button_mouse_entered() -> void:
	$"Hovering Sound Effect".play()

func _on_feedback_button_pressed() -> void:
	$"Enter Sound Effect".play()
	show_animation("feedback")
	$"Main Buttons/Start Button".disabled = true
	$"Main Buttons/Customise Button".disabled = true
	$"Main Buttons/Load Button".disabled = true
	$"Settings Button".disabled = true


func _on_feedback_exit_button_mouse_entered() -> void:
	$"Hovering Sound Effect".play()

func _on_feedback_exit_button_pressed() -> void:
	$"Enter Sound Effect".play()
	hide_animation("feedback")
	$"Main Buttons/Start Button".disabled = false
	$"Main Buttons/Customise Button".disabled = false
	$"Main Buttons/Load Button".disabled = false
	$"Settings Button".disabled = false

func _on_feedback_save_button_mouse_entered() -> void:
	$"Hovering Sound Effect".play()

func _on_feedback_save_button_pressed() -> void:
	$"Enter Sound Effect".play()
	hide_animation("feedback")
	$"Main Buttons/Start Button".disabled = false
	$"Main Buttons/Customise Button".disabled = false
	$"Main Buttons/Load Button".disabled = false
	$"Settings Button".disabled = false

func _on_load_exit_button_mouse_entered() -> void:
	$"Hovering Sound Effect".play()

func _on_load_exit_button_pressed() -> void:
	$"Enter Sound Effect".play()
	hide_animation("load")
	$"Main Buttons/Start Button".disabled = false
	$"Main Buttons/Customise Button".disabled = false
	$"Main Buttons/Load Button".disabled = false
	$"Settings Button".disabled = false
	$"Feedback Button".disabled = false
