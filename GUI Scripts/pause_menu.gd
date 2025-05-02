extends Control

func _ready():
	$AnimationPlayer.play('RESET')

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")

func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")

func testEsc():
	if Input.is_action_just_pressed("esc") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused:
		resume()


func _on_resume_pressed() -> void:
	$"Enter Sound Effect".play()
	await $"Enter Sound Effect".finished
	resume()

func _on_option_pressed() -> void:
	$"Enter Sound Effect".play()
	await $"Enter Sound Effect".finished
	$Options.visible = true
	$Pause.visible = false

	
	
func _on_quit_pressed() -> void:
	$"Enter Sound Effect".play()
	await $"Enter Sound Effect".finished
	get_tree().quit()
	
func _process(delta):
	testEsc()

func _on_resume_mouse_entered() -> void:
	$"Hovering Sound Effect".play()

func _on_option_mouse_entered() -> void:
	$"Hovering Sound Effect".play()

func _on_quit_mouse_entered() -> void:
	$"Hovering Sound Effect".play()


func _on_option_exit_button_pressed() -> void:
	$"Enter Sound Effect".play()
	await $"Enter Sound Effect".finished
	$Options.visible = false
	$Pause.visible = true


func _on_option_exit_button_mouse_entered() -> void:
	$"Hovering Sound Effect".play()


func _on_return_pressed() -> void:
	$"Enter Sound Effect".play()
	await $"Enter Sound Effect".finished
	resume()
	Functions.load_screen_to_scene("res://GUI Scenes/StartMenu.tscn")


func _on_return_mouse_entered() -> void:
	$"Hovering Sound Effect".play()
