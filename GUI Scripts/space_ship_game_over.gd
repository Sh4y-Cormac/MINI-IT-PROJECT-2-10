extends Control

func _on_restart_mouse_entered() -> void:
	$"Sound Effects/Hovering Sound Effect".play()

func set_score(value):
	$Panel/GoldEarnedLabel.text = "Gold Earned: " + str(value)
	Global.playerGold += value


func _on_quit_mouse_entered() -> void:
	$"Sound Effects/Hovering Sound Effect".play()
