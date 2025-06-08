extends Node2D

@onready var icetimer = $Sprite2D/ice_kill/ice_timer

func _on_ice_kill_body_entered(body: Node2D) -> void:
	if body.name == "player":
		var col = body.get_node_or_null("CollisionShape2D")
		if col:
			col.queue_free()
		if body.name == "player":
			Global.take_damage()
		icetimer.start()


func _on_ice_timer_timeout() -> void:
		Engine.time_scale = 1.0
		get_tree().reload_current_scene()  
