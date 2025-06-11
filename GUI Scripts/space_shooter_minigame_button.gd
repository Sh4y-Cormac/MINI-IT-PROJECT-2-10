extends Area2D


func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		$"../audio/Enter Sound Effect".play()
		await $"../audio/Enter Sound Effect".finished
		start_minigame()


func start_minigame():
	get_tree().paused = true
	PhysicsServer2D.set_active(true)
	
	var spaceshooter = preload("res://GUI Scenes/SpaceShooterWindow.tscn").instantiate()
	
	get_tree().current_scene.add_child(spaceshooter)


func _on_mouse_entered() -> void:
	$"../audio/Hovering Sound Effect".play()
	
