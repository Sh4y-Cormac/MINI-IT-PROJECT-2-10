extends Window

signal restart

@onready var background = $ParallaxBackground


var scroll_speed = 100

func _process(delta):
	background.scroll_offset.y += delta * scroll_speed
	if background.scroll_offset.y > 500:
		background.scroll_offset.y = 0


func _on_quit_pressed() -> void:
	$"SpaceShooter/UI layer/SpaceShipGameOver/Sound Effects/Enter Sound Effect".play()
	await $"SpaceShooter/UI layer/SpaceShipGameOver/Sound Effects/Enter Sound Effect".finished
	get_tree().paused = false
	queue_free()


func _on_restart_pressed() -> void:
	$"SpaceShooter/UI layer/SpaceShipGameOver/Sound Effects/Enter Sound Effect".play()
	await $"SpaceShooter/UI layer/SpaceShipGameOver/Sound Effects/Enter Sound Effect".finished
	emit_signal("restart")
	queue_free()
	
	PhysicsServer2D.set_active(true)
	
	var spaceshooter = preload("res://GUI Scenes/SpaceShooterWindow.tscn").instantiate()
	
	get_tree().current_scene.add_child(spaceshooter)

func _on_close_requested() -> void:
	get_tree().paused = false
	queue_free()
