extends Control

@export var Options : NinePatchRect
@export var animation_player : AnimationPlayer
@onready var h_slider = $"Options Menu/HSlider" as HSlider

@export_enum("Master", "Music", "SFX") var bus_name : String 

var bus_index : int = 50

func _ready():
	$AnimationPlayer.play("Fade In")

func show_animation(first : String):
	animation_player.play("show_" + first)
	
func hide_animation(first : String):
	animation_player.play("hide_" + first)

enum STATE { FEEDBACK }




func _on_feedback_button_pressed() -> void:
	STATE.FEEDBACK
	$"Enter Sound Effect".play()
	show_animation("feedback")
	$"VBoxContainer/Start Button".disabled = true
	$"VBoxContainer/Customise Button".disabled = true
	$"VBoxContainer/Load Button".disabled = true
	
	
	
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
	$"VBoxContainer/Start Button".disabled = false
	$"VBoxContainer/Customise Button".disabled = false
	$"VBoxContainer/Load Button".disabled = false

func _on_feedback_button_mouse_entered() -> void:
	$"Clicking And Hovering".play()
	
func _on_customise_button_pressed() -> void:
	$"Enter Sound Effect".play()
	await $"Enter Sound Effect".finished
	show_animation("customize")
	$"VBoxContainer/Start Button".disabled = true
	$"VBoxContainer/Customise Button".disabled = true
	$"VBoxContainer/Load Button".disabled = true
	$"Feedback Button".disabled = true
	
func _on_load_button_pressed() -> void:
	$"Enter Sound Effect".play()
	await $"Enter Sound Effect".finished

func _on_save_mouse_entered() -> void:
	$"Clicking And Hovering".play()

func _on_save_pressed() -> void:
	$"Enter Sound Effect".play()
	hide_animation("customize")
	$"VBoxContainer/Start Button".disabled = false
	$"VBoxContainer/Customise Button".disabled = false
	$"VBoxContainer/Load Button".disabled = false
	$"Feedback Button".disabled = false

func _on_exit_button_2_mouse_entered() -> void:
	$"Clicking And Hovering".play()
	
func _on_exit_button_2_pressed() -> void:
	$"Enter Sound Effect".play()
	hide_animation("customize")
	$"VBoxContainer/Start Button".disabled = false
	$"VBoxContainer/Customise Button".disabled = false
	$"VBoxContainer/Load Button".disabled = false
	$"Feedback Button".disabled = false
