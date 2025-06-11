extends Node2D

var spike_damage = 10

func _on_spike_1_body_entered(body: Node2D) -> void:
	if body.name == "player":
		if body.has_method("take_damage"):
			body.take_damage(spike_damage)
