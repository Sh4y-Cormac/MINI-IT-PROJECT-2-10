extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		get_tree().paused = true
		get_node("Shop GUI").play("TransIn")
