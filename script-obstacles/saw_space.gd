extends Node2D

var saw_damage = 10

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		if body.has_method("take_damage"):
			body.take_damage(saw_damage)
