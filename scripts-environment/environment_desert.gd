extends Node2D

@onready var fireball_scene = preload("res://scenes-obstacles/fireball_desert.tscn")
@onready var player = $player


func _on_fireball_timer_timeout() -> void:
	var fireball = fireball_scene.instantiate()
  
	var x_pos = player.global_position.x + randf_range(-400, 400)
	var y_pos = player.global_position.y - 300  
	fireball.position = Vector2(x_pos, y_pos)
	
	add_child(fireball)

func _process(delta: float) -> void:
	if !Global.playerAlive:
		Global.gameStarted = false
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://GUI Scenes/gameover.tscn")
