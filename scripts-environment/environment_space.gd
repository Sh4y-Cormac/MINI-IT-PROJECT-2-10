extends Node2D


func _process(delta: float) -> void:
	if !Global.playerAlive:
		Global.gameStarted = false
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://GUI Scenes/gameover.tscn")
