extends Node2D

@onready var saw_timer = $saw_killzone/saw_timer

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		$saw_killzone/CollisionShape2D.disabled = true
		saw_timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
