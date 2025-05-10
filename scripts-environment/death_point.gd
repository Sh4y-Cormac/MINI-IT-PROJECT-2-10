extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("respawn"):
		print("Killzone touched by: ", body.name)
		body.respawn()
