extends Control




func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()

func _on_restart_mouse_entered() -> void:
	pass # Replace with function body.

func set_score(value):
	$Panel/GoldEarnedLabel.text = "Gold Earned: " + str(value)
