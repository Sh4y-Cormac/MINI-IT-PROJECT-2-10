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
	Global.gameStarted = true
	Global.playerGold = 100
	Global.playerHealth = 100
	Global.level = 0
	Global.difficulty = 1
	Global.playerMaxHealth = 100
	Global.playerSpeedScaling = 1
	Global.playerDamageScaling = 1
	Global.availableJumps = 2
	Functions.load_screen_to_scene("res://scenes-environment/game.tscn")


func _on_return_to_menu_pressed() -> void:
	$"audio/Enter Sound Effect".play()
	await $"audio/Enter Sound Effect".finished
	Functions.load_screen_to_scene("res://GUI Scenes/StartMenu.tscn")


func _on_quit_button_pressed() -> void:
	$"audio/Enter Sound Effect".play()
	await $"audio/Enter Sound Effect".finished
	get_tree().quit()
