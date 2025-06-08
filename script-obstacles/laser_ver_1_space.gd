extends Node2D

@onready var laser1_timer = $laserver1_killzone/laser1_timer
@onready var collision_shape = $laserver1_killzone/CollisionShape2D
var player_reference: Node2D = null

func _on_laserver_1_killzone_body_entered(body: Node2D) -> void:
	if body.name == "player":
		var col = body.get_node_or_null("CollisionShape2D")
		if col:
			col.queue_free()
		if body.name == "player":
			Global.take_damage()
		laser1_timer.start()

func _on_laser_1_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
