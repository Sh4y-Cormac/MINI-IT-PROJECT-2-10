extends Node2D

@onready var spike_timer = $spike_killzone/Timer
@onready var collision_shape = $spike_killzone/CollisionShape2D
var player_reference: Node2D = null


func _on_spike_killzone_body_entered(body: Node2D) -> void:
	if body.name == "player":
		var col = body.get_node_or_null("CollisionShape2D")
		if col:
			col.queue_free()
		if body.name == "player":
			Global.take_damage()
		spike_timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
