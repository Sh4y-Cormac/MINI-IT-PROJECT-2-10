extends Control


func _on_restart_pressed() -> void:
	$"Sound Effects/Enter Sound Effect".play()
	await $"Sound Effects/Enter Sound Effect".finished
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_restart_mouse_entered() -> void:
	$"Sound Effects/Hovering Sound Effect".play()

func set_score(value):
	$Panel/GoldEarnedLabel.text = "Gold Earned: " + str(value)


func _on_quit_pressed() -> void:
	$"Sound Effects/Enter Sound Effect".play()
	await $"Sound Effects/Enter Sound Effect".finished
	close()


func _on_quit_mouse_entered() -> void:
	$"Sound Effects/Hovering Sound Effect".play()

func close():
	get_tree().paused = false
	var exist = get_node_or_null("SpaceShooterWindow")
	if exist:
		exist.queue_free()
