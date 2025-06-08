extends Node2D

@onready var laser2_timer = $laserver2_killzone/laser2_timer
@onready var collision_shape = $laserver2_killzone/CollisionShape2D
var player_reference: Node2D = null

func _on_laserver_2_killzone_body_entered(body: Node2D) -> void:
	if body.name == "player":
		var col = body.get_node_or_null("CollisionShape2D")
		if col:
			col.queue_free()
		laser2_timer.start()
		

func _on_laser_2_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
