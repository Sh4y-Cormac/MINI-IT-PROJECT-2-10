extends Node2D

@onready var spike1_timer = $spike1/Timer
@onready var collision_shape = $spike1/CollisionShape2D
var player_reference: Node2D = null

func _on_spike_1_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.name == "player":
		var col = body.get_node_or_null("CollisionShape2D")
		if col:
			col.queue_free()
		spike1_timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()


func _on_spike_1_body_entered(body: Node2D) -> void:
	if body.name == "player":
		Global.take_damage()
