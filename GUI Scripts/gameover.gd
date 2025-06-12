extends Control

func _ready():
	Ui.hide()
	$AnimationPlayer.play("Fade In")

func _on_restart_button_mouse_entered() -> void:
	
	$"audio/Hovering Sound Effect".play()
	
func _on_return_to_menu_mouse_entered() -> void:
	$"audio/Hovering Sound Effect".play()


func _on_quit_button_mouse_entered() -> void:
	$"audio/Hovering Sound Effect".play()



func _on_restart_button_pressed() -> void:
	$"audio/Enter Sound Effect".play()
	await $"audio/Enter Sound Effect".finished
	Global.playerHealth = 100
	Functions.load_screen_to_scene("res://scenes-environment/game.tscn")


func _on_return_to_menu_pressed() -> void:
	$"audio/Enter Sound Effect".play()
	await $"audio/Enter Sound Effect".finished
	Functions.load_screen_to_scene("res://GUI Scenes/StartMenu.tscn")


func _on_quit_button_pressed() -> void:
	$"audio/Enter Sound Effect".play()
	await $"audio/Enter Sound Effect".finished
	get_tree().quit()
