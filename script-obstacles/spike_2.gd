extends Node2D

@onready var spike2_timer = $spike2/Timer
@onready var collision_shape = $spike2/CollisionShape2D
var player_reference: Node2D = null

func _on_spike_2_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.name == "player":
		var col = body.get_node_or_null("CollisionShape2D")
		if col:
			col.queue_free()
		spike2_timer.start()
		
func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
