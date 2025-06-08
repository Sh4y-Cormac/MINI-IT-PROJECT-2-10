extends Node2D

@onready var watertimer = $Sprite2D/waterkill/Timer

func _on_waterkill_body_entered(body: Node2D) -> void:
	if body.name == "player":
		var col = body.get_node_or_null("CollisionShape2D")
		if col:
			col.queue_free()
		if body.name == "player":
			Global.take_damage()
		watertimer.start()

func _on_timer_timeout() -> void:
		Engine.time_scale = 1.0
		get_tree().reload_current_scene()  
		
