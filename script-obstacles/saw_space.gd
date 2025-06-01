extends Node2D

@onready var saw_timer = $saw_killzone/saw_timer
@onready var collision_shape = $saw_killzone/CollisionShape2D
var player_reference: Node2D = null

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		var col = body.get_node_or_null("CollisionShape2D")
		if col:
			col.queue_free()
		saw_timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
