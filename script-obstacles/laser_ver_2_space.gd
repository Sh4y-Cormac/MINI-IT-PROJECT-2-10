extends Node2D

var laser2_damage = 10

func _on_laserver_2_killzone_body_entered(body: Node2D) -> void:
	if body.name == "player":
		if body.has_method("take_damage"):
			body.take_damage(laser2_damage)
