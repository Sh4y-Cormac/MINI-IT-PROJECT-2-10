extends Node2D

var laser1_damage = 10

func _on_laserver_1_killzone_body_entered(body: Node2D) -> void:
	if body.name == "player":
		if body.has_method("take_damage"):
			body.take_damage(laser1_damage)
