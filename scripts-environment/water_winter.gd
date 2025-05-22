extends Area2D

@onready var watertime= $Timer

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		var col = body.get_node_or_null("CollisionShape2D")
		if col:
			col.queue_free()
		watertime.start()


func _on_timer_timeout() -> void:
		Engine.time_scale = 1.0
		get_tree().reload_current_scene()
