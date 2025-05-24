extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		$"../AnimationPlayer".play("Shop_Show", -1, 3)
